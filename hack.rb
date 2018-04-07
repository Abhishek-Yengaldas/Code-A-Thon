require 'aws-sdk'
require 'json'
require 'net/http'
require 'uri'

uri = URI.parse("http://169.254.169.254/latest/meta-data/network/interfaces/macs/")
response = Net::HTTP.get_response(uri)
url= URI.parse("http://169.254.169.254/latest/meta-data/network/interfaces/macs/#{response.body}security-group-ids")
response = Net::HTTP.get_response(url)
sg_id = response.body
ec2 = Aws::EC2::Client.new(region: 'us-east-1')
ec2.revoke_security_group_ingress({
                                      group_id: sg_id,
                                      ip_permissions: [
                                          {
                                              ip_protocol: "tcp",
                                              from_port: 22,
                                              to_port: 22,
                                              ip_ranges: [
                                                  {
                                                      cidr_ip: "72.196.48.126/32",
                                                  },
                                              ]
                                          }
                                      ]
                                  })