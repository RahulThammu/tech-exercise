resource  "google_compute_router" "router" {
    name = "router"
    region = "europe-west2"
    network = google_compute_network.vpc-main.id
     project = google_project.project.project_id
}