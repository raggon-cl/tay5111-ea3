resource "aws_instance" "server1a" {
  ami           = "ami-005e54dee72cc1d00" # us-west-2
  instance_type = "t2.micro"
  user_data
  subnet_id
  key_name = "vockey"
  vpc_security_group_ids
 
  }
  
  
  resource "aws_instance" "server1b" {
  ami           = "ami-005e54dee72cc1d00" # us-west-2
  instance_type = "t2.micro"

 
  }
  
  resource "aws_instance" "server1c" {
  ami           = "ami-005e54dee72cc1d00" # us-west-2
  instance_type = "t2.micro"

 
  }