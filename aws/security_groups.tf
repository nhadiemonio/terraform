# Default Sec Group - public vpc
resource "aws_security_group" "default_public_vpc" {
  name        = "default_public_vpc"
  description = "default_public_vpc"
  vpc_id      = aws_vpc.public_vpc.id

  # Allow ALL Outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Allow SSH Sec Group - public vpc
resource "aws_security_group" "allow_ssh_public_vpc" {
  name        = "allow_ssh_public_vpc"
  description = "allow_ssh_public_vpc"
  vpc_id      = aws_vpc.public_vpc.id

  # SSH access from anywhere
  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Allow Monitoring Sec Group - public vpc
resource "aws_security_group" "allow_monitoring_public_vpc" {
  name        = "allow_monitoring_public_vpc"
  description = "allow_monitoring_public_vpc"
  vpc_id      = aws_vpc.public_vpc.id

  # prometheus access from anywhere
  ingress {
    from_port   = var.prometheus_port
    to_port     = var.prometheus_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # grafana access from anywhere
  ingress {
    from_port   = var.grafana_port
    to_port     = var.grafana_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

# Allow Proxy Server Sec Group - public vpc
resource "aws_security_group" "allow_proxy_public_vpc" {
  name        = "allow_proxy_public_vpc"
  description = "allow_proxy_public_vpc"
  vpc_id      = aws_vpc.public_vpc.id

  # proxy access from private subnet
  ingress {
    from_port   = var.proxy_port
    to_port     = var.proxy_port
    protocol    = "tcp"
    cidr_blocks = ["10.1.0.0/24"]
  }
}

# Allow OpenVPN - public vpc
resource "aws_security_group" "allow_openvpn" {
  name        = "allow_openvpn"
  description = "allow_openvpn"
  vpc_id      = aws_vpc.public_vpc.id

  # OpenVPN access from anywhere
  ingress {
    from_port   = var.ovpn_port
    to_port     = var.ovpn_port
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Default Sec Group - private vpc
resource "aws_security_group" "default_private_vpc" {
  name        = "default_private_vpc"
  description = "default_private_vpc"
  vpc_id      = aws_vpc.private_vpc.id

  # Allow ALL Outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Allow SSH Sec Group - private vpc
resource "aws_security_group" "allow_ssh_private_vpc" {
  name        = "allow_ssh_private_vpc"
  description = "allow_ssh_private_vpc"
  vpc_id      = aws_vpc.private_vpc.id

  # SSH access from Bastiom Host
  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.32/32"]
  }
}

# Allow Promethues Exporter Sec Group - private vpc
resource "aws_security_group" "allow_exporter_private_vpc" {
  name        = "allow_exporter_private_vpc"
  description = "allow_exporter_private_vpc"
  vpc_id      = aws_vpc.private_vpc.id

  # Prometheus Exporter access from Prometheus Host
  ingress {
    from_port   = var.exporter_port
    to_port     = var.exporter_port
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.32/32"]
  }
}
