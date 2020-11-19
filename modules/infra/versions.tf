terraform {
  required_version = ">= 0.12"
  required_providers {
    azurerm    = ">= 2.10.0"
    helm       = "= 1.1.1"
    kubernetes = ">= 1.11.1"
  }
}
