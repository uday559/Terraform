module "vpc" {
  source = "/home/cloud_user/pratice1/VPC"
}

module "security_group" {
    source = "/home/cloud_user/pratice1/Security Group"
    vpcid = module.vpc.vpc_id
}

module "IAM" {
    source = "/home/cloud_user/pratice1/IAM"
}

module "Autoscaling" {
    source = "/home/cloud_user/pratice1/Auto Scaling"
    security_groups = module.security_group.security_group_private
    vpc_zone_identifier= module.vpc.subnets
}

module "Loadbalancer" {
    source = "/home/cloud_user/pratice1/LoadBalancer"
    vpcid = module.vpc.vpc_id
    #count = module.vpc.public_count
    subnets  = module.vpc.subnets
    security_groups = module.security_group.security_group_private
}

module "ec2_public" {
    source = "/home/cloud_user/pratice1/Ec2"
    iam_instance_profile   = module.IAM.iam_profile
    sg_pub_id = module.security_group.security_group_public
    sg_priv_id = module.security_group.security_group_private
    subnet_id_pub             =module.vpc.public_subnet
    subnet_id_pri             =module.vpc.public_subnet
}

