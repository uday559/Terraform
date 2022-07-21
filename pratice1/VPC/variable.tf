/*variable "availability_zones" {
  description = "AZs in this region to use"
  default = ["eu-east-1a", "eu-east-1b"] #us-east-1a, us-east-1b
  type = "list"
}*/

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet" {
   default = ["10.0.10.0/24","10.0.20.0/24"]
   type = list
}
variable "private_subnet" {
  default = ["10.0.30.0/24","10.0.40.0/24"]
  type = list
}