resource "aws_instance" "server1a" {
  ami                  = "ami-0cff7528ff583bf9a" # Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
  instance_type        = "t2.micro"
  key_name             = "vockey"
  iam_instance_profile = "EMR_EC2_DefaultRole"

  tags = {
    Name = "server1a"
  }
}


resource "aws_instance" "server1b" {
  ami                  = "ami-0cff7528ff583bf9a" # Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
  instance_type        = "t2.micro"
  key_name             = "vockey"
  iam_instance_profile = "EMR_EC2_DefaultRole"

  tags = {
    Name = "server1b"
  }
}

resource "aws_instance" "server1c" {
  ami                  = "ami-0cff7528ff583bf9a" # Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
  instance_type        = "t2.micro"
  key_name             = "vockey"
  iam_instance_profile = "EMR_EC2_DefaultRole"

  tags = {
    Name = "server1c"
  }

}