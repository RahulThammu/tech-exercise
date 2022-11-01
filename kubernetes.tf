resource "google_container_cluster" "primary" {
    name = "primary"
    location = "europe-west2-a"
    project = google_project.project.project_id
    remove_default_node_pool = true
    initial_node_count = 1
    network = google_compute_network.vpc-main.self_link
    subnetwork = google_compute_subnetwork.private-subnet.self_link
    networking_mode = "VPC_NATIVE"

    node_locations = [
        "europe-west2-b", "europe-west2-c"
    ]

    addons_config {
        http_load_balancing {
            disabled = true
        }

        horizontal_pod_autoscaling {
            disabled = false
        }
    }

    release_channel {
        channel = "REGULAR"
    }

    workload_identity_config {
        workload_pool = "${google_project.project.project_id}.svc.id.goog"

    }

    ip_allocation_policy {
        cluster_secondary_range_name = "cluster-pod-range"
        services_secondary_range_name = "cluster-service-range"
    }

    private_cluster_config {
        enable_private_nodes = true
        enable_private_endpoint = false
        master_ipv4_cidr_block = "172.16.0.0/28"
    }
}