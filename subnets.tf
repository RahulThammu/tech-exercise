resource "google_compute_subnetwork" "private-subnet" {
    name                        = "private-subnet"
    ip_cidr_range               = "10.0.0.0/18"
    region                      =  "europe-west2"
    network                     =  google_compute_network.vpc-main.id
    private_ip_google_access    = true
     project = google_project.project.project_id

    secondary_ip_range {
        range_name      = "cluster-pod-range"
        ip_cidr_range   = "10.48.0.0/14"
    }

    secondary_ip_range {
        range_name      = "cluster-service-range"
        ip_cidr_range   = "10.52.0.0/20"
    }
}