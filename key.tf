# Generate new private key
resource "tls_private_key" "server_key" {
  algorithm = "RSA"
}

# Generate a key-pair with above key
resource "aws_key_pair" "server_key" {
  key_name   = "server_key"
  public_key = tls_private_key.server_key.public_key_openssh
}
