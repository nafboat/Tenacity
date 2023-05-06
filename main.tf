# TENACITY VPC
resource "aws_vpc" "tenacity-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "tenacity-vpc"
  }
}

# Public subnets
resource "aws_subnet" "Prod-pub-sub1" {
  vpc_id            = aws_vpc.tenacity-vpc.id
  cidr_block        = "10.0.10.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "Prod-pub-sub1"
  }
}

resource "aws_subnet" "Prod-pub-sub2" {
  vpc_id            = aws_vpc.tenacity-vpc.id
  cidr_block        = "10.0.11.0/24"
  availability_zone = "eu-west-2b"

  tags = {
    Name = "Prod-pub-sub2"
  }
}

# Private subnets
resource "aws_subnet" "Prod-priv-sub1" {
  vpc_id            = aws_vpc.tenacity-vpc.id
  cidr_block        = "10.0.12.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "Prod-priv-sub1"
  }
}

resource "aws_subnet" "prod-priv-sub2" {
  vpc_id            = aws_vpc.tenacity-vpc.id
  cidr_block        = "10.0.13.0/24"
  availability_zone = "eu-west-2c"

  tags = {
    Name = "prod-priv-sub2"
  }
}

# Route Tables
resource "aws_route_table" "Prod-pub-route-table" {
  vpc_id = aws_vpc.tenacity-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Prod-igw.id
  }

  tags = {
    Name = "Prod-pub-route-table"
  }
}

resource "aws_route_table" "Prod-priv-route-table" {
  vpc_id = aws_vpc.tenacity-vpc.id

  route	{
	cidr_block	= "0.0.0.0/0"
	gateway_id	= aws_nat_gateway.Prod-Nat-gateway.id
	}
	
  tags = {
    Name = "Prod-priv-route-table"
  }
}


# Route Table Associations
resource "aws_route_table_association" "public-rt-assoc" {
  subnet_id      = aws_subnet.Prod-pub-sub1.id
  route_table_id = aws_route_table.Prod-pub-route-table.id
}


resource "aws_route_table_association" "public-rt1-assoc" {
  subnet_id      = aws_subnet.Prod-pub-sub2.id
  route_table_id = aws_route_table.Prod-pub-route-table.id
}


resource "aws_route_table_association" "private-rt1-assoc" {
  subnet_id      = aws_subnet.Prod-priv-sub1.id
  route_table_id = aws_route_table.Prod-priv-route-table.id
}

resource "aws_route_table_association" "private-rt2-assoc" {
  subnet_id      = aws_subnet.prod-priv-sub2.id
  route_table_id = aws_route_table.Prod-priv-route-table.id
}

#Internet Gateway
resource "aws_internet_gateway" "Prod-igw" {
  vpc_id = aws_vpc.tenacity-vpc.id

  tags = {
    Name = "Prod-igw"
  }
}

#NAT Gateway
# creat elastic ip first
resource "aws_eip" "tenacity-eip" {
  vpc = true
}

#then associate NAT gateway 
resource "aws_nat_gateway" "Prod-Nat-gateway" {
  allocation_id = aws_eip.tenacity-eip.id
  subnet_id     = aws_subnet.Prod-pub-sub1.id

  tags = {
    Name = "Prod-Nat-gateway"
  }
}
