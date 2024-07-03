resource "random_id" "bucket" {
  byte_length = 8
}

resource "aws_s3_bucket" "mybucket" {
  bucket = "mybucket-${random_id.bucket.hex}"

  tags = {
    Name = "mybucket-${random_id.bucket.hex}"
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
  depends_on      = [aws_s3_bucket.mybucket]
  create_duration = "10s"
}


resource "aws_s3_bucket_policy" "mybucket" {
  bucket     = aws_s3_bucket.mybucket.id
  policy     = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicRead",
      "Effect": "Allow",
      "Principal": "*",
      "Action": ["s3:GetObject"],
      "Resource": [
        "arn:aws:s3:::${aws_s3_bucket.mybucket.id}/*"
      ]
    }
  ]
}
EOF
  depends_on = [time_sleep.wait_10_seconds]
}

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.mybucket.id
  key    = "index.php"
  source = "index.php"
  content_type = "text/html"

}

