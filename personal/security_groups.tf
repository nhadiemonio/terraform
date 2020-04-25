resource "aws_security_group" "allow-public-web" {
  name = "allow-public-web"
  description = "allow-public-web"
  vpc_id = aws_vpc.frontend-vpc.id
  tags = {
    Name = "allow-public-web"
    Environment = terraform.workspace
  }
}

resource "aws_security_group" "allow-restricted-web" {
  name = "allow-restricted-web"
  description = "allow-restricted-web"
  vpc_id = aws_vpc.backend-vpc.id
  tags = {
    Name = "allow-restricted-web"
    Environment = terraform.workspace
  }
}

resource "aws_security_group" "allow-restricted-ssh" {
  name = "allow-restricted-ssh"
  description = "allow-restricted-ssh"
  vpc_id = aws_vpc.frontend-vpc.id
  tags = {
    Name = "allow-restricted-ssh"
    Environment = terraform.workspace
  }
}

resource "aws_security_group" "allow-bastion-ssh" {
  name = "allow-bastion-ssh"
  description = "allow-bastion-ssh"
  vpc_id = aws_vpc.backend-vpc.id
}

resource "aws_security_group_rule" "allow-public-web" {
  for_each = var.allow-public-web
  type = each.value["type"]
  protocol = each.value["dest_protocol"]
  from_port = each.value["dest_from_port"]
  to_port = each.value["dest_to_port"]
  cidr_blocks = each.value["src_cidr"]
  security_group_id = aws_security_group.allow-public-web.id
}

resource "aws_security_group_rule" "allow-restricted-web" {
  for_each = var.allow-restricted-web
  type = each.value["type"]
  protocol = each.value["dest_protocol"]
  from_port = each.value["dest_from_port"]
  to_port = each.value["dest_to_port"]
  cidr_blocks = each.value["src_cidr"]
  security_group_id = aws_security_group.allow-restricted-web.id
}

resource "aws_security_group_rule" "allow-bastion-ssh" {
  type = var.allow-bastion-ssh.type
  protocol = var.allow-bastion-ssh.dest_protocol
  from_port = var.allow-bastion-ssh.dest_from_port
  to_port = var.allow-bastion-ssh.dest_to_port
  cidr_blocks = var.allow-bastion-ssh.src_cidr
  security_group_id = aws_security_group.allow-bastion-ssh.id
}

resource "aws_security_group_rule" "allow-restricted-ssh" {
  for_each = var.allow-restricted-ssh
  type = each.value["type"]
  protocol = each.value["dest_protocol"]
  from_port = each.value["dest_from_port"]
  to_port = each.value["dest_to_port"]
  cidr_blocks = each.value["src_cidr"]
  security_group_id = aws_security_group.allow-restricted-ssh.id
}

