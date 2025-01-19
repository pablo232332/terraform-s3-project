# terraform-aws-static-website-s3-cloudfront-acm

This Terraform deploys resources for a public static website using AWS S3 and Cloudfront with TLS and a public DNS entry together with a suitable ACM certificate and validation. The apex domain is aliased to the www subdomain. This is a useful base from which to deploy website content with e.g. Hugo. Optionally a sample webpage with text and an image may be deployed to demonstrate that the website is working. This code presumes that a hosted zone already exists in the same account for the domain in question - this is automatically provisioned for public domain names registered via Route53 as opposed to transferred from another provider. There are a bewilderment of options available for Cloudfront and S3. It simply isn't practical to include all possible options here. The choices made are appropriate for a personal website. 

By default 404 and 403 errors are redirected to `/index.html` but this is configurable and custom error responses may be specified as demonstrated in the accompanying  `examples/custom-error-response-and-bucket`


## Modules

No modules.

## Resources

| Name                                                                                                                                                      | Type        |
| --------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_acm_certificate.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate)                                   | resource    |
| [aws_acm_certificate_validation.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation)             | resource    |
| [aws_cloudfront_distribution.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution)                   | resource    |
| [aws_cloudfront_origin_access_control.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_control) | resource    |
| [aws_route53_record.domain_name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record)                              | resource    |
| [aws_route53_record.validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record)                               | resource    |
| [aws_route53_record.www_domain_name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record)                          | resource    |
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)                                               | resource    |
| [aws_s3_bucket_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy)                                 | resource    |
| [aws_s3_bucket_public_access_block.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block)       | resource    |
| [aws_s3_bucket_versioning.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning)                         | resource    |
| [aws_s3_object.sample_image](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object)                                       | resource    |
| [aws_s3_object.sample_index_html](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object)                                  | resource    |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)                        | data source |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone)                                      | data source |




