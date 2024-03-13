variable "cdn_name" {
  type        = string
  description = <<-EOT
    ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.
    This is the only ID element not also included as a tag.
    The "name" tag is set to the full id string. There is no tag with the value of the name input.
    EOT
  default     = null
}

variable "acm_certificate_arn" {
  type        = string
  default     = ""
  description = "Existing ACM Certificate ARN"
}

variable "allow_ssl_requests_only" {
  type        = bool
  default     = true
  description = "Set to true to require requests to use Secure Socket Layer (HTTPS/SSL). This will explicitly deny access to HTTP requests"
}

variable "block_origin_public_access_enabled" {
  type        = bool
  default     = false
  description = "When set to 'true' the s3 origin bucket will have public access block enabled"
}

variable "cloudfront_access_log_create_bucket" {
  type        = bool
  default     = true
  description = <<-EOT
    When true and cloudfront_access_logging_enabled is also true, this module will create a new,
    separate S3 bucket to receive Cloudfront Access Logs.
    EOT
}

variable "custom_error_response" {
  # http://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/custom-error-pages.html#custom-error-pages-procedure
  # https://www.terraform.io/docs/providers/aws/r/cloudfront_distribution.html#custom-error-response-arguments
  type = list(object({
    error_caching_min_ttl = string
    error_code            = string
    response_code         = string
    response_page_path    = string
  }))
  default     = []
  description = "List of one or more custom error response element maps"
}

variable "external_aliases" {
  type        = list(string)
  default     = []
  description = "List of FQDN's - Used to set the Alternate Domain Names (CNAMEs) setting on Cloudfront. No new route53 records will be created for these"
}

variable "index_document" {
  type        = string
  default     = "index.html"
  description = "Amazon S3 returns this index document when requests are made to the root domain or any of the subfolders"
}

variable "log_expiration_days" {
  type        = number
  default     = 90
  description = <<-EOT
    Number of days after object creation to expire Cloudfront Access Log objects.
    Only effective if cloudfront_access_log_create_bucket is true.
    EOT
}

variable "log_glacier_transition_days" {
  type        = number
  default     = 60
  description = <<-EOT
    Number of days after object creation to move Cloudfront Access Log objects to the glacier tier.
    Only effective if cloudfront_access_log_create_bucket is true.
    EOT
}

variable "log_standard_transition_days" {
  type        = number
  default     = 30
  description = <<-EOT
    Number of days after object creation to move Cloudfront Access Log objects to the infrequent access tier.
    Only effective if cloudfront_access_log_create_bucket is true.
    EOT
}

variable "log_versioning_enabled" {
  type        = bool
  default     = false
  description = <<-EOT
    Set true to enable object versioning in the created Cloudfront Access Log S3 Bucket.
    Only effective if cloudfront_access_log_create_bucket is true.
    EOT
}

variable "s3_website_password_enabled" {
  type        = bool
  default     = false
  description = <<-EOT
    If set to true, and website_enabled is also true, a password will be required in the Referrer field of the
    HTTP request in order to access the website, and Cloudfront will be configured to pass this password in its requests.
    This will make it much harder for people to bypass Cloudfront and access the S3 website directly via its website endpoint.
    EOT
}

variable "versioning_enabled" {
  type        = bool
  default     = true
  description = "When set to 'true' the s3 origin bucket will have versioning enabled"
}

variable "website_enabled" {
  type        = bool
  default     = false
  description = <<-EOT
    Set to true to enable the created S3 bucket to serve as a website independently of Cloudfront,
    and to use that website as the origin. See the README for details and caveats. See also s3_website_password_enabled.
    EOT
}

variable "namespace" {
  type = string
  default = "test"
}

variable "name" {
  type = string
  default = "cdn"
}

variable "stage" {
  type = string
  default = "poc12"
}

variable "tags" {
  type = map(string)
}

variable "region" {
  type = string
}

variable "cwl_name" {
  type = string
}

variable "retention_in_days" {
  type = string
}