terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.53.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "mybucket" {
  bucket = "rag8953873411"

  tags = {
    Name = "rag8953873411"
  }
}

resource "aws_s3_bucket_public_access_block" "mybucket" {
  bucket = aws_s3_bucket.mybucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "time_sleep" "wait_10_seconds" {
  depends_on = [aws_s3_bucket.mybucket]

  create_duration = "10s"
}


# This resource will create (at least) 30 seconds after null_resource.previous
#resource "null_resource" "next" {
#  depends_on = [time_sleep.wait_30_seconds]
#}

resource "aws_s3_bucket_policy" "mybucket" {
  bucket = aws_s3_bucket.mybucket.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicRead",
      "Effect": "Allow",
      "Principal": "*",
      "Action": ["s3:GetObject"],
      "Resource": [
        "arn:aws:s3:::rag8953873411/*"
      ]
    }
  ]
}
EOF
  depends_on = [time_sleep.wait_10_seconds]
}

resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.mybucket.id
  key    = "index.hmtl"
  source = "index.html"

}