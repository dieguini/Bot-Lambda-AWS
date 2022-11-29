import json
import boto3
from datetime import datetime

s3=boto3.resource('s3')

def lambda_handler(event, context):
    print(event)
    print(context)
    
    #Process 'even't to get 'records' (contains file events comming from s3)
    records = event['Records']
    for record in records:
        bucket = record['s3']['bucket']['name']
        key = record['s3']['object']['key']
        print(f"bucket", bucket, "key", key)
        
    #get filename and extension
    filename = key.split('/')[-1].split('.')[0]
    extension = key.split('/')[-1].split('.')[1]

    #get timestamp
    timestamp = datetime.now().strftime("%Y%m%d%H%M%S")

    #create target_key
    target_key = f"output_data/{filename}_{timestamp}.{extension}"

    target_bucket = "s3-monitoring-andresgb"
  
    s3.meta.client.copy({
        "Bucket": bucket,
        "Key": key
    }, target_bucket, target_key)
    
    return {
        'statusCode': 200,
        'body': json.dumps('OK')
    }