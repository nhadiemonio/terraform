resource "aws_vpc" "dev-vpc" {
  cidr_block = var.dev-vpc-vars.cidr
  enable_dns_hostnames = true
  tags = {
    Name = var.dev-vpc-vars.name
    Environment = terraform.workspace
  }
}

resource "aws_subnet" "public-subnet" {
  depends_on = [aws_vpc.dev-vpc]
  cidr_block = var.public-subnet-vars.subnet
  availability_zone = var.public-subnet-vars.az
  vpc_id = aws_vpc.dev-vpc.id
  tags = {
    Name = var .public-subnet-vars.name
    Environment = terraform.workspace
  }
}

resource "aws_subnet" "frontend-subnet" {
  depends_on = [aws_vpc.dev-vpc]
  cidr_block = var.frontend-subnet-vars.subnet
  availability_zone = var.frontend-subnet-vars.az
  vpc_id = aws_vpc.dev-vpc.id
  tags = {
    Name = var .frontend-subnet-vars.name
    Environment = terraform.workspace
  }
}

resource "aws_internet_gateway" "dev-internet-gateway" {
  depends_on = [aws_vpc.dev-vpc]
  vpc_id = aws_vpc.dev-vpc.id
  tags = {
    Name = "public-internet-gateway"
    Environment = terraform.workspace
  }
}

resource "aws_eip" "public-natgw-eip" {
  vpc = true
  tags = {
    Name = "public-natgw-eip"
    Environment = terraform.workspace
  }
}

resource "aws_nat_gateway" "public-natgw" {
  depends_on = [aws_eip.public-natgw-eip]
  allocation_id = aws_eip.public-natgw-eip.id
  subnet_id = aws_subnet.public-subnet.id
  tags = {
    Name = "public-natgw"
    Environment = terraform.workspace
  }
}

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.dev-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev-internet-gateway.id
  }
  tags = {
    Name = "public-route-table"
    Environment = "dev"
  }
}

resource "aws_route_table_association" "public-route-table" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table" "frontend-route-table" {
  vpc_id = aws_vpc.dev-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.public-natgw.id
  }
  tags = {
    Name = "frontend-route-table"
    Environment = "dev"
  }
}

resource "aws_route_table_association" "frontend-route-table" {
  subnet_id      = aws_subnet.frontend-subnet.id
  route_table_id = aws_route_table.frontend-route-table.id
}



