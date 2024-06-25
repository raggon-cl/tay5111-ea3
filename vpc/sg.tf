resource "aws_security_group" "efs-sg" {
  name = "efs_security_group"
  #  description = "Permite tráfico NFS desde la instancia EC2"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    security_groups = ["${aws_security_group.webserver-sg.id}"]
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

resource "aws_security_group" "alb-sg" {
  name = "alb_security_group"
  #  description = "Permite tráfico NFS desde la instancia EC2"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
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

resource "aws_security_group" "webserver-sg" {
  name = "webserver_security_group"
  #  description = "Permite tráfico NFS desde la instancia EC2"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = ["${aws_security_group.alb-sg.id}"]
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