# obtener IPs de las maquinas creadas
output "web-server-1-ip" {
  value = aws_instance.server1a.public_ip
}

output "web-server-2-ip" {
  value = aws_instance.server1b.public_ip
}

output "web-server-3-ip" {
  value = aws_instance.server1c.public_ip
}

# Obtain LB DNS Name
output "web-server-lb-dns" {
  value = aws_elb.web-server-lb.dns_name
}