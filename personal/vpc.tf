resource "aws_vpc" "frontend-vpc" {
  cidr_block = var.frontend-vpc-vars.cidr
  enable_dns_hostnames = true
  tags = {
    Name = var.frontend-vpc-vars.name
    Environment = terraform.workspace
  }
}

resource "aws_internet_gateway" "frontend-internet-gateway" {
  depends_on = [aws_vpc.frontend-vpc]
  vpc_id = aws_vpc.frontend-vpc.id
  tags = {
    Name = "frontend-internet-gateway"
    Environment = terraform.workspace
  }
}

resource "aws_vpc" "backend-vpc" {
  cidr_block = var.backend-vpc-vars.cidr
  enable_dns_hostnames = true
  tags = {
    Name = var.backend-vpc-vars.name
    Environment = terraform.workspace
  }
}

resource "aws_subnet" "frontend-subnet" {
  depends_on = [aws_vpc.frontend-vpc]
  for_each = var.frontend-subnet-vars
  cidr_block = each.value["subnet"]
  availability_zone = each.value["az"]
  vpc_id = aws_vpc.frontend-vpc.id
  tags = {
    Name = each.value["name"]
    Environment = terraform.workspace
  }
}

resource "aws_subnet" "backend-subnet" {
  depends_on = [aws_vpc.backend-vpc]
  for_each = var.backend-subnet-vars
  cidr_block = each.value["subnet"]
  availability_zone = each.value["az"]
  vpc_id = aws_vpc.backend-vpc.id
  tags = {
    Name = each.value["name"]
    Environment = terraform.workspace
  }
}

resource "aws_vpc_peering_connection" "frontend-backend" {
  peer_vpc_id = aws_vpc.backend-vpc.id
  vpc_id = aws_vpc.frontend-vpc.id
  auto_accept = true
  accepter {
    allow_remote_vpc_dns_resolution = true
  }
  requester {
    allow_remote_vpc_dns_resolution = true
  }

  tags = {
    Name = "frontend-backend-peering"
    Environment = terraform.workspace
  }
}

resource "aws_eip" "backend-eip-az1" {
  depends_on = [aws_subnet.backend-subnet]
  vpc = true
  tags = {
    Name = "nat-gw-eip-az1"
    Environment = terraform.workspace
  }
}

resource "aws_eip" "backend-eip-az2" {
  depends_on = [aws_subnet.backend-subnet]
  vpc = true
  tags = {
    Name = "nat-gw-eip-az2"
    Environment = terraform.workspace
  }
}

resource "aws_eip" "backend-eip-az3" {
  depends_on = [aws_subnet.backend-subnet]
  vpc = true
  tags = {
    Name = "nat-gw-eip-az3"
    Environment = terraform.workspace
  }
}

resource "aws_default_route_table" "frontend-route-table" {
  depends_on = [aws_vpc.frontend-vpc]
  default_route_table_id = aws_vpc.frontend-vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.frontend-internet-gateway.id
  }
  route {
    cidr_block = aws_vpc.backend-vpc.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.frontend-backend.id
  }
  tags = {
    Name = "frontend-route-table"
    Environment = terraform.workspace
  }
}

resource "aws_default_route_table" "backend-route-table" {
  default_route_table_id = aws_vpc.backend-vpc.default_route_table_id
  route {
    cidr_block = aws_vpc.frontend-vpc.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.frontend-backend.id
  }
  tags = {
    Name = "frontend-route-table"
    Environment = terraform.workspace
  }
}




#resource "aws_nat_gateway" "backend-natgw-az1" {
#  depends_on = [aws_eip.backend-eip-az1]
#  allocation_id = aws_eip.backend-eip-az1.id
#  subnet_id = aws_subnet.backend-subnet["az1"].id
#  tags = {
#    Name = "nat-gw-az1"
#    Environment = terraform.workspace
#  }
#}

#resource "aws_nat_gateway" "backend-natgw-az2" {
#  depends_on = [aws_eip.backend-eip-az2]
#  allocation_id = aws_eip.backend-eip-az2.id
#  subnet_id = aws_subnet.backend-subnet["az2"].id
#  tags = {
#    Name = "nat-gw-az2"
#    Environment = terraform.workspace
#  }
#}

#resource "aws_nat_gateway" "backend-natgw-az3" {
#  depends_on = [aws_eip.backend-eip-az3]
#  allocation_id = aws_eip.backend-eip-az3.id
#  subnet_id = aws_subnet.backend-subnet["az3"].id
#  tags = {
#    Name = "nat-gw-az3"
#    Environment = terraform.workspace
#  }
#}