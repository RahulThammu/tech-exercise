resource "random_id" "new_project" {
  byte_length = 8
}

data "google_billing_account" "acct" {
  display_name = "My Billing Account"
  open         = true
}

resource "google_project" "project" {
  name       = "techexercise"
  project_id = "te${(random_id.new_project.hex)}"
  billing_account = data.google_billing_account.acct.id
}

module "role-assignment" {
  source = "./modules/bigquery"

project-id = google_project.project.project_id

 bigquery_role_assignment = {
  vmo2_tech_test = {                    # dataset name 
    role = "roles/bigquery.dataEditor"  # gcp role
    user = "rahul.thammu@gmail.com"       # google email address of user
  }
}
}

