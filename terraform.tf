# Define the provider
provider "azurerm" {
  features {}
}

# Define variables
variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
}

variable "location" {
  description = "Location for the storage account"
  type        = string
  default     = "West Europe"
}

variable "sku" {
  description = "The SKU of the storage account"
  type        = string
  default     = "Standard_LRS"
  validation {
    condition     = contains(["Standard_LRS", "Standard_GRS", "Standard_RAGRS", "Standard_ZRS", "Premium_LRS", "Premium_ZRS"], var.sku)
    error_message = "The SKU must be one of Standard_LRS, Standard_GRS, Standard_RAGRS, Standard_ZRS, Premium_LRS, Premium_ZRS."
  }
}

# Create the storage account resource
resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = var.sku == "Premium_LRS" || var.sku == "Premium_ZRS" ? "Premium" : "Standard"
  account_replication_type = var.sku
}

# Create a resource group (if not already existing)
resource "azurerm_resource_group" "rg" {
  name     = "example-resources"
  location = var.location
}

# Output the storage account name
output "storage_account_name" {
  value = azurerm_storage_account.storage_account.name
}