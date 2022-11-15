resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.subnet_a.id
  depends_on    = [aws_internet_gateway.igw]
}

resource "aws_route_table" "dev-private" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }
}

resource "aws_route_table_association" "dev-private-1-a" {
  subnet_id      = aws_subnet.Private_subnet_b.id
  route_table_id = aws_route_table.dev-private.id
}