# Azure Service Groups - Outputs

# Service Group Resource IDs
output "service_group_ids" {
  description = "Map of service group names to their resource IDs"
  value = {
    platform_engineering    = azapi_resource.platform_engineering.id
    platform_infrastructure = azapi_resource.platform_infrastructure.id
    platform_devops         = azapi_resource.platform_devops.id
    platform_data           = azapi_resource.platform_data.id
    application_teams       = azapi_resource.application_teams.id
    customer_experience     = azapi_resource.customer_experience.id
    ecommerce_platform      = azapi_resource.ecommerce_platform.id
    customer_support        = azapi_resource.customer_support.id
    internal_operations     = azapi_resource.internal_operations.id
    finance_systems         = azapi_resource.finance_systems.id
    human_resources         = azapi_resource.human_resources.id
    security_compliance     = azapi_resource.security_compliance.id
    identity_access         = azapi_resource.identity_access.id
  }
}

# Service Group Members
output "service_group_members" {
  description = "Service group member relationships"
  value = {
    storage_account_member     = azapi_resource.storage_account_member.id
    resourcegroup_ecommerce_member = azapi_resource.resourcegroup_ecommerce_member.id
  }
}

# Service Group Names
output "service_group_names" {
  description = "Map of service group logical names to their Azure resource names"
  value = {
    platform_engineering    = azapi_resource.platform_engineering.name
    platform_infrastructure = azapi_resource.platform_infrastructure.name
    platform_devops         = azapi_resource.platform_devops.name
    platform_data           = azapi_resource.platform_data.name
    application_teams       = azapi_resource.application_teams.name
    customer_experience     = azapi_resource.customer_experience.name
    ecommerce_platform      = azapi_resource.ecommerce_platform.name
    customer_support        = azapi_resource.customer_support.name
    internal_operations     = azapi_resource.internal_operations.name
    finance_systems         = azapi_resource.finance_systems.name
    human_resources         = azapi_resource.human_resources.name
    security_compliance     = azapi_resource.security_compliance.name
    identity_access         = azapi_resource.identity_access.name
  }
}

# Hierarchical Structure for Documentation
output "service_group_hierarchy" {
  description = "Hierarchical structure of service groups for documentation"
  value = {
    "Root (Tenant: ${local.tenant_id})" = {
      "Platform Engineering" = {
        "Platform Infrastructure" = "Core infrastructure services"
        "Platform DevOps"         = "CI/CD and developer tooling"
        "Platform Data"           = "Data platform and analytics"
      }
      "Application Teams" = {
        "Customer Experience" = {
          "E-commerce Platform" = "Shopping and payment services"
          "Customer Support"    = "Support and service tools"
        }
        "Internal Operations" = {
          "Finance Systems"  = "Financial applications"
          "Human Resources"  = "HR management systems"
        }
      }
      "Security & Compliance" = {
        "Identity & Access Management" = "Authentication and authorization"
      }
    }
  }
}

# Platform Engineering Team Resources
output "platform_engineering_groups" {
  description = "Platform Engineering service group IDs"
  value = {
    parent          = azapi_resource.platform_engineering.id
    infrastructure  = azapi_resource.platform_infrastructure.id
    devops          = azapi_resource.platform_devops.id
    data            = azapi_resource.platform_data.id
  }
}

# Application Team Resources
output "application_team_groups" {
  description = "Application Team service group IDs"
  value = {
    parent              = azapi_resource.application_teams.id
    customer_experience = azapi_resource.customer_experience.id
    ecommerce_platform  = azapi_resource.ecommerce_platform.id
    customer_support    = azapi_resource.customer_support.id
    internal_operations = azapi_resource.internal_operations.id
    finance_systems     = azapi_resource.finance_systems.id
    human_resources     = azapi_resource.human_resources.id
  }
}

# Security and Compliance Resources
output "security_compliance_groups" {
  description = "Security and Compliance service group IDs"
  value = {
    parent          = azapi_resource.security_compliance.id
    identity_access = azapi_resource.identity_access.id
  }
}

# Summary Information
output "deployment_summary" {
  description = "Summary of deployed service groups"
  value = {
    total_groups  = 13
    total_members = 2
    root_groups   = 3
    tenant_id     = local.tenant_id
    environment   = var.environment
    deployed_at   = timestamp()
  }
}
