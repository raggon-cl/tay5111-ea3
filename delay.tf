resource "time_sleep" "wait_seconds" {
  create_duration = "480s"
  depends_on      = [aws_s3_bucket.bucket-s3]
}


