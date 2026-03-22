# Copyright (C) 2026 qaotyk_dev
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This is a simple example of PowerShell to generate a list of UPC-A 
# that are validated with GS1 keys, company prefix, and item category.
#
# Rapid initial development in PowerShell for easy use and access without 
# installing any additional programs. The project can be evolved into a more
# functional script, but for now, it's a basic example of PowerShell usage.
#

# Set config.json for more customization script
    $ConfigFile = "configs/upc_config.json"

# If doesn't exist, get attributes
if (-not (Test-Path $configFile)) {
    $digits = Read-Host "Ingresa los 4 digitos que seguiran despues de 750"
    $prefix = "750" + $digits

    $config = @{
        prefix = $prefix
        lastSeq = 0
}
    $config | ConvertTo-Json | Out-File $configFile -Force
    Write-Host "Archivo de configuracion creado con prefijo $prefix"
} else {
    $config = Get-Content $configFile | ConvertFrom-Json
    $prefix = $config.prefix
    $lastSeq = $config.lastSeq
    Write-Host "Usando prefijo guardado: $prefix"
    Write-Host "Ultima secuencia registrada: $lastSeq"
}

