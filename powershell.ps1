# Connect to Azure
Connect-AzAccount

# Variables
$resourceGroupName = "example-resources"
$location = "West Europe"
$storageAccountName = "examplestorageacct"
$skuName = "Standard_LRS"
$kind = "StorageV2"

# Create a resource group
New-AzResourceGroup -Name $resourceGroupName -Location $location

# Create a storage account
New-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName -Location $location -SkuName $skuName -Kind $kind -Tags @{ environment = "staging" }