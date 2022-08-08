# Terraform
Crated total infrastructure using Terraform in AWS
 
  create a VPC with 4 subnets-  2 public & 2 private  ( us-west-1 region)
  private - Nat gateway , public - internet gateway
  create a ec2 , one  public & one private ( amazon  linux 2 AMI)
  should share same key pair.
  Should be attached to IAM role (create a TPL file for IAM policy & call the TPL file in the template function & consume in IAM role) with admin policy.
  Should be attach SG - with ssh port (22 )
  one should be attached be autoscaling and lauch configuration - Private instance
  HAs to be attached to a application load balancer.

  Modules
   vpc , ec2, IAM , SG , Load balancer.
