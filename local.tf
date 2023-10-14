variable "subnet_cidr" {
  description = "CIDR block for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}

local {
  subnet_base_cidr = "10.0.0.0/16"  # The base CIDR block for the VPC
  subnet_cidr      = cidrsubnet(local.subnet_base_cidr, 8, 1 + var.subnet_cidr_offset)
}

resource "aws_vpc" "example" {
  cidr_block = local.subnet_base_cidr
  # Other VPC configuration settings go here.
}

resource "aws_subnet" "example" {
  count             = 3
  cidr_block        = local.subnet_cidr[count.index]
  vpc_id            = aws_vpc.example.id
  availability_zone = "us-west-2a" # Replace with your desired availability zones.
  # Other subnet configuration settings go here.
}
