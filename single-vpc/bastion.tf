resource "aws_instance" "bastion-host" {
  depends_on = [aws_internet_gateway.dev-internet-gateway]
  key_name = var.bastion-host.key_name
  ami = var.bastion-host.ami_id
  instance_type = var.bastion-host.instance_type
  subnet_id = aws_subnet.public-subnet.id
  private_ip = var.bastion-host.internal_ip
  vpc_security_group_ids = [
    aws_security_group.allow-restricted-ssh.id,
    aws_default_security_group.default-public-sec-group.id
  ]

  tags = {
    Name = "bastion"
    Environment = terraform.workspace
  }
}

resource "aws_eip" "bastion-host-eip" {
  depends_on = [aws_internet_gateway.dev-internet-gateway]
  instance = aws_instance.bastion-host.id
  associate_with_private_ip = aws_instance.bastion-host.private_ip
  vpc = true
  tags = {
    Name = "bastion"
    Environment = terraform.workspace
  }
  provisioner "local-exec" {
    command = "ansible-playbook --ssh-common-args='-i ~/.ssh/user1_id_rsa -o StrictHostKeyChecking=off' -e 'ansible_python_interpreter=/usr/bin/python3' -i 'ubuntu@${self.public_ip}', updates.yml"
  }
}