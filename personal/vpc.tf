resource "aws_vpc" "frontend-vpc" {
  cidr_block = var.frontend-vpc-vars.cidr
  tags = {
    Name = var.frontend-vpc-vars.name
  }
}

resource "aws_vpc" "backend-vpc" {
  cidr_block = var.backend-vpc-vars.cidr
  tags = {
    Name = var.backend-vpc-vars.name
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
  }
}

