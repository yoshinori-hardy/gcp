// Configure the Google Cloud provider
provider "google" {
  credentials = "${file("auth.json")}"
  project     = "gcedop"
  region      = "eu-west2"
}
