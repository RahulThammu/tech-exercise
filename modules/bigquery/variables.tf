variable "project-id"{
    
}


variable "bigquery_role_assignment" {
    type = map(object({        
            role = string
            user = string          
    }))
}



 