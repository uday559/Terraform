resource "aws_autoscaling_group" "asg" {
  min_size             = 1
  desired_capacity     = 1
  max_size             = 2
launch_configuration = "${aws_launch_configuration.config.name}"
enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]
metrics_granularity = "1Minute"
vpc_zone_identifier  = var.vpc_zone_identifier
# Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_configuration" "config" {

  image_id = "ami-0cff7528ff583bf9a" 
  instance_type = "t2.micro"
  security_groups = var.security_groups
  associate_public_ip_address = true
lifecycle {
    create_before_destroy = true
  }
}
