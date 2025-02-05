resource "aws_cloudfront_distribution" "this" {
  provider = aws.us-east-1

  origin {
    domain_name              = aws_s3_bucket.this.bucket_regional_domain_name
    origin_id                = local.s3_origin_id
    origin_access_control_id = aws_cloudfront_origin_access_control.this.id
  }

  aliases = [
    var.domain_name,
    "www.${var.domain_name}"
  ]

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = var.cloudfront_default_root_object

  default_cache_behavior {
    allowed_methods = [
      "GET",
      "HEAD",
    ]

    cached_methods = [
      "GET",
      "HEAD",
    ]

    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"

    
    min_ttl     = var.cloudfront_min_ttl
    default_ttl = var.cloudfront_default_ttl
    max_ttl     = var.cloudfront_max_ttl
  }

  price_class = var.cloudfront_price_class

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  dynamic "viewer_certificate" {
    for_each = [aws_acm_certificate.this.id]
    content {
      acm_certificate_arn      = aws_acm_certificate.this.arn
      ssl_support_method       = "sni-only"
      minimum_protocol_version = var.cloudfront_minimum_protocol_version
    }
  }

  dynamic "custom_error_response" {
    for_each = var.cloudfront_custom_error_responses
    content {
      error_code            = custom_error_response.value.error_code
      response_code         = custom_error_response.value.response_code
      error_caching_min_ttl = custom_error_response.value.error_caching_min_ttl
      response_page_path    = custom_error_response.value.response_page_path
    }
  }


  wait_for_deployment = false

  depends_on = [
    # Hope to avoid errors like
    #
    # │ Error: error creating CloudFront Distribution: InvalidViewerCertificate: The specified SSL certificate doesn't exist, isn't in us-east-1 region, isn't valid, or doesn't include a valid certificate chain.
    # │       status code: 400, request id: 281f6901-fe5b-472b-a357-d918449f7b60
    # │ 
    # │   with module.static-website-s3-cloudfront-acm.aws_cloudfront_distribution.this,
    # │   on ../../cloudfront.tf line 1, in resource "aws_cloudfront_distribution" "this":
    # │    1: resource "aws_cloudfront_distribution" "this" {
    aws_acm_certificate.this,
    aws_acm_certificate_validation.this
  ]
}

resource "aws_cloudfront_origin_access_control" "this" {
  name                              = var.domain_name
  description                       = "${var.domain_name} OAC"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}