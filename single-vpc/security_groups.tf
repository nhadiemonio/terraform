resource "aws_default_security_group" "default-public-sec-group" {
  vpc_id = aws_vpc.dev-vpc.id
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  tags = {
    Name = "allow-all-inbound"
    Environment = terraform.workspace
  }
}


resource "aws_security_group" "allow-bastion-ssh" {
  vpc_id = aws_vpc.dev-vpc.id
  name = "allow-bastion-ssh"
  description = "allow-bastion-ssh"
  tags = {
    Name = "allow-bastion-ssh"
    Environment = terraform.workspace
  }
}

resource "aws_security_group_rule" "allow-bastion-ssh" {
  security_group_id = aws_security_group.allow-bastion-ssh.id
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = [
    "10.128.254.254/32"
  ]
}

resource "aws_security_group" "allow-restricted-ssh" {
  vpc_id = aws_vpc.dev-vpc.id
  name = "allow-restricted-ssh"
  description = "allow-restricted-ssh"
  tags = {
    Name = "allow-restricted-ssh"
    Environment = terraform.workspace
  }
}

resource "aws_security_group_rule" "allow-restricted-ssh" {
  security_group_id = aws_security_group.allow-restricted-ssh.id
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = [
    "118.189.200.235/32",
    "52.76.64.154/32"
  ]
}
