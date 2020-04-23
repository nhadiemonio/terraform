resource "aws_iam_group" "test-group" {
  name = "test-group"
}

resource "aws_iam_group_policy_attachment" "attach-test-group-managed-policy" {
  depends_on = [aws_iam_group.test-group]
  group = aws_iam_group.test-group.name
  count = length(var.test-group-managed-policy)
  policy_arn = var.test-group-managed-policy[count.index]
}

resource "aws_iam_policy" "test-group-custom-policy" {
  depends_on = [aws_iam_group.test-group]
  name = "LightsailFullAccess"
  policy = <<-EOT
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "lightsail:*"
      ],
      "Resource": "*"
      }
    ]
  }
  EOT
}

resource "aws_iam_group_policy_attachment" "attach-test-group-custom-policy" {
  group = aws_iam_group.test-group.name
  policy_arn = aws_iam_policy.test-group-custom-policy.arn
}

