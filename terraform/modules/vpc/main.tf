resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  tags = {
    Name = var.name
  }
}

resource "aws_subnet" "public_1" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnet_1_cidr
  availability_zone = var.az_1
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.name}-public-1"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnet_2_cidr
  availability_zone = var.az_2
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.name}-public-2"
  }
}

resource "aws_subnet" "private_1" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.private_subnet_1_cidr
  availability_zone = var.az_1
  tags = {
    Name = "${var.name}-private-1"
  }
}

resource "aws_subnet" "private_2" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.private_subnet_2_cidr
  availability_zone = var.az_2
  tags = {
    Name = "${var.name}-private-2"
  }
}
