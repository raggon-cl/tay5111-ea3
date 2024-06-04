terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "lab_ebs" {
  ami           = "ami-00beae93a2d981137"
  instance_type = "t2.micro"
  key_name = "vockey"

  root_block_device {
    volume_type = "gp2"
    volume_size = 8   # El volumen raíz por defecto es de 8 GB
  }

  tags = {
    Name = "lab_ebs"
  }
}

resource "aws_ebs_volume" "volumen_disco_c" {
  availability_zone = aws_instance.lab_ebs.availability_zone
  size              = 100
  type              = "gp2"

  tags = {
    Name = "disco_c"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"  # Dispositivo de bloque (ajusta si es necesario)
  volume_id   = aws_ebs_volume.volumen_disco_c.id
  instance_id = aws_instance.lab_ebs.id
}

