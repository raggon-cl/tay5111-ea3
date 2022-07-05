# crear Balanceador de Carga (LB)
resource "aws_elb" "web-server-lb" {
  name            = "web-server-lb"
  subnets         = module.vpc.public_subnets
  security_groups = [aws_security_group.http_ingress.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
}

# Attach VMs to LB
resource "aws_elb_attachment" "web-server-lb-1" {
  elb      = aws_elb.web-server-lb.id
  instance = aws_instance.server1a.id
}

resource "aws_elb_attachment" "web-server-lb-2" {
  elb      = aws_elb.web-server-lb.id
  instance = aws_instance.server1b.id
}

resource "aws_elb_attachment" "web-server-lb-3" {
  elb      = aws_elb.web-server-lb.id
  instance = aws_instance.server1c.id
}
