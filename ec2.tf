resource "aws_instance" "server1a" {
  ami           = "ami-0cff7528ff583bf9a" # Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
  instance_type = "t2.micro"
  key_name      = "vockey"
  subnet_id     = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]


  tags = {
    Name = "server1a"
  }
}


resource "aws_instance" "server1b" {
  ami            = "ami-0cff7528ff583bf9a" # Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
  instance_type  = "t2.micro"
  key_name       = "vockey"
  subnet_id      = module.vpc.public_subnets[1]
  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]

  tags = {
    Name = "server1b"
  }
}

resource "aws_instance" "server1c" {
  ami           = "ami-0cff7528ff583bf9a" # Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
  instance_type = "t2.micro"
  key_name      = "vockey"
  subnet_id     = module.vpc.public_subnets[2]
  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]

  tags = {
    Name = "server1c"
  }

}