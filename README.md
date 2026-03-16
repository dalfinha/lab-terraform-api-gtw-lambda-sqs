# 🏗️ Playground: lab-terraform-api-gtw-lambda-sqs 

## O que é esse projeto? 

Esse é um pequeno laboratório prático de **Infraestrutura como Código** para aprender a provisionar uma arquitetura **serverless event-driven** na AWS usando **Terraform**. Este é um projeto base **pronto para clonar, estudar e evoluir** com novos desafios de resiliência, segurança e observabilidade - boas práticas com o pilar WAF da AWS.

A arquitetura implementa um sistema assíncrono de **processamento de pedidos**, integrando API Gateway, AWS Lambda (Python 3.13) e SQS. Inclui plano de teste com **JMeter** para validar performance sob carga, que você pode baixar e importar no Apache JMeter.

---

## 🌐 Visão Geral

Este projeto implementa um **sistema assíncrono de enfileiramento de pedidos** onde:

1. **Cliente** faz POST com dados do pedido
2. **API Gateway** roteia as requisições para a **Lambda**
3. **Lambda** valida e enfileira mensagem no **SQS**
4. **SQS** persiste a mensagem e pode rotear para outros serviços da AWS

**Benefícios da arquitetura:**
- ✅ Desacoplamento entre cliente e processador
- ✅ Auto-scaling automático (sem gerenciar servidores)
- ✅ Resiliência (retry automático de falhas)
- ✅ Custo reduzido (pay-per-use)

---

## 🔎 Exemplo de Payload de Resposta

```json
{
  "message": "Pedido enviado para a Fila SQS.",
  "order": {
    "order_id": "001",
    "product": "Widget Pro",
    "value": 99
  }
}
```

---

## 📂 Estrutura de Pastas

```
.
├── README.md                                    # Este arquivo
├── code/
│   ├── lambda_function.py                      # Handler da função Lambda
│   └── requirements.txt                        # Dependências Python (boto3)
│
├── infra/
│   ├── api-gtw.tf                              # Módulo API Gateway HTTP
│   ├── lambda.tf                               # Módulo Lambda Function
│   ├── sqs.tf                                  # Módulo SQS Queue
│   ├── lambda-permissions.tf                   # Permissões IAM Lambda ↔ SQS
│   ├── locals.tf                               # Variáveis locais (tags)
│   ├── variables.tf                            # Input variables
│   ├── outputs.tf                              # Outputs da infraestrutura
│   ├── versions.tf                             # Provider versions
│   ├── data.tf                                 # Data sources (Account ID, Region)
│   │
│   ├── api/
│   │   └── api-lab-terraform-api-gtw-lambda-sqs.yaml    # Spec OpenAPI
│   │
│   ├── inventories/
│       └── terraform.tfvars                    # Variáveis de ambiente
│
└── jmeter/
    └── lab-api-lambda-sqs.jmx                  # Plano de teste de carga
```

---

## ✅ Pré-requisitos

- ✅ Conta AWS ativa (mesmo sendo free-tier)
- ✅ Terraform >= 1.5.0
- ✅ AWS CLI configurado com usuário específico com permissões para deploy via Terraform
- ✅ JMeter 5.5+ (para testes de carga) 

> [!ATTENTION] 
> Ter o Java instalado é muito importante para o funcionamento básico do Jmeter

---

## 🚀 Quick Start

### 1. Clone e entre no diretório

```bash
git clone https://github.com/seu-usuario/lab-terraform-api-gtw-lambda-sqs.git
cd lab-terraform-api-gtw-lambda-sqs/infra
```

### 2. Configure variáveis

```bash
# Edite o arquivo de variáveis no seu editor de arquivo de preferencia
inventories/terraform.tfvars
```

**Conteúdo esperado:**
```hcl
environment  = "dev"
region       = "us-east-1"
project_name = "lab-terraform-workshop"
```

### 3. Deploy da infraestrutura

```bash
terraform init
terraform validate
terraform plan
terraform apply -var-file="inventories/terraform.tfvars"
```

### 4. Capture os outputs

```bash
terraform output
# Outputs:
# api_endpoint = "https://xxxxx.execute-api.us-east-1.amazonaws.com/dev/orders"
# lambda_function_name = "lambda-lab-terraform-workshop"
# sqs_queue_url = "https://sqs.us-east-1.amazonaws.com/123456789/sqs-queue-..."
```

### 5. Teste o endpoint

```bash
curl -X POST https://xxxxxxxxxxxxx.execute-api.us-east-1.amazonaws.com/dev/orders \
  -H "Content-Type: application/json" \
  -d '{"order_id":"001","product":"Widget","value":99.99}'
```

---

## 🧪 Testes de Carga com JMeter

O arquivo **[jmeter/lab-api-lambda-sqs.jmx](jmeter/lab-api-lambda-sqs.jmx)** contém um plano de teste configurado. Para executar esse teste de carga, é necessário ter o Apache Jmeter instalado, conforme os pré requisitos. 

Substitua as variáveis do teste para a URL da API e quantidade de threads que deseja. 


## 🎓 Desafios para Evolução

Este é um projeto **base para aprender a usar o Terraform**. Aqui estão desafios progressivos para expandir seus conhecimentos de Terraform:

### 🟢 Tier 1 - Essencial (Comece por aqui)

- [ ] **Validação de Entrada com JSON Schema**
  - Difficulty: ⭐ Básico
  - Adicionar validação de payload no `lambda_function.py`
  - [Ver referência](code/lambda_function.py)

- [ ] **Dead Letter Queue (DLQ) no SQS**
  - Difficulty: ⭐⭐ Intermediário 
  - Criar fila de Dead Letter e configurar retenção de falhas
  - Arquivos: `infra/sqs.tf`, `infra/outputs.tf`

### 🟡 Tier 2 - Importante (Próximo nível)

- [ ] **Encryption no SQS com KMS**
  - Difficulty: ⭐⭐ Intermediário 
  - Habilitar criptografia em repouso com AWS KMS. Crie um novo arquivo chamado `kms.tf` e crie via Terraform uma Key para criptografar os dados do SQS, adicionando em seguida, parâmetros para a fila SQS utilizar o KMS. 
  - Arquivo: `infra/sqs.tf`

- [ ] **CloudWatch Alarms para Monitoramento**
  - Difficulty: ⭐⭐ Intermediário
  - Criar alarmes para erros de Lambda e tamanho da fila. Você pode integrar os alarmes a um SNS com assinatura de email para ter alarmes proativos!
  - Novo arquivo: `infra/alarms.tf`

- [ ] **Validação de Request no API Gateway**
  - Difficulty: ⭐⭐ Intermediário
  - Adicionar JSON Schema validation no OpenAPI spec
  - Arquivo: `infra/api/api-lab-terraform-api-gtw-lambda-sqs.yaml`

### 🔴 Tier 3 - Avançado (Desafio extra)

- [ ] **FIFO Queue com Idempotência**
  - Difficulty: ⭐⭐⭐ Avançado
  - Migrar para SQS FIFO e implementar deduplication
  - Arquivos: `infra/sqs.tf`, `code/lambda_function.py`

- [ ] **Lambda Concurrency Limits e Versioning**
  - Difficulty: ⭐⭐⭐ Avançado
  - Configurar concorrência reservada e aliases
  - Arquivo: `infra/lambda.tf`

- [ ] **Logging do API Gateway em CloudWatch**
  - Difficulty: ⭐⭐⭐ Avançado
  - Implementar logs estruturados de todas as requisições, sem expor conteúdo sensível.
  - Novo arquivo: `infra/api-logs.tf`

---

## 📌 Observações Importantes

- A infraestrutura usa **módulos do Terraform AWS Registry** - atualizações frequentes
- SQS tem **retenção de 24 horas** por padrão (configurável)
- Lambda **timeout padrão é 3s** - aumentar se necessário em `infra/lambda.tf`
- O **estado do Terraform está versionado** no repo (apenas para lab) - em produção, use um S3 remote state
- Componentes são **independentes** - é possível modificar cada um separadamente
- Sempre executar `terraform plan` antes de `terraform apply` para visualizar possíveis erros
---

## 📚 Recursos Adicionais

- 📖 [Terraform AWS Modules - API Gateway](https://registry.terraform.io/modules/terraform-aws-modules/apigateway-v2/aws/)
- 📖 [Terraform AWS Modules - Lambda](https://registry.terraform.io/modules/terraform-aws-modules/lambda/aws/)
- 📖 [Terraform AWS Modules - SQS](https://registry.terraform.io/modules/terraform-aws-modules/sqs/aws/)
- 📖 [AWS Lambda Best Practices](https://docs.aws.amazon.com/lambda/)
- 📖 [Amazon SQS Documentation](https://docs.aws.amazon.com/sqs/)
- 📖 [Apache JMeter Guide](https://jmeter.apache.org/usermanual/)
- 📖 [Terraform Best Practices](https://www.terraform.io/language/functions)

---

## ❌ Encontrou um bug ou tem sugestões?

Abra uma **issue** ou faça um **pull request**. Contribuições são bem-vindas! Use a issue para solicitar ajuda, em caso de auxílio em um troubleshooting. 
