
data "aws_caller_identity" "current" {
}

# Upload SSH Keys
resource "aws_key_pair" "auth" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

# Launch Instance - Bastion Host
resource "aws_instance" "bastion" {
  tags          = {
    Name        = "bastion-host"
  }
  private_ip = "10.0.0.32"
  instance_type = var.instance_type
  ami = var.ami_id
  key_name = aws_key_pair.auth.id
  vpc_security_group_ids = [
    aws_security_group.allow_ssh_public_vpc.id,
    aws_security_group.allow_openvpn.id,
    aws_security_group.default_public_vpc.id,
    aws_security_group.allow_proxy_public_vpc.id,
    aws_security_group.allow_monitoring_public_vpc.id
  ]
  subnet_id = aws_subnet.public_subnet.id
  associate_public_ip_address = true

  provisioner "remote-exec" {
    connection {
    host = aws_instance.bastion.public_ip
    private_key = file("~/.ssh/id_rsa")
    user = "centos"
    }
    inline = [
      "sudo hostnamectl set-hostname bastion.home.work",
      "sudo yum -y update",
      "sudo yum -y install epel-release"
    ]
  }

#  provisioner "local-exec" {
#    command = "ansible-playbook -i '${aws_instance.bastion.public_ip},' bastion.yml"
#  }

}

# If Elastic IP is required
# Assign Elastic IP to Bastion Host
# resource "aws_eip" "bastion_public" {
#  vpc = true
#  instance                  = aws_instance.bastion.id
#  associate_with_private_ip = "10.0.0.32"
#  depends_on                = [aws_internet_gateway.public_vpc_ig]
# }

# Launch Instances - priv1, priv2
resource "aws_instance" "priv" {
  count           = 2
  tags          = {
    Name        = format("priv%1d", count.index+1)
  }
  instance_type = var.instance_type
  ami = var.ami_id
  key_name = aws_key_pair.auth.id
  vpc_security_group_ids = [
    aws_security_group.allow_ssh_private_vpc.id,
    aws_security_group.default_private_vpc.id,
    aws_security_group.allow_exporter_private_vpc.id
  ]
  subnet_id = aws_subnet.private_subnet.id

  provisioner "remote-exec" {
    connection {
    host = self.private_ip
    private_key = file("~/.ssh/id_rsa")
    user = "centos"
    bastion_host = aws_instance.bastion.public_ip
    bastion_user = "centos"
    }
  }

#  provisioner "local-exec" {
#    command = "ansible-playbook --ssh-common-args='-J centos@${aws_instance.bastion.public_ip}' -i ${self.private_ip}, client.yml"
#  }

}
