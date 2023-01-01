terraform {
  backend "gcs" {
    bucket = "var.bucket"
    prefix = "apigee-from-empty/state"
  }
}

/*
need backend.tfvars file with the bucket name
bucket = "bucketname"
*/
