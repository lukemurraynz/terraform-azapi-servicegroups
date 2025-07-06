# Azure Service Groups - Variables Configuration

variable "tenant_id" {
  description = "Azure tenant ID (used as root service group)"
  type        = string
  default     = "2463cfda-1c0b-43f5-b6e5-1c370752bb93"
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "production"
}

variable "organization_name" {
  description = "Organization name for service group naming"
  type        = string
  default     = "contoso"
}

variable "cost_center" {
  description = "Cost center for resource tagging"
  type        = string
  default     = "IT-Operations"
}

variable "enable_extended_hierarchy" {
  description = "Enable extended service group hierarchy with additional nested groups"
  type        = bool
  default     = true
}

variable "platform_teams" {
  description = "Configuration for platform engineering teams"
  type = object({
    infrastructure = object({
      enabled     = bool
      displayName = string
    })
    devops = object({
      enabled     = bool
      displayName = string
    })
    data = object({
      enabled     = bool
      displayName = string
    })
  })
  default = {
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
}

variable "application_teams" {
  description = "Configuration for application teams"
  type = object({
    customer_experience = object({
      enabled     = bool
      displayName = string
    })
    internal_operations = object({
      enabled     = bool
      displayName = string
    })
  })
  default = {
    customer_experience = {
      enabled     = true
      displayName = "Customer Experience"
    }
    internal_operations = {
      enabled     = true
      displayName = "Internal Operations"
    }
  }
}

variable "security_compliance" {
  description = "Configuration for security and compliance teams"
  type = object({
    enabled     = bool
    displayName = string
  })
  default = {
    enabled     = true
    displayName = "Security & Compliance"
  }
}

variable "common_tags" {
  description = "Common tags to apply to all service groups"
  type        = map(string)
  default = {
    managed_by    = "platform-engineering"
    deployed_with = "terraform"
    iac_source    = "azure-service-groups"
  }
}
