resource "aws_instance" "web-host" {
  depends_on = [
    aws_instance.bastion-host,
    aws_eip.bastion-host-eip
  ]
  key_name = var.web-host.key_name
  ami = var.web-host.ami_id
  instance_type = var.web-host.instance_type
  subnet_id = aws_subnet.frontend-subnet.id
  vpc_security_group_ids = [
    aws_security_group.allow-bastion-ssh.id,
    aws_default_security_group.default-public-sec-group.id
  ]
  provisioner "local-exec" {
    command = "ansible-playbook --ssh-common-args='-i ~/.ssh/user1_id_rsa -J ubuntu@${aws_instance.bastion-host.public_ip}  -o StrictHostKeyChecking=off' -e 'ansible_python_interpreter=/usr/bin/python3' -i 'ubuntu@${self.private_ip}', updates.yml"
  }
  tags = {
    Name = "web"
    Environment = terraform.workspace
  }
}
