import json
import os
import boto3

sqs = boto3.client("sqs")

QUEUE_URL = os.environ["QUEUE_URL"]

def handler(event, context):

    body = json.loads(event.get("body", "{}"))

    order = {
        "order_id": body.get("order_id"),
        "product": body.get("product"),
        "value": body.get("value")
    }

    sqs.send_message(
        QueueUrl=QUEUE_URL,
        MessageBody=json.dumps(order)
    )

    return {
        "statusCode": 200,
        "body": json.dumps({
            "message": "Pedido enviado para a Fila SQS.",
            "order": order
        })
    }