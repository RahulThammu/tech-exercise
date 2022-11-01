resource "google_project_service" "project" {
 project = var.project-id
  service   = "bigquery.googleapis.com"
}


resource "google_bigquery_dataset" "dataset" {

  for_each = var.bigquery_role_assignment

  dataset_id    = each.key

  location                    = "EU"
  default_table_expiration_ms = 3600000
  project = var.project-id

   depends_on = [
        google_project_service.project
        
    ]
}

resource "google_bigquery_dataset_access" "access" {
  project = var.project-id
  
   for_each = var.bigquery_role_assignment

    dataset_id    = each.key
    role          = each.value.role
    user_by_email = each.value.user

    depends_on = [google_bigquery_dataset.dataset, google_project_service.project]
}