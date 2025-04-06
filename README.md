# Terraform AWS Static Website

This Terraform module deploys a secure static website on AWS using S3 for storage, CloudFront for CDN, ACM for SSL/TLS certificates, and Route53 for DNS management. It supports custom domains, HTTPS enforcement, and optional sample content.


## Key Features

* **Automated Deployment:** Uses Terraform to provision and configure all necessary AWS resources.
* **Static Website Hosting:** Hosts website files in an Amazon S3 bucket.
* **Content Delivery Network (CDN):** Utilizes Amazon CloudFront for fast content delivery and caching.
* **HTTPS Support:** Enables secure connections with HTTPS via an AWS Certificate Manager (ACM) certificate.
* **Custom Domain Configuration:** Configures DNS settings in Amazon Route 53 to use your own domain.
* **Domain Aliases:** Supports multiple domain names for your website.
* **"www" Redirection:** Automatically redirects traffic from the "www" subdomain to the main domain (or vice versa, depending on configuration).
* **SSL Certificate Generation and Validation:** Handles the creation and validation of the necessary SSL certificate.
* **Restricted S3 Bucket Access:** Configures the S3 bucket with appropriate permissions to ensure security.
* **Example Content Deployment (Optional):** Allows for the deployment of sample HTML and image files.
* **Custom Error Page Configuration:** Enables the configuration of custom error pages for a better user experience.
* **Security Policy Configuration:** Provides options to configure security policies for the deployed resources.

## Architecture

The following AWS services are utilized by these Terraform files:

* **Amazon S3:** For storing the static website files.
* **Amazon CloudFront:** As a CDN to cache and distribute the website content globally.
* **AWS Certificate Manager (ACM):** To provision and manage the SSL/TLS certificate for HTTPS.
* **Amazon Route 53:** For managing DNS records and routing traffic to the CloudFront distribution.


## Configuration

The module offers various configuration options that can be set through Terraform variables. These include:

* Domain name
* AWS region
* Whether to deploy example content
* Custom error page settings
* Security policy configurations

Refer to the `variables.tf` file for a complete list of available variables and their descriptions.



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

## Usage

Once the deployment is complete, you can upload your static website files to the designated S3 bucket. The CloudFront distribution will automatically pick up the changes and serve your website.


## Deployment Steps

1.  **Prepare Sample Content** (Optional):
    Create a `site_content/` directory with:
    -   `home.html`: Your homepage.
    -   `Logo_Blue.png`: Brand logo (optional).

2.  **Initialize Terraform**:

    ```bash
    terraform init
    ```

3.  **Review Plan**:

    ```bash
    terraform plan -var="domain_name=example.com"
    ```

4.  **Deploy Infrastructure**:

    ```bash
    terraform apply -var="domain_name=example.com"
    ```

    Confirm with `yes`.

5.  **Verify DNS**:
    Ensure your domain’s NS records point to the Route53 hosted zone.



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




