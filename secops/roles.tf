resource "google_project_iam_custom_role" "storage-object-ro" {
  role_id     = "object-ro"
  title       = "Storage Object RO"
  description = "Allow read access to bucket objects"
  permissions = ["storage.objects.get", "storage.objects.list"]
}

resource "google_project_iam_custom_role" "compute-instance-setTags" {
  role_id     = "compute-tags"
  title       = "Compute Tag Instances"
  description = "Allow creation of instance tags"
  permissions = ["compute.instances.setTags"]
}