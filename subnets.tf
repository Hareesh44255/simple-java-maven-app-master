locals {
  az_names         = var.pub_subnet["PubSub1"].availability_zone
  az_names_private = var.pub_subnet["PubSub1"].availability_zone_private
  #var.availability_zones
}

resource "aws_subnet" "subnet-removeit-public" {
  # for_each          = { for idx, az_name in local.az_names : idx => az_name }
  # cidr_block        = cidrsubnet(var.vpc_cidr, 4, each.key)
  # availability_zone = local.az_names[each.key]
  # vpc_id            = aws_vpc.tmp-vpc-removeit.id


  count             = length(var.public_subnet)
  vpc_id            = aws_vpc.tmp-vpc-removeit.id
  cidr_block        = var.public_subnet[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  #availability_zone = var.subnet_private #local.az_names_private[each.key]


  map_public_ip_on_launch = true

  tags = {
    Name = "${local.workspace_name}-tmp-subnet-removeit-public"
  }
}

resource "aws_internet_gateway" "officehour-igw-removeit" {
  vpc_id = aws_vpc.tmp-vpc-removeit.id
  tags = {
    Name = "${local.workspace_name}-tmp-officehour-igw-removeit"
  }
}

resource "aws_route_table" "rt-removeit" {
  vpc_id = aws_vpc.tmp-vpc-removeit.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.officehour-igw-removeit.id
  }
  tags = {
    Name = "${local.workspace_name}-tmp-officehour-rt-removeit"
  }
}

resource "aws_route_table_association" "rt_associate_removeit_public" {
  count          = length(aws_subnet.subnet-removeit-public)
  subnet_id      = aws_subnet.subnet-removeit-public[count.index].id
  route_table_id = aws_route_table.rt-removeit.id
}

resource "aws_subnet" "subnet-removeit-public-NAT" {
  vpc_id            = aws_vpc.tmp-vpc-removeit.id
  cidr_block        = var.NAT_subnet_cidr
  availability_zone = var.availability_zone_NAT

  tags = {
    Name = "${local.workspace_name}-tmp-subnet-removeit-public-NAT-Gateway"
  }
}

resource "aws_eip" "removeit-eip" {
  count = 1
  vpc   = true
  tags = {
    Name = "${local.workspace_name}-tmp-removeit-eip"
  }
  depends_on = [
    aws_internet_gateway.officehour-igw-removeit
  ]
}

resource "aws_nat_gateway" "removeit-NAT-gw" {
  allocation_id = aws_eip.removeit-eip[0].id #aws_eip.removeit-eip.id
  subnet_id     = aws_subnet.subnet-removeit-public-NAT.id

  depends_on = [aws_internet_gateway.officehour-igw-removeit, aws_eip.removeit-eip]
  tags = {
    Name = "${local.workspace_name}-tmp-removeit-NAT-gw"
  }
}

resource "aws_route_table" "rt-removeit-NAT" {
  vpc_id = aws_vpc.tmp-vpc-removeit.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.removeit-NAT-gw.id
  }
  tags = {
    Name = "${local.workspace_name}-tmp-Route-Table-for-Private-subnet"
  }
}
data "aws_availability_zones" "available" {}

resource "aws_subnet" "subnet-removeit-private" {
  #for_each          = { for idx, az_name in local.az_names_private : idx => az_name }
  count  = length(var.private_subnet)
  vpc_id = aws_vpc.tmp-vpc-removeit.id
  #cidr_block        = var.subnet1_cidr #cidrsubnet(var.vpc_cidr, 1, each.key)
  cidr_block        = var.private_subnet[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  #availability_zone = var.subnet_private #local.az_names_private[each.key]
  map_public_ip_on_launch = false
  tags = {
    Name = "${local.workspace_name}-tmp-subnet-removeit-private"
  }
}

resource "aws_route_table_association" "rt_removeit_associate_private" {
  subnet_id      = aws_subnet.subnet-removeit-public-NAT.id
  route_table_id = aws_route_table.rt_removeit_private.id
}

resource "aws_route_table" "rt_removeit_private" {
  vpc_id = aws_vpc.tmp-vpc-removeit.id
  tags = {
    Name = "${local.workspace_name}-tmp-Route-Table-for-the-Private-Subnet"
  }
}

resource "aws_route_table_association" "rt_associate_private_2" {
  count     = length(aws_subnet.subnet-removeit-private)
  subnet_id = aws_subnet.subnet-removeit-private[count.index].id
  #subnet_id      = aws_subnet.subnet-removeit-private.id
  route_table_id = aws_route_table.rt_removeit_private.id
}