resource "aws_vpc" "hevo-vpc" {
  cidr_block = "10.1.0.0/16"
}

 

resource "aws_internet_gateway" "hevo-igw"{
  vpc_id = aws_vpc.hevo-vpc.id
}

 

resource "aws_subnet" "hevo-public-subnet"{
  vpc_id = aws_vpc.hevo-vpc.id
  cidr_block = "10.1.1.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
}

 

resource "aws_subnet" "hevo-private-subnet"{
  vpc_id = aws_vpc.hevo-vpc.id
  cidr_block = "10.1.2.0/24"
  availability_zone = "ap-south-1a"
}

 

resource "aws_route_table" "hevo-public-rt"{
  vpc_id = aws_vpc.hevo-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.hevo-igw.id
  }
}

 

 

resource "aws_route_table_association" "public-rt-association"{
  subnet_id = aws_subnet.hevo-public-subnet.id
  route_table_id = aws_route_table.hevo-public-rt.id
}
