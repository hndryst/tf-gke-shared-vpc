variable "project" {
  type    = string
  default = ""
}
variable "region" {
  type    = string
  default = "asia-southeast2"
}
variable "zone" {
  type    = string
  default = "asia-southeast2-a"
}
variable "compute_sa" {
  type    = string
  default = "tf-compute-sa"
}
/*
need terraform.tvars file with GPC Project ID config
project= "projectID"
*/
