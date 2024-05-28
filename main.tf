terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.101.0"
    }
  }
}

provider "azurerm" {
  features{}
}
#variable "newgroup" {
# type = list
#  default = ["testgroup", "demogroup", "dummygroup" ]
#} 
resource "azurerm_resource_group" "Mygroup" {
  for_each = toset(["testgroup", "demogroup", "dummygroup"])
  name      = each.value
  #name     = var.newgroup[count.index]
  location = "West Europe"
  #count    = 3
}

resource "azurerm_storage_account" "varshastorage" {
  for_each  = {
    testgroup = "eastus2"
    demogroup  = "westus"
    dummygroup = "centralus"
  }
  name                     = "storage${each.key}"
  resource_group_name      = azurerm_resource_group.Mygroup[each.key].name
  location                 = each.value
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

