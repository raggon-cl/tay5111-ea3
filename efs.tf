# Creating EFS file system
resource "aws_efs_file_system" "efs" {
  creation_token   = "efs"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encrypted        = "true"
  tags = {
    Name = "EFS"
  }
}

# Creating Mount target of EFS
resource "aws_efs_mount_target" "efs-mt" {
  count           = length(module.vpc.public_subnets)
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = module.vpc.public_subnets[count.index]
  security_groups = [aws_security_group.sg_efs.id]
}

# Creating Mount Point for EFS on server1a
resource "null_resource" "configure_nfs_server1a" {
  depends_on = [aws_efs_mount_target.efs-mt]
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = tls_private_key.server_key.private_key_pem
    host        = aws_instance.server1a.public_ip
  }

  provisioner "remote-exec" {
    inline = [

      # Mounting Efs 
      "sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_file_system.efs.dns_name}:/  /var/www/html",
      # Making Mount Permanent
      "echo ${aws_efs_file_system.efs.dns_name}:/ /var/www/html nfs4 defaults,_netdev 0 0  | sudo cat >> /etc/fstab ",
      "sudo chmod go+rw /var/www/html",
      ##"sudo git clone https://github.com/Apeksh742/EC2_instance_with_terraform.git /var/www/html",
    ]
  }
}

# Creating Mount Point for EFS on server1b
resource "null_resource" "configure_nfs_server1b" {
  depends_on = [aws_efs_mount_target.efs-mt]
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = tls_private_key.server_key.private_key_pem
    host        = aws_instance.server1b.public_ip
  }

  provisioner "remote-exec" {
    inline = [

      # Mounting Efs 
      "sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_file_system.efs.dns_name}:/  /var/www/html",
      # Making Mount Permanent
      "echo ${aws_efs_file_system.efs.dns_name}:/ /var/www/html nfs4 defaults,_netdev 0 0  | sudo cat >> /etc/fstab ",
      "sudo chmod go+rw /var/www/html",
      ##"sudo git clone https://github.com/Apeksh742/EC2_instance_with_terraform.git /var/www/html",
    ]
  }
}

# Creating Mount Point for EFS on server1c
resource "null_resource" "configure_nfs_server1c" {
  depends_on = [aws_efs_mount_target.efs-mt]
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = tls_private_key.server_key.private_key_pem
    host        = aws_instance.server1c.public_ip
  }

  provisioner "remote-exec" {
    inline = [

      # Mounting Efs 
      "sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_file_system.efs.dns_name}:/  /var/www/html",
      # Making Mount Permanent
      "echo ${aws_efs_file_system.efs.dns_name}:/ /var/www/html nfs4 defaults,_netdev 0 0  | sudo cat >> /etc/fstab ",
      "sudo chmod go+rw /var/www/html",
      ##"sudo git clone https://github.com/Apeksh742/EC2_instance_with_terraform.git /var/www/html",
    ]
  }
}
