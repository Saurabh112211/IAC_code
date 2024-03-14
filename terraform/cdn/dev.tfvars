cdn_name = "cdn"
allow_ssl_requests_only = false
block_origin_public_access_enabled = false
cloudfront_access_log_create_bucket = true
custom_error_response = [
    {
        error_caching_min_ttl = 10
        error_code            = 403
        response_code         = 200
        response_page_path    = "/index.html"
    },
    {
        error_caching_min_ttl = 10
        error_code            = 404
        response_code         = 200
        response_page_path    = "/index.html"
    }
]
index_document = "index.html"
log_expiration_days = 90
log_glacier_transition_days = 60
log_standard_transition_days = 30
log_versioning_enabled = false
s3_website_password_enabled = false
versioning_enabled = true
website_enabled = false
tags      = {
    project = "test"
    enviroment = "poc"
  } 
region = "us-east-1"
cwl_name = "log-cdn"
retention_in_days = "30"