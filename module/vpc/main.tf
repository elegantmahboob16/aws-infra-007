#vpc for my project

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags       = merge(var.tags, { Name = var.vpc_name })

}

#two public subnet for my vpc
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags              = merge(var.tags, { Name = var.public_subnet_name })
}

resource "aws_subnet" "public_subnet2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags              = merge(var.tags, { Name = var.public_subnet_name2 })
}

#internet gateway for my vpc
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags   = merge(var.tags, { Name = var.igw_name })
}

#route table for my vpc
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
  tags = merge(var.tags, { Name = var.public_route_table_name })

}

#associate route table with public subnets
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}