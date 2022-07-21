resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  }

resource "aws_subnet" "public" {
  count = length(var.public_subnet)
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnet[count.index]
  #availability_zone = "${var.availability_zones[count.index]}"
}
resource "aws_internet_gateway" "IGW" {
   vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "publicrt" {
  vpc_id = aws_vpc.main.id
    route {
    cidr_block = "0.0.0.0/0"              
    gateway_id = aws_internet_gateway.IGW.id
     }
}
resource "aws_route_table_association" "publicrta" {
  count = length(var.public_subnet)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.publicrt.id
}

resource "aws_subnet" "private" {
  count = length(var.private_subnet)
  vpc_id = aws_vpc.main.id
  cidr_block = var.private_subnet[count.index]
  #availability_zone = "${var.availability_zones[count.index]}"
}
resource "aws_route_table" "privatert" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"              
    gateway_id = aws_internet_gateway.IGW.id
     }
}
resource "aws_route_table_association" "privaterta" {
  count = length(var.private_subnet)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.privatert.id
}
resource "aws_eip" "nateIP" {
   count = length(var.public_subnet)
   vpc   = true
 }
 resource "aws_nat_gateway" "NATgw" {
   count = length(var.public_subnet)
   allocation_id = "${aws_eip.nateIP[count.index].id}"
   subnet_id = element(aws_subnet.public.*.id, count.index)
   }
output "public_subnet" {
  value = aws_subnet.public.*.id
}
output "private_subnet" {
  value = aws_subnet.private.*.id
}
output "public_count" {
  value = length(var.public_subnet)
}

output "subnets" {
  value= aws_subnet.public.*.id
}
output "vpc_id" {

  value=aws_vpc.main.id

}
