terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.53.0" # Ajusta la versión según tus necesidades
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


resource "aws_efs_file_system" "efs" {
  creation_token = "ejemplo-efs"
}

resource "aws_efs_mount_target" "efs_mount" {
  file_system_id = aws_efs_file_system.efs.id
  subnet_id      = "subnet-097f10e404e736c9f"
}

#resource "aws_subnet" "efs_subnets" {
#  vpc_id     = "vpc-070a6e14d5d96c55d" # Reemplaza con el ID de tu VPC
#  cidr_block = "172.31.32.0/20"
#}

resource "aws_security_group" "efs-sg" {
  name        = "efs_security_group"
#  description = "Permite tráfico NFS desde la instancia EC2"
  vpc_id      = "vpc-070a6e14d5d96c55d"

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["172.31.32.0/20"]
  }
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Instancia EC2
resource "aws_instance" "ec2" {
  ami           = "ami-08a0d1e16fc3f61ea" # Amazon Linux 2023 en us-east-1
  instance_type = "t2.micro"
  key_name      = "vockey"

  subnet_id              = "subnet-097f10e404e736c9f"
  vpc_security_group_ids = [aws_security_group.efs-sg.id]

  # Script de usuario para montar EFS al iniciar
  user_data = <<-EOF
    #!/bin/bash
    yum install -y amazon-efs-utils
    mkdir /mnt/efs
    mount -t efs -o tls ${aws_efs_file_system.efs.id}:/ /mnt/efs
  EOF

  tags = {
    Name = "EFS Instance"
  }
}
