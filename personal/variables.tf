variable "test-group-managed-policy" {
  type = list
  default = [
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/IAMFullAccess"
  ]
}
