terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_pair_name
  public_key = file(local.public_key_path)
}

module "docker_security_group" {
  source = "./modules/security_group"

  name        = "new_allow_docker"
  description = "Allow Docker traffic and internet access"
  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
    }
  ]
}

module "bitcoin_node_security_group" {
  source = "./modules/security_group"

  name        = "bitcoin_node_sg"
  description = "Allow Bitcoin node traffic"
  ingress_rules = [
    {
      from_port   = 8332
      to_port     = 8332
      protocol    = "tcp"
    },
    {
      from_port   = 8333
      to_port     = 8333
      protocol    = "tcp"
    },
    {
      from_port   = 28332
      to_port     = 28332
      protocol    = "tcp"
    },
    {
      from_port   = 28333
      to_port     = 28333
      protocol    = "tcp"
    }
  ]
}

resource "aws_instance" "bitcoin_node" {
  ami           = "ami-099606edc08324c3f" 
  instance_type = var.instance_type

  key_name               = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [module.docker_security_group.security_group_id, module.bitcoin_node_security_group.security_group_id]

  root_block_device {
    volume_size = var.root_volume_size
  }

  tags = {
    Name = "bitcoind-docker-instance"
  }
}