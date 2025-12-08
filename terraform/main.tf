variable "prefix" {
  default = "capstone"
  type    = string
}
resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg"
  location = "centralindia"
}

resource "azurerm_service_plan" "appserviceplan" {
  name                = "${var.prefix}-appserviceplan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "S1"
}

#   FRONTEND PROD (.NET)
resource "azurerm_linux_web_app" "webapp" {
  name                = "${var.prefix}-webapp1603"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.appserviceplan.id

  app_settings = {
    "ENV_NAME" = "Production"
  }

  site_config {
    application_stack {
      dotnet_version = "8.0"   
    }
  }
}


#   FRONTEND STAGING SLOT (.NET)
resource "azurerm_linux_web_app_slot" "frontend_slot" {
  name           = "staging"
  app_service_id = azurerm_linux_web_app.webapp.id

  app_settings = {
    "ENV_NAME" = "Staging"
  }

  site_config {
    application_stack {
      dotnet_version = "8.0"
    }
  }
}
