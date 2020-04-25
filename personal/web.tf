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
  tags = {
    Name = "web-${each.key}"
    Environment = terraform.workspace
  }
}
