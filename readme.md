![!bitcoinNode](./bitcoinnode.jpeg)


**[English below]**

# Bitcoin Node em AWS EC2 com Terraform e Ansible

Este projeto implementa um nó Bitcoin na AWS EC2 usando Terraform para provisionar a infraestrutura e Ansible para configurar o nó.

## Estrutura do projeto

```
bitcoin-node-aws-ec2/
│
├── ansible/│
│   ├── ansible.cfg
│   ├── hosts.ini
│   └── install_bitcoin_node.yml
│
├── terraform/
    ├── modules/
        ├── security_group/
            ├── main.tf
            ├── variables.tf
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── locals.tf
│
├── .gitignore
├── README.md
└── LICENSE
```

## Requisitos

- [Terraform](https://www.terraform.io/downloads.html) (versão 0.13 ou superior)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) (versão 2.9 ou superior)
- [Conta AWS](https://aws.amazon.com/) com as credenciais configuradas corretamente
- Chave SSH existente na AWS e em seu sistema local

## Como usar

1. Clone este repositório:

   ```
   git clone https://github.com/ffelipesimoes/bitcoin-node-aws-ec2.git
   cd bitcoin-node-aws-ec2/
   ```

2. Configure suas credenciais da AWS usando o AWS CLI:

   ```
   aws configure
   ```

3. Edite o arquivo `variable.tf` e atualize o path da sua chave pública dentro do bloco ` public_key_path` para o path da chave que você usa.

4. Navegue até o diretório `terraform/` e inicialize o Terraform:

   ```
   cd terraform/
   terraform init
   ```

5. Verifique o plano de execução do Terraform e confirme se está correto:

   ```
   terraform plan
   ```

6. Aplique as configurações do Terraform para criar a infraestrutura na AWS:

   ```
   terraform apply
   ```

7. Após a conclusão do Terraform, navegue até o diretório `ansible/`:

   ```
   cd ../ansible/
   ```

8. Atualize o arquivo `hosts.ini` com o IP público da instância EC2 criada pelo Terraform. Você pode encontrar o IP no arquivo `terraform/terraform.tfstate`.

9. Execute o playbook do Ansible para configurar o nó Bitcoin:

   ```
   ansible-playbook -i hosts.ini install_bitcoin_node.yml
   ```

Após a execução bem-sucedida do playbook, seu nó Bitcoin estará em funcionamento no contêiner `bitcoind` na instância EC2 da AWS.

## Explicação

Este projeto cria uma instância EC2 na AWS usando o Terraform com as seguintes configurações de segurança:

- Permitir tráfego SSH (porta 22)
- Permitir tráfego HTTP (porta 80)
- Permitir tráfego HTTPS (porta 443)
- Permitir tráfego de saída
- Permitir tráfego RPC do Bitcoin (porta 8332)
- Permitir tráfego P2P do Bitcoin (porta 8333)
- Permitir tráfego de notificações de blocos ZMQ (porta 28332)
- Permitir tráfego de notificações de transações ZMQ (porta 28333)

O playbook do Ansible configura o nó Bitcoin executando as seguintes etapas:

- Atualiza os pacotes do sistema
- Instala o Docker
- Inicia e habilita o serviço Docker
- Baixa a imagem `lncm/bitcoind:v25.0`
- Executa um contêiner usando a imagem `lncm/bitcoind:v25.0`, expondo as portas necessárias e vinculando o volume `bitcoin-data`.


## Contribuindo

Sinta-se à vontade para contribuir com este projeto abrindo issues ou enviando pull requests.

## Licença

Este projeto está licenciado sob a Licença MIT. Consulte o arquivo [LICENSE](LICENSE) para obter detalhes.


## Melhorias futuras

Subir esse conteiner usando AWS Fargate ou ECS.


**[Português acima]**


# Bitcoin Node on AWS EC2 with Terraform and Ansible

This project implements a Bitcoin node on AWS EC2 using Terraform to provision the infrastructure and Ansible to configure the node.

## Project Structure

```
bitcoin-node-aws-ec2/
│
├── ansible/
│   ├── ansible.cfg
│   ├── hosts.ini
│   └── install_bitcoin_node.yml
│
├── terraform/
    ├── modules/
        ├── security_group/
            ├── main.tf
            ├── variables.tf
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── locals.tf
│
├── .gitignore
├── README.md
└── LICENSE
```

## Requirements

- [Terraform](https://www.terraform.io/downloads.html) (version 0.13 or higher)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) (version 2.9 or higher)
- [AWS Account](https://aws.amazon.com/) with correctly configured credentials
- Existing SSH key on AWS and your local system

## How to use

1. Clone this repository:

   ```
   git clone https://github.com/ffelipesimoes/bitcoin-node-aws-ec2.git
   cd bitcoin-node-aws-ec2/
   ```

2. Configure your AWS credentials using AWS CLI:

   ```
   aws configure
   ```

3. Edit the `variable.tf` file and update the path of your public key within the `public_key_path` block to the path of the key you use.

4. Navigate to the `terraform/` directory and initialize Terraform:

   ```
   cd terraform/
   terraform init
   ```

5. Check the Terraform execution plan and confirm if it is correct:

   ```
   terraform plan
   ```

6. Apply the Terraform configurations to create the AWS infrastructure:

   ```
   terraform apply
   ```

7. After Terraform finishes, navigate to the `ansible/` directory:

   ```
   cd ../ansible/
   ```

8. Update the `hosts.ini` file with the public IP of the EC2 instance created by Terraform. You can find the IP in the `terraform/terraform.tfstate` file.

9. Run the Ansible playbook to configure the Bitcoin node:

   ```
   ansible-playbook -i hosts.ini install_bitcoin_node.yml
   ```

After the successful execution of the playbook, your Bitcoin node will be running in the `bitcoind` container on the AWS EC2 instance.

## Explanation

This project creates an EC2 instance on AWS using Terraform with the following security configurations:

- Allow SSH traffic (port 22)
- Allow HTTP traffic (port 80)
- Allow HTTPS traffic (port 443)
- Allow outbound traffic
- Allow Bitcoin RPC traffic (port 8332)
- Allow Bitcoin P2P traffic (port 8333)
- Allow ZMQ block notifications traffic (port 28332)
- Allow ZMQ transaction notifications traffic (port 28333)

The Ansible playbook configures the Bitcoin node by performing the following steps:

- Update the system packages
- Install Docker
- Start and enable the Docker service
- Download the `lncm/bitcoind:v25.0` image
- Run a container using the `lncm/bitcoind:v25.0` image, exposing the necessary ports and binding the `bitcoin-data` volume.

## Contributing

Feel free to contribute to this project by opening issues or submitting pull requests.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Future Enhancements

Deploy this container using AWS Fargate or ECS.