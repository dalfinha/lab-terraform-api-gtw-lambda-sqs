import boto3
import os

sqs = boto3.client('sqs')

QUEUE_URL = os.environ['QUEUE_URL']