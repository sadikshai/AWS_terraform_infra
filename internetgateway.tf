resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.base.id
  tags = {
    Name = "myigw"
  }

}

resource "aws_eip" "nat_eip" {
domain = "vpc"
}

resource "aws_nat_gateway" "db_natgate" {
  allocation_id=aws_eip.nat_eip.id
  subnet_id = aws_subnet.web[1].id
  tags = {
    Name="privat_nat_gateway"
  }
  depends_on = [aws_internet_gateway.igw]
  
}



resource "aws_route_table" "webroute" {

  vpc_id = aws_vpc.base.id
  tags = {
    Name = "public"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id

  }

}


resource "aws_route_table_association" "web_association" {
  count          = local.web_subnet_count
  subnet_id      = aws_subnet.web[count.index].id
  route_table_id = aws_route_table.webroute.id

}


resource "aws_route_table" "dbroute" {
  vpc_id = aws_vpc.base.id
  tags = {
    Name = "private"
  }
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.db_natgate.id
  }
}


resource "aws_route_table_association" "db_association" {
  count          = local.db_subnet_count
  subnet_id      = aws_subnet.db[count.index].id
  route_table_id = aws_route_table.dbroute.id

}


