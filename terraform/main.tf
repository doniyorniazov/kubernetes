terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.49.0 "
    }
  }
}

provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = "${var.appServiceName}-rg"
}

resource "azurerm_service_plan" "appServicePlan" {
  name                = "${var.prefix}-${var.appServiceName}-sp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "S1"
}


resource "azurerm_linux_web_app" "webApp" {
  name                = "${var.prefix}-${var.appServiceName}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.appServicePlan.id

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }

  site_config {
    application_stack {
      docker_image     = "niazovd/api"
      docker_image_tag = "v1"
    }
  }
}
resource "azurerm_linux_web_app_slot" "webaApp" {
  name            = "${var.prefix}-${var.appServiceName}-staging"
  app_service_id  = azurerm_linux_web_app.webApp.id
  service_plan_id = azurerm_service_plan.appServicePlan.id
  site_config {}
}

