# Terraform AWS Static Website

This Terraform module deploys a secure static website on AWS using S3 for storage, CloudFront for CDN, ACM for SSL/TLS certificates, and Route53 for DNS management. It supports custom domains, HTTPS enforcement, and optional sample content.

## Table of Contents

-   [Architecture Overview](#architecture-overview)
-   [Prerequisites](#prerequisites)
-   [Configuration Guide](#configuration-guide)
    -   [Input Variables](#input-variables)
    -   [File Structure](#file-structure)
-   [Deployment Steps](#deployment-steps)
-   [Outputs](#outputs)
-   [Custom Error Handling](#custom-error-handling)
-   [Cost Considerations](#cost-considerations)
-   [Troubleshooting](#troubleshooting)
-   [Cleanup](#cleanup)

## Architecture Overview

![AWS Architecture](https://via.placeholder.com/800x400.png?text=S3+%2B+CloudFront+%2B+Route53+Architecture)

*Components:*

1.  **S3 Bucket**: Stores static assets (HTML, images) with versioning and blocked public access.
2.  **CloudFront**: Global CDN with caching, SSL/TLS, and custom error pages.
3.  **ACM**: Manages SSL/TLS certificates for the domain.
4.  **Route53**: DNS records for domain apex (`example.com`) and `www` redirect.
5.  **IAM**: Security policies restricting S3 access to CloudFront only.

## Prerequisites

1.  **AWS Account**: With permissions for S3, CloudFront, ACM, Route53, and IAM.
2.  **Domain Name**: Registered with Route53 hosted zone (e.g., `example.com`).
3.  **Terraform**: Version `>= 1.5.0` installed.
4.  **AWS CLI**: Configured with credentials (`aws configure`).
5.  **Certificate Region**: **Critical** – ACM certificates for CloudFront must be created in `us-east-1` (N. Virginia).
    * ⚠️ The current configuration uses `eu-central-1` (Frankfurt) for ACM, which will cause errors. Modify `providers.tf` to use `us-east-1` for ACM resources.

## Configuration Guide

### Input Variables

Set variables in `terraform.tfvars` or via CLI. Key variables:

| Variable                   | Description                                          | Default           | Required |
| :------------------------- | :--------------------------------------------------- | :---------------- | :------- |
| `domain_name`              | Root domain (e.g., `example.com`)                     | -                 | Yes      |
| `cloudfront_price_class`   | CDN cost tier (`PriceClass_100`, `PriceClass_200`, etc.) | `PriceClass_100`  | No       |
| `deploy_sample_content`    | Deploy sample `home.html` and `Logo_Blue.png`           | `false`           | No       |
| `s3_bucket_versioning`     | Enable S3 bucket versioning                            | `false`           | No       |
| `cloudfront_min_ttl`       | Minimum cache TTL (seconds)                            | `0`               | No       |

**Full list**: See [variables.tf](./variables.tf).

### File Structure



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




