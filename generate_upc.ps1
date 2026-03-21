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

# Declare ruined variables
param(
    [int]$Count = 10,
    [string]$FileName = "upc.txt"
)

function Get-UPC {
    # Prefix 7 digits
    $prefix = "7503742"

    # Generate 5 random digit up to 12 (excluding the check digit) = 13
    $missed = 12 - $prefix.Length
    $base = $prefix + (-join (1..$missed | ForEach-Object { Get-Random -Minimum 0 -Maximum 10 }))

    # Calculate check digit (13th)
    $sumaImpares = 0
    $sumaPares = 0
    for ($i=0; $i -lt 12; $i++) {
        $d = [int]$base[$i]
        if ($i % 2 -eq 0) { $sumaImpares += $d } else { $sumaPares += $d }
    }
    $total = ($sumaImpares * 3) + $sumaPares
    $digito = (10 - ($total % 10)) % 10

    return $base + $digito
}

"Generando $Count codigos UPC-A con prefijo 7503742..." | Out-File $FileName
for ($n=1; $n -le $Count; $n++) {
    $upc = Get-UPC
    "UPC generado ${n}: ${upc}" | Tee-Object -FilePath $FileName -Append
}
Write-Host "Resultados guardados en $FileName"