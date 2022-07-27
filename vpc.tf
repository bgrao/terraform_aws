resource "aws_vpc" "bgr_vpc"{
  cidr_block = "192.165.0.0/16"

  tags = {
    Name = "bgr_vpc"
  }
}


resource "aws_subnet" "bgr_public_subnet" {
   vpc_id     = aws_vpc.bgr_vpc.id
   cidr_block = "192.165.10.0/24"

   tags = {
      Name = "bgr_pub_subnet"
   }
}

resource "aws_internet_gateway" "bgr_igw" {
  vpc_id = aws_vpc.bgr_vpc.id

  tags = {
    Name = "bgr_igw"

  }
}

resource "aws_route_table" "bgr_public_routetable" {
  vpc_id = aws_vpc.bgr_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.bgr_igw.id
  }

  tags = {
   Name = "bgr_pub_routetable"
  }
}

resource "aws_route_table_association" "bgr_routetable_associate" {
  subnet_id      = aws_subnet.bgr_public_subnet.id
  route_table_id = aws_route_table.bgr_public_routetable.id
}

