# VPC Creation
resource "aws_vpc" "base" {
  cidr_block = var.vpc_info[0].cidr_block
  tags       = var.vpc_info[0].tags
}

# Web Subnets
resource "aws_subnet" "web" {
  count             = local.web_subnet_count
  vpc_id            = aws_vpc.base.id
  cidr_block        = var.web_subnet[count.index].cidr_block
  availability_zone = var.web_subnet[count.index].availability_zone
  tags              = var.web_subnet[count.index].tags
  depends_on        = [aws_vpc.base]
}

# Database Subnets
resource "aws_subnet" "db" {
  count             = local.db_subnet_count
  vpc_id            = aws_vpc.base.id
  cidr_block        = var.db_subnet[count.index].cidr_block
  availability_zone = var.db_subnet[count.index].availability_zone
  tags              = var.db_subnet[count.index].tags
  depends_on        = [aws_vpc.base]
}

# Web Security Group
resource "aws_security_group" "web" {
  vpc_id      = aws_vpc.base.id
  name        = var.web_security_group.name
  description = var.web_security_group.description
  tags        = { Name = var.web_security_group.name }
  depends_on  = [aws_vpc.base]
}

# Web Ingress Rules
resource "aws_vpc_security_group_ingress_rule" "web" {
  count             = length(var.web_security_group.rules)
  security_group_id = aws_security_group.web.id
  from_port         = var.web_security_group.rules[count.index].from_port
  to_port           = var.web_security_group.rules[count.index].to_port
  ip_protocol       = var.web_security_group.rules[count.index].ip_protocol
  cidr_ipv4         = var.web_security_group.rules[count.index].cidr_ipv4
}

# Web Egress Rule
resource "aws_vpc_security_group_egress_rule" "web" {
  security_group_id = aws_security_group.web.id
  cidr_ipv4         = local.anywhere
  ip_protocol       = -1
}

# Database Security Group
resource "aws_security_group" "db" {
  vpc_id      = aws_vpc.base.id
  name        = var.db_security_group.name
  description = var.db_security_group.description
  tags        = { Name = var.db_security_group.name }
  depends_on  = [aws_vpc.base]
}

# Database Ingress Rules 
resource "aws_vpc_security_group_ingress_rule" "db" {
  count             = length(var.db_security_group.rules)
  security_group_id = aws_security_group.db.id
  from_port         = var.db_security_group.rules[count.index].from_port
  to_port           = var.db_security_group.rules[count.index].to_port
  ip_protocol       = var.db_security_group.rules[count.index].ip_protocol
  cidr_ipv4         = var.db_security_group.rules[count.index].cidr_ipv4
}

# Database Egress Rule 
resource "aws_vpc_security_group_egress_rule" "db" {
  security_group_id = aws_security_group.db.id
  cidr_ipv4         = local.anywhere
  ip_protocol       = -1
}


