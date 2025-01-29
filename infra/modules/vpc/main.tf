# Create VPC
resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
 
  tags = {
    Name = var.vpc_name
  }
} 

# Create Public Subnet
 resource "aws_subnet" "public" {
  count = 2
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_cidr_block[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "var.public_subnet_name-${count.index}"
  }
} 

# Create Private Subnets for RDS
 resource "aws_subnet" "private" {
    count = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_cidr_block[count.index]
 availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "var.private_subnet_name-${count.index}"
  }
} 

 