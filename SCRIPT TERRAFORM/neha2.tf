provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "myresourcegroup" {
  name     = "Rgroup1"
  location = "West Europe"
}

resource "azurerm_service_plan" "myappserviceplan" {
  name                = "web-service"
  location            = azurerm_resource_group.myresourcegroup.location
  resource_group_name = azurerm_resource_group.myresourcegroup.name
  sku_name            = "S1"
  os_type             = "Windows"
}

resource "azurerm_app_service" "mywebapp" {
  name                = "web-app1"
  location            = azurerm_resource_group.myresourcegroup.location
  resource_group_name = azurerm_resource_group.myresourcegroup.name
  app_service_plan_id = azurerm_service_plan.myappserviceplan.id

  site_config {
    always_on = true
  }

  app_settings = {
    "WEBSITE_NODE_DEFAULT_VERSION" = "12.16.0"
  }
}
