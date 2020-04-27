resource "aws_instance" "web-host" {
  for_each = aws_subnet.frontend-subnet
  key_name = var.web-host.key_name
  depends_on = [aws_subnet.frontend-subnet]
  ami = var.web-host.ami_id
  instance_type = var.web-host.instance_type
  subnet_id = each.value.id
  vpc_security_group_ids = [
    aws_security_group.allow-bastion-frontend-ssh.id,
    aws_security_group.allow-frontend-web.id,
    aws_default_security_group.default-fronted-sec-group.id
  ]
  provisioner "remote-exec" {
    connection {
      bastion_host = aws_instance.bastion-host.public_ip
      bastion_private_key = file("~/.ssh/user1_id_rsa")
      bastion_user = "ubuntu"
      host = self.private_ip
      private_key = file("~/.ssh/user1_id_rsa")
      user = "ubuntu"
    }
    inline = [
      "sudo apt -y update",
      "sudo apt -y upgrade",
      "sudo apt -y install nginx",
      "sudo systemctl enable nginx --now"
    ]
  }
  tags = {
    Name = "web-${each.key}"
    Environment = terraform.workspace
  }
}
