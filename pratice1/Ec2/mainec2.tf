resource "tls_private_key" "oskey" {
  algorithm = "RSA"
}

resource "local_file" "myterrakey" {
  content  = tls_private_key.oskey.private_key_pem
  filename = "myterrakey.pem"
}

resource "aws_key_pair" "key121" {
  key_name   = "myterrakey"
  public_key = tls_private_key.oskey.public_key_openssh
}
resource "aws_instance" "public" {
    ami                    = "ami-0cff7528ff583bf9a"
    instance_type          = "t2.micro"
    count = 2
    key_name               = aws_key_pair.key121.key_name
    iam_instance_profile   = var.iam_instance_profile
    vpc_security_group_ids      = var.sg_pub_id
    monitoring             = true
    subnet_id              = var.subnet_id_pub[count.index]
    associate_public_ip_address = true
    tags = {
        Name= "Public_instance"
    }
}
resource "aws_instance" "private" {
    ami                    = "ami-0cff7528ff583bf9a"
    count = 2
    instance_type          = "t2.micro"
    key_name               = aws_key_pair.key121.key_name
    iam_instance_profile = var.iam_instance_profile
    vpc_security_group_ids      = var.sg_priv_id
    monitoring             = true
    subnet_id              = var.subnet_id_pri[count.index]
    tags = {
        Name= "Private_instance"
    }
  
}
