resource "aws_default_security_group" "default-fronted-sec-group" {
  vpc_id = aws_vpc.frontend-vpc.id
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}

resource "aws_default_security_group" "default-backend-sec-group" {
  vpc_id = aws_vpc.backend-vpc.id
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}

resource "aws_security_group" "allow-public-web" {
  name = "allow-public-web"
  description = "allow-public-web"
  vpc_id = aws_vpc.frontend-vpc.id
  tags = {
    Name = "allow-public-web"
    Environment = terraform.workspace
  }
}

resource "aws_security_group" "allow-frontend-web" {
  name = "allow-frontend-web"
  description = "allow-frontend-web"
  vpc_id = aws_vpc.frontend-vpc.id
  tags = {
    Name = "allow-frontend-web"
    Environment = terraform.workspace
  }
}

resource "aws_security_group" "allow-backend-web" {
  name = "allow-backend-web"
  description = "allow-backend-web"
  vpc_id = aws_vpc.backend-vpc.id
  tags = {
    Name = "allow-backend-web"
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

resource "aws_security_group" "allow-bastion-frontend-ssh" {
  name = "allow-bastion-frontend-ssh"
  description = "allow-bastion-frontend-ssh"
  vpc_id = aws_vpc.frontend-vpc.id
}

resource "aws_security_group" "allow-bastion-backend-ssh" {
  name = "allow-bastion-backend-ssh"
  description = "allow-bastion-backend-ssh"
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

resource "aws_security_group_rule" "allow-frontend-web" {
  for_each = var.allow-restricted-web
  type = each.value["type"]
  protocol = each.value["dest_protocol"]
  from_port = each.value["dest_from_port"]
  to_port = each.value["dest_to_port"]
  cidr_blocks = each.value["src_cidr"]
  security_group_id = aws_security_group.allow-frontend-web.id
}

resource "aws_security_group_rule" "allow-backend-web" {
  for_each = var.allow-restricted-web
  type = each.value["type"]
  protocol = each.value["dest_protocol"]
  from_port = each.value["dest_from_port"]
  to_port = each.value["dest_to_port"]
  cidr_blocks = each.value["src_cidr"]
  security_group_id = aws_security_group.allow-backend-web.id
}



resource "aws_security_group_rule" "allow-bastion-frontend-ssh" {
  type = var.allow-bastion-ssh.type
  protocol = var.allow-bastion-ssh.dest_protocol
  from_port = var.allow-bastion-ssh.dest_from_port
  to_port = var.allow-bastion-ssh.dest_to_port
  cidr_blocks = var.allow-bastion-ssh.src_cidr
  security_group_id = aws_security_group.allow-bastion-frontend-ssh.id
}

resource "aws_security_group_rule" "allow-bastion-backend-ssh" {
  type = var.allow-bastion-ssh.type
  protocol = var.allow-bastion-ssh.dest_protocol
  from_port = var.allow-bastion-ssh.dest_from_port
  to_port = var.allow-bastion-ssh.dest_to_port
  cidr_blocks = var.allow-bastion-ssh.src_cidr
  security_group_id = aws_security_group.allow-bastion-backend-ssh.id
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



