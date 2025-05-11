resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  tags       = { Name = "${var.name}-vpc" }
}

resource "aws_subnet" "public" {
  count             = length(var.public_subnets_cidrs)
  cidr_block        = var.public_subnets_cidrs[count.index]
  vpc_id            = aws_vpc.this.id
  map_public_ip_on_launch = true
  availability_zone      = var.azs[count.index]
  tags = { Name = "${var.name}-public-${var.azs[count.index]}" }
}

# ... NAT gateway, route tables, etc.

# 1. Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id
  tags   = { Name = "${var.name}-igw" }
}

# 2. Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  tags   = { Name = "${var.name}-public-rt" }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# 3. Associate the public route table with each public subnet
resource "aws_route_table_association" "public_assocs" {
  for_each       = toset(aws_subnet.public[*].id)
  subnet_id      = each.value
  route_table_id = aws_route_table.public.id
}

output "vpc_id"      { value = aws_vpc.this.id }
output "public_subnets" { value = aws_subnet.public[*].id }
