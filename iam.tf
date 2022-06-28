#resource "aws_iam_role" "iam_role_ec2" {
#  name = "iam_role_ec2"

#  assume_role_policy = <<EOF
#{
#  "Version": "2012-10-17",
#  "Statement": [
#    {
#      "Action": "sts:AssumeRole",
#      "Principal": {
#        "Service": "ec2.amazonaws.com"
#      },
#      "Effect": "Allow",
#      "Sid": ""
#    }
#  ]
#}
#EOF

#  tags = {
#      Name = "iam_role_ec2"
#  }
#}


#resource "aws_iam_role_policy" "ec2_s3_full_policy" {
#  name = "s3_full_policy"
#  role = aws_iam_role.iam_role_ec2.id

#  policy = <<EOF
#{
#  "Version": "2012-10-17",
#  "Statement": [
#    {
#      "Action": [
#        "s3:*"
#      ],
#      "Effect": "Allow",
#      "Resource": "*"
#    }
#  ]
#}
#EOF
#}


#resource "aws_iam_instance_profile" "iam_role_ec2_profile" {
#  name = "iam_role_ec2_profile"
#  role = "EMR_EC2_DefaultRole"
#}