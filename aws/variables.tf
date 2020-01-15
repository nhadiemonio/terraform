variable "aws_region" {
  default = "ap-southeast-1"
}

variable "public_cidr" {
  default = "10.0.0.0/24"
}

variable "private_cidr" {
  default = "10.1.0.0/24"
}

variable "public_subnet" {
  default = "10.0.0.0/24"
}

variable "private_subnet" {
  default = "10.1.0.0/24"
}

variable "key_name" {
  default = "dtone"
}

variable "public_key_path" {
  default = "~/.ssh/id_rsa.pub"
}

variable "ssh_port" {
  default = "22"
}

variable "ovpn_port" {
  default = "1194"
}

variable "instance_type" {
  default = "t2.micro"
}

# From Community
variable "ami_id" {
  default = "ami-04ca9f4887b85e954"
}

variable "proxy_port" {
  default = "3128"
}

variable "prometheus_port" {
  default = "9090"
}

variable "exporter_port" {
  default = "9100"
}

variable "grafana_port" {
  default = "3000"
}


