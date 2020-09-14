#!/usr/bin/python3.6
import urllib3
import json
http = urllib3.PoolManager()
def lambda_handler(event, context):
    url = "${webhook_url}"

    message = json.loads(event['Records'][0]['Sns']['Message'])
    text = f"""\nEvent: {message['Event']} \n\nAccount Id: {message['AccountId']}\nService: {message['Service']}\nInstance Id: {message['EC2InstanceId']}\nAsg Name: {message['AutoScalingGroupName']}\nCause: {message['Cause']}\n"""

    msg = {
        "channel": "${slack_channel}",
        "username": "${slack_username}",
        "text": text,
        "icon_emoji": ""
    }
    
    encoded_msg = json.dumps(msg).encode('utf-8')
    resp = http.request('POST',url, body=encoded_msg)
    print({
        "message": event['Records'][0]['Sns']['Message'], 
        "status_code": resp.status, 
        "response": resp.data
    })