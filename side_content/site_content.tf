resource "aws_s3_object" "sample_home_html" {
  count        = var.deploy_sample_content == true ? 1 : 0
  bucket       = aws_s3_bucket.this.id
  key          = "web/home.html"
  source       = "${path.module}/site_content/home.html"
  etag         = filemd5("${path.module}/site_content/home.html")
}

resource "aws_s3_object" "sample_logo_blue" {
  count        = var.deploy_sample_content == true ? 1 : 0
  bucket       = aws_s3_bucket.this.id
  key          = "images/Logo_Blue.png" 
  source       = "${path.module}/site_content/Logo_Blue.png" 
  content_type = "image/png" 
  etag         = filemd5("${path.module}/site_content/Logo_Blue.png")
}
