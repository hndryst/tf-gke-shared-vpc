terraform {
  backend "gcs" {
    bucket = "var.bucket"
    prefix = "gke-shared-vpc/state"
  }
}

/*
need backend.tfvars file with the bucket name
bucket = "bucketname"
*/
