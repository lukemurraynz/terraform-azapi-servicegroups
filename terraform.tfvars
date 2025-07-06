# Azure Service Groups - Example Configuration
# Copy this file to terraform.tfvars and update with your values

# Required: Your Azure tenant ID
tenant_id = "your-tenant-id-here"

# Environment configuration
environment       = "production"
organization_name = "contoso"
cost_center      = "IT-Operations"

# Enable extended hierarchy (creates additional nested service groups)
enable_extended_hierarchy = true

# Platform Teams Configuration
platform_teams = {
  infrastructure = {
    enabled     = true
    displayName = "Platform Infrastructure"
  }
  devops = {
    enabled     = true
    displayName = "Platform DevOps"
  }
  data = {
    enabled     = true
    displayName = "Platform Data"
  }
}

# Application Teams Configuration
application_teams = {
  customer_experience = {
    enabled     = true
    displayName = "Customer Experience"
  }
  internal_operations = {
    enabled     = true
    displayName = "Internal Operations"
  }
}

# Security and Compliance Configuration
security_compliance = {
  enabled     = true
  displayName = "Security & Compliance"
}

# Additional tags for all service groups
common_tags = {
  managed_by    = "platform-engineering"
  deployed_with = "terraform"
  iac_source    = "azure-service-groups"
  project       = "enterprise-governance"
}
