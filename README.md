# Terraform AWS Infrastructure

Este repositório contém a configuração do Terraform para criar uma infraestrutura AWS que inclui uma instância EC2, um Load Balancer (ELB), um CloudFront Distribution e a configuração do Docker para rodar um contêiner Nginx.

## Estrutura do Repositório

- `ec2.tf`: Define a instância EC2 e o grupo de segurança.
- `elb.tf`: Define o Load Balancer (ELB) e o Target Group.
- `cloudfront.tf`: Define o CloudFront Distribution que redireciona o tráfego para o Load Balancer.
- `outputs.tf`: Define os outputs do Terraform, incluindo a URL do CloudFront.
- `variables.tf`: Define as variáveis utilizadas na configuração do Terraform.

## Pré-requisitos

- [Terraform](https://www.terraform.io/downloads.html) instalado.
- Credenciais AWS configuradas (via `aws configure` ou variáveis de ambiente).

## Variáveis de Configuração

As variáveis são definidas no arquivo `variables.tf`. Aqui estão algumas das principais variáveis que você pode configurar:

- `ami_id`: ID da AMI a ser utilizada para a instância EC2.
- `instance_type`: Tipo da instância EC2 (por exemplo, `t2.micro`).
- `vpc_id`: ID da VPC onde os recursos serão criados.
- `subnet_public`: Lista de IDs das subnets públicas.
- `subnet_private`: Lista de IDs das subnets privadas.

## Executando o Código

1. Clone o repositório:
    ```sh
    git clone https://github.com/seu-usuario/seu-repositorio.git
    cd seu-repositorio
    ```

2. Inicialize o Terraform:
    ```sh
    terraform init
    ```

3. Visualize o plano de execução:
    ```sh
    terraform plan
    ```

4. Aplique o plano:
    ```sh
    terraform apply
    ```

## Descrição do Docker Utilizado

O script `user_data` na configuração da instância EC2 instala o Docker e configura um contêiner Nginx. Aqui está o que o script faz:

1. Atualiza o sistema.
2. Instala o Docker e o Git.
3. Inicia o serviço Docker e habilita-o para iniciar automaticamente.
4. Cria um arquivo `index.html` com a mensagem "nginx de Iure Radin: Link".
5. Baixa a imagem do Nginx e roda um contêiner Nginx, montando o arquivo `index.html` no contêiner.

## Outputs

Após a execução do Terraform, você verá os seguintes outputs:

- `subnet_private_id`: IDs das subnets privadas.
- `subnet_public_id`: IDs das subnets públicas.
- `instance_id`: ID da instância EC2.
- `cloudfront_url`: URL do CloudFront Distribution.

## Limpeza

Para destruir a infraestrutura criada, execute:
```sh
terraform destroy