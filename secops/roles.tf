resource "google_project_iam_custom_role" "storage-object-ro" {
  role_id     = "object_ro"
  title       = "Storage Object RO"
  description = "Allow read access to bucket objects"
  permissions = ["storage.objects.get", "storage.objects.list"]
}


resource "google_project_iam_custom_role" "compute_instance_setTags" {
  role_id     = "compute_tags"
  title       = "Compute Tag Instances"
  description = "Allow creation of instance tags"
  permissions = ["compute.instances.setTags"]
}
