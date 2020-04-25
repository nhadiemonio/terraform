resource "aws_elb" "frontend-web-elb" {
  depends_on = [aws_instance.web-host]
  subnets = [
    aws_subnet.frontend-subnet["az1"].id,
    aws_subnet.frontend-subnet["az2"].id,
    aws_subnet.frontend-subnet["az3"].id
  ]
  name = "frontend-web-elb"
  instances = [
    aws_instance.web-host["az1"].id,
    aws_instance.web-host["az2"].id,
    aws_instance.web-host["az3"].id
  ]
  security_groups = [
    aws_security_group.allow-public-web.id
  ]
  listener {
    instance_port = 80
    instance_protocol = "tcp"
    lb_port = 80
    lb_protocol = "tcp"
  }
  tags = {
    Name = "frontend-web-elb"
    Environment = "dev"
  }
}