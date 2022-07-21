data "aws_iam_policy_document" "Terraform-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "instance" {
  name               = "instance_role"
  path               = "/home/ec2-user/IAM/"
  assume_role_policy = data.aws_iam_policy_document.Terraform-role-policy.json
}

resource "aws_iam_instance_profile" "ec2_profile" {
    name="ec2_profile"
    role=aws_iam_role.instance.name
  
}
output "iam_profile" {

  value=aws_iam_instance_profile.ec2_profile.name
  
}