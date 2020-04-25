resource "aws_s3_bucket" "frontend-elb-logs" {
  bucket = "mydev-frontend-elb-logs"
  acl = "private"
  tags = {
    Name = "mydev-frontend-elb-logs"
    Environment = "dev"
  }
}