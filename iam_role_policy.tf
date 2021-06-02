resource "aws_iam_policy" "allow_ec2" {
  name= "ec2-access"
  description = "this policy will allow terraform to create resources but will be attached to ec2"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
"Action": [
"s3:*"
],
"Effect": "Allow",
"Resource": "*"
    },
    {
"Action": [
"ec2:*"
],
"Effect": "Allow",
"Resource": "*"
    },
    {
"Action": [
"route53:*"
],
"Effect": "Allow",
"Resource": "*"
},
{
"Effect": "Allow",
"Action": "*",
"Resource": "*"
}
]
}
EOF
}


resource "aws_iam_role_policy_attachment" "ec2-attach" {
role="${ aws_iam_role.Terraform-role.name}"
policy_arn = "${aws_iam_policy.allow_ec2.arn}"
}      
