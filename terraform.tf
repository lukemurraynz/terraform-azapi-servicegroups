# Azure Service Groups configuration following Platform Engineering best practices
# This configuration demonstrates a typical enterprise structure with:
# - Platform Engineering teams managing infrastructure and shared services
# - Application teams organized by business domains
# - Clear separation of concerns and hierarchical governance

terraform {
  required_providers {
    azapi = {
      source  = "Azure/azapi"
      version = "~> 2.4.0"
    }
  }
  required_version = ">= 1.3.0"
}

provider "azapi" {
  # Configuration will be inherited from Azure CLI or environment variables
}

# Local variables for configuration
locals {
  # Tenant ID - used as the root service group ID (automatically created by Azure)
  tenant_id = var.tenant_id
  
  # Common tags for all service groups
  common_tags = merge(var.common_tags, {
    environment = var.environment
    cost_center = var.cost_center
  })
}

# Platform Engineering - Top-level service group for platform teams
resource "azapi_resource" "platform_engineering" {
  type      = "Microsoft.Management/serviceGroups@2024-02-01-preview"
  name      = "platform-engineering"
  parent_id = "/"

  body = {
    properties = {
      displayName = "Platform Engineering"
      parent = {
        resourceId = "/providers/Microsoft.Management/serviceGroups/${local.tenant_id}"
      }
    }
  }
}

# Platform Infrastructure - Core infrastructure services
resource "azapi_resource" "platform_infrastructure" {
  type      = "Microsoft.Management/serviceGroups@2024-02-01-preview"
  name      = "platform-infrastructure"
  parent_id = "/"

  body = {
    properties = {
      displayName = "Platform Infrastructure"
      parent = {
        resourceId = azapi_resource.platform_engineering.id
      }
    }
  }
}

# Platform DevOps - CI/CD, deployment automation, and developer tooling
resource "azapi_resource" "platform_devops" {
  type      = "Microsoft.Management/serviceGroups@2024-02-01-preview"
  name      = "platform-devops"
  parent_id = "/"

  body = {
    properties = {
      displayName = "Platform DevOps"
      parent = {
        resourceId = azapi_resource.platform_engineering.id
      }
    }
  }
}

# Platform Data - Data platform and analytics services
resource "azapi_resource" "platform_data" {
  type      = "Microsoft.Management/serviceGroups@2024-02-01-preview"
  name      = "platform-data"
  parent_id = "/"

  body = {
    properties = {
      displayName = "Platform Data"
      parent = {
        resourceId = azapi_resource.platform_engineering.id
      }
    }
  }
}

# Application Teams - Top-level service group for application teams
resource "azapi_resource" "application_teams" {
  type      = "Microsoft.Management/serviceGroups@2024-02-01-preview"
  name      = "application-teams"
  parent_id = "/"

  body = {
    properties = {
      displayName = "Application Teams"
      parent = {
        resourceId = "/providers/Microsoft.Management/serviceGroups/${local.tenant_id}"
      }
    }
  }
}

# Customer Experience - Customer-facing applications
resource "azapi_resource" "customer_experience" {
  type      = "Microsoft.Management/serviceGroups@2024-02-01-preview"
  name      = "customer-experience"
  parent_id = "/"

  body = {
    properties = {
      displayName = "Customer Experience"
      parent = {
        resourceId = azapi_resource.application_teams.id
      }
    }
  }
}

# E-commerce Platform - E-commerce specific applications
resource "azapi_resource" "ecommerce_platform" {
  type      = "Microsoft.Management/serviceGroups@2024-02-01-preview"
  name      = "ecommerce-platform"
  parent_id = "/"

  body = {
    properties = {
      displayName = "E-commerce Platform"
      parent = {
        resourceId = azapi_resource.customer_experience.id
      }
    }
  }
}

# Customer Support - Customer support applications
resource "azapi_resource" "customer_support" {
  type      = "Microsoft.Management/serviceGroups@2024-02-01-preview"
  name      = "customer-support"
  parent_id = "/"

  body = {
    properties = {
      displayName = "Customer Support"
      parent = {
        resourceId = azapi_resource.customer_experience.id
      }
    }
  }
}

# Internal Operations - Internal business applications
resource "azapi_resource" "internal_operations" {
  type      = "Microsoft.Management/serviceGroups@2024-02-01-preview"
  name      = "internal-operations"
  parent_id = "/"

  body = {
    properties = {
      displayName = "Internal Operations"
      parent = {
        resourceId = azapi_resource.application_teams.id
      }
    }
  }
}

# Finance Systems - Financial applications
resource "azapi_resource" "finance_systems" {
  type      = "Microsoft.Management/serviceGroups@2024-02-01-preview"
  name      = "finance-systems"
  parent_id = "/"

  body = {
    properties = {
      displayName = "Finance Systems"
      parent = {
        resourceId = azapi_resource.internal_operations.id
      }
    }
  }
}

# Human Resources - HR applications
resource "azapi_resource" "human_resources" {
  type      = "Microsoft.Management/serviceGroups@2024-02-01-preview"
  name      = "human-resources"
  parent_id = "/"

  body = {
    properties = {
      displayName = "Human Resources"
      parent = {
        resourceId = azapi_resource.internal_operations.id
      }
    }
  }
}

# Security and Compliance - Cross-cutting security services
resource "azapi_resource" "security_compliance" {
  type      = "Microsoft.Management/serviceGroups@2024-02-01-preview"
  name      = "security-compliance"
  parent_id = "/"

  body = {
    properties = {
      displayName = "Security & Compliance"
      parent = {
        resourceId = "/providers/Microsoft.Management/serviceGroups/${local.tenant_id}"
      }
    }
  }
}

# Identity and Access Management
resource "azapi_resource" "identity_access" {
  type      = "Microsoft.Management/serviceGroups@2024-02-01-preview"
  name      = "identity-access"
  parent_id = "/"

  body = {
    properties = {
      displayName = "Identity & Access Management"
      parent = {
        resourceId = azapi_resource.security_compliance.id
      }
    }
  }
}

# Service Group Member - Storage Account for Security & Compliance
resource "azapi_resource" "storage_account_member" {
  type      = "Microsoft.Relationships/serviceGroupMember@2023-09-01-preview"
  name      = "storage-security-member"
  parent_id = "/subscriptions/11b74992-d520-46e1-a9e9-b55c57d2e890/resourceGroups/openai/providers/Microsoft.Storage/storageAccounts/stgaccountlk"

  # Disable schema validation for this preview resource
  schema_validation_enabled = false

  body = {
    properties = {
      targetId = azapi_resource.security_compliance.id
    }
  }

  depends_on = [
    azapi_resource.security_compliance
  ]
}

# Service Group Member - Resource Group for E-commerce Platform
resource "azapi_resource" "resourcegroup_ecommerce_member" {
  type      = "Microsoft.Relationships/serviceGroupMember@2023-09-01-preview"
  name      = "openai-rg-ecommerce-member"
  parent_id = "/subscriptions/11b74992-d520-46e1-a9e9-b55c57d2e890/resourceGroups/openai"

  # Disable schema validation for this preview resource
  schema_validation_enabled = false

  body = {
    properties = {
      targetId = azapi_resource.ecommerce_platform.id
    }
  }

  depends_on = [
    azapi_resource.ecommerce_platform
  ]
}