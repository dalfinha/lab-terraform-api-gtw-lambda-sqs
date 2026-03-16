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
    try:
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
    except Exception as e:
        return handler_error(event, context)

def handler_error(event, context):
    order = {}
    return {
        "statusCode": 500,
        "body": json.dumps({
            "message": "Erro ao processar pedido. Para troubleshooting: 1 - Verifique as permissões de acesso a fila SQS; 2 - Verifique a URL da fila SQS; 3 - Verifique mudanças no contrato OpenAPI da API.",
            "order": order
        })
    }