import boto3
import sys
import os

macid = os.popen("curl -s curl http://169.254.169.254/latest/meta-data/network/interfaces/macs/").read()
url = "curl -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/"+macid+"security-group-ids"
sg_id = os.popen(url).read()
region = "us-east-1"
            client.revoke_security_group_ingress(
                GroupId=sg_id,
                IpPermissions=[
                    {
                        'IpProtocol': "tcp",
                        'FromPort': 22,
                        'ToPort': 22,
                        'IpRanges': [
                            {
                                'CidrIp': '72.196.48.126/32'
                            }
                       ]
                    }
                ]
            )

