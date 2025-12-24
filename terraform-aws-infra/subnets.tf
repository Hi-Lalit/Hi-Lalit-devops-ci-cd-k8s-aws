resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.devops_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"  # choose a supported AZ
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}


resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.devops_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"  # make sure instance type is supported

  tags = {
    Name = "private-subnet"
  }
}

