# Define parameters
param(
    [string]$ResourceGroupName,
    [string]$StorageAccountName,
    [string]$Location = "West Europe",
    [string]$Sku = "Standard_LRS"
)

# Validate SKU
$validSkus = @("Standard_LRS", "Standard_GRS", "Standard_RAGRS", "Standard_ZRS", "Premium_LRS", "Premium_ZRS")
if (-not $validSkus -contains $Sku) {
    Write-Error "The SKU must be one of $($validSkus -join ', ')."
    exit
}

# Login to Azure
Write-Host "Logging in to Azure..."
Connect-AzAccount

# Create resource group if it doesn't exist
if (-not (Get-AzResourceGroup -Name $ResourceGroupName -ErrorAction SilentlyContinue)) {
    Write-Host "Creating resource group '$ResourceGroupName' in location '$Location'..."
    New-AzResourceGroup -Name $ResourceGroupName -Location $Location
}

# Determine account tier based on SKU
$AccountTier = if ($Sku -match "Premium") { "Premium" } else { "Standard" }

# Create storage account
Write-Host "Creating storage account '$StorageAccountName' in resource group '$ResourceGroupName'..."
New-AzStorageAccount -ResourceGroupName $ResourceGroupName `
                     -Name $StorageAccountName `
                     -Location $Location `
                     -SkuName $Sku `
                     -Kind StorageV2 `
                     -AccessTier $AccountTier

Write-Host "Storage account '$StorageAccountName' created successfully."