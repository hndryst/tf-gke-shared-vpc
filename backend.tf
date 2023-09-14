terraform {
  backend "gcs" {
    bucket = "var.bucket"
    prefix = "gke-shared-vpc/state"
  }
}

/*
terraform init -backend-config=backend.hcl
need backend.hcl file with the bucket name and prefix
bucket = "bucketname"
prefix = "dirname/state"
*/
