resource "aws_vpc" "tmp-vpc-removeit" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${local.workspace_name}-tmp-vpc-removeit"

  }
}


