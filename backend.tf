terraform {
  backend "gcs" {
    bucket = "datalabs-hs-tfstate"
    prefix = "apigee-from-empty/state"
  }
}
