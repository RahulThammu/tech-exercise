resource "google_project_service" "compute" {
    service = "compute.googleapis.com"
    project = google_project.project.project_id
}

resource "google_project_service" "container" {
    service = "container.googleapis.com"
    project = google_project.project.project_id
}

resource "google_compute_network" "vpc-main" {
    name                            = "vpc-main"
    routing_mode                    = "REGIONAL"
    auto_create_subnetworks         = false
    mtu                             = 1460
    delete_default_routes_on_create = false
    project = google_project.project.project_id
    depends_on = [
        google_project_service.compute,
        google_project_service.container
    ]
}
