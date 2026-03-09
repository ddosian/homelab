terraform {
  backend "s3" {
    bucket   = "ddosterraform"
    key      = "terraform.tfstate"
    region   = "us-west-004"

    endpoints = {
      s3 = "https://s3.us-west-004.backblazeb2.com"
    }

    skip_credentials_validation  = true
    skip_metadata_api_check      = true
    skip_region_validation       = true
    skip_requesting_account_id   = true
    force_path_style             = true
  }
}