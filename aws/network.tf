# Create Public VPC
resource "aws_vpc" "public_vpc" {
  cidr_block = var.public_cidr
}

# Create Internet Gateway attached to public-vpc
resource "aws_internet_gateway" "public_vpc_ig" {
  vpc_id = aws_vpc.public_vpc.id
}

# Add default route, as initial main routing table does not include default route
resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.public_vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.public_vpc_ig.id
}

# Create Private VPC
resource "aws_vpc" "private_vpc" {
  cidr_block = var.private_cidr
}

# Create a subnet for Public VPC
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.public_vpc.id
  cidr_block              = var.public_subnet
  availability_zone       = "ap-southeast-1a"
  map_public_ip_on_launch = false
}

# Create a subnet for Private VPC
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.private_vpc.id
  cidr_block              = var.private_subnet
  availability_zone       = "ap-southeast-1a"
  map_public_ip_on_launch = false
}

# Configure peering between public_vpc and private_vpc
resource "aws_vpc_peering_connection" "pub_to_priv" {
  peer_owner_id = data.aws_caller_identity.current.account_id
  peer_vpc_id   = aws_vpc.private_vpc.id
  vpc_id        = aws_vpc.public_vpc.id
  auto_accept   = true
}

# Add static route for private_subnet
resource "aws_route" "pub_to_priv" {
  route_table_id            = aws_vpc.public_vpc.main_route_table_id
  destination_cidr_block    = aws_vpc.private_vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.pub_to_priv.id
}

# Add static route for public_subnet
resource "aws_route" "priv_to_pub" {
  route_table_id            = aws_vpc.private_vpc.main_route_table_id
  destination_cidr_block    = aws_vpc.public_vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.pub_to_priv.id
}
