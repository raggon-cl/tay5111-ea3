resource "aws_security_group" "ec2" {
  name        = "allow_ssh_http_efs"
  description = "Allow SSH & HTTP inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description      = "SSH from Internet"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTP from Internet"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTPS from Internet"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = "allow_ssh_http_efs"
    Terraform   = "true"
    Environment = "prd"
  }
}

resource "aws_security_group" "sg_efs" {
  name        = "sg_efs"
  description = "Allos inbound efs traffic from ec2"
  vpc_id      = module.vpc.vpc_id

  ingress {
    security_groups = [aws_security_group.ec2.id]
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
  }

  egress {
    security_groups = [aws_security_group.ec2.id]
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
  }

  tags = {
    Name        = "sg_efs"
    Terraform   = "true"
    Environment = "prd"
  }
}

resource "aws_security_group" "http_ingress" {
  name        = "allow_http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  
  tags = {
    Name        = "allow_http"
    Terraform   = "true"
    Environment = "prd"
  }
}
