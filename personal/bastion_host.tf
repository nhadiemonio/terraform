
resource "aws_instance" "bastion-host" {
  key_name = var.bastion-host.key_name
  depends_on = [aws_subnet.frontend-subnet]
  ami = var.bastion-host.ami_id
  instance_type = var.bastion-host.instance_type
  subnet_id = aws_subnet.frontend-subnet["az1"].id
  vpc_security_group_ids = [
    aws_security_group.allow-restricted-ssh.id,
    aws_default_security_group.default-fronted-sec-group.id
  ]
  tags = {
    Name = "bastion"
    Environment = terraform.workspace
  }
}

resource "aws_eip" "bastion-host-eip" {
  depends_on = [aws_internet_gateway.frontend-internet-gateway,aws_instance.bastion-host]
  instance = aws_instance.bastion-host.id
  associate_with_private_ip = aws_instance.bastion-host.private_ip
  vpc = true
  tags = {
    Name = "bastion"
    Environment = terraform.workspace
  }
}
