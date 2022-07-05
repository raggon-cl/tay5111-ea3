resource "random_string" "s3_name" {
  length           = 10
  special          = false
  upper            = false
  override_special = "/@£$"
}

resource "aws_s3_bucket" "bucket-s3" {
  bucket = "tay5111-${random_string.s3_name.result}"

  tags = {
    Name        = "tay5111-${random_string.s3_name.result}"
    Environment = "prd"
  }
}

resource "aws_s3_bucket_acl" "bucket-s3-acl" {
  bucket = aws_s3_bucket.bucket-s3.id
  acl    = "private"
}

resource "aws_s3_object" "upload-index-file" {
  bucket = aws_s3_bucket.bucket-s3.id
  key    = "index.php"
  source = "index.php"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("index.php")
}