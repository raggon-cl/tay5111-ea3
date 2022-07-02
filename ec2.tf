resource "aws_instance" "server1a" {
  ami                    = "ami-0cff7528ff583bf9a" # Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.server_key.id
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.ec2.id, aws_security_group.sg_efs.id]
  iam_instance_profile   = "EMR_EC2_DefaultRole"
  user_data              = <<EOF
    #!/bin/bash
    sudo yum -y update
    sudo yum install -y httpd php
    sudo systemctl start httpd
    sudo systemctl enable httpd
    EOF

  tags = {
    Name        = "server1a"
    Terraform   = "true"
    Environment = "prd"
  }
}


resource "aws_instance" "server1b" {
  ami                    = "ami-0cff7528ff583bf9a" # Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.server_key.id
  subnet_id              = module.vpc.public_subnets[1]
  vpc_security_group_ids = [aws_security_group.ec2.id, aws_security_group.sg_efs.id]
  iam_instance_profile   = "EMR_EC2_DefaultRole"
  user_data              = <<EOF
    #!/bin/bash
    sudo yum -y update
    sudo yum install -y httpd php
    sudo systemctl start httpd
    sudo systemctl enable httpd
    EOF

  tags = {
    Name        = "server1b"
    Terraform   = "true"
    Environment = "prd"
  }
}

resource "aws_instance" "server1c" {
  ami                    = "ami-0cff7528ff583bf9a" # Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.server_key.id
  subnet_id              = module.vpc.public_subnets[2]
  vpc_security_group_ids = [aws_security_group.ec2.id, aws_security_group.sg_efs.id]
  iam_instance_profile   = "EMR_EC2_DefaultRole"
  user_data              = <<EOF
    #!/bin/bash
    sudo yum -y update
    sudo yum install -y httpd php
    sudo systemctl start httpd
    sudo systemctl enable httpd
    EOF

  tags = {
    Name        = "server1c"
    Terraform   = "true"
    Environment = "prd"
  }

}