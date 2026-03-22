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

# Call inherit configs
. .\configs.ps1

# Declare ruined variables. Ask for numbers and file name
    $Count = Read-Host "¿Cuantos codigos UPC de 13 digitos deseas generar?"
    $FileName = Read-Host "Nombre del archivo de salida (ejemplo: UPC-A.txt)"

# Ready to generate UPC-A
function Get-UPC($seq, $prefix) {

# Generate 5 random digit up to 12 (excluding the check digit) = 13
    $middle = $seq.ToString("D5")

# 12 digits base
    $base = $prefix + $middle

# Calculate check digit (13th)
    $sumaImpares = 0
    $sumaPares = 0
    for ($i=0; $i -lt 12; $i++) {
        $d = [int]::Parse($base.Substring($i,1))
        if ($i % 2 -eq 0) { $sumaImpares += $d } else { $sumaPares += $d }
    }
    $total = ($sumaImpares * 3) + $sumaPares
    $digito = (10 - ($total % 10)) % 10

    return $base + $digito
}

# Validate UPC-A Code
function Validate-UPC($upc) {
    if ($upc.Length -ne 13) { return $false }
    $base = $upc.Substring(0,12)
    $check = [int]::Parse($upc.Substring(12,1))

    $sumaImpares = 0
    $sumaPares = 0
    for ($i=0; $i -lt 12; $i++) {
        $d = [int]::Parse($base.Substring($i,1))
        if ($i % 2 -eq 0) { $sumaImpares += $d } else { $sumaPares += $d }
    }
    $total = ($sumaImpares * 3) + $sumaPares
    $digito = (10 - ($total % 10)) % 10

    return ($digito -eq $check)
}

"Generando $Count codigos UPC-A con prefijo $prefix y secuencia ordenada" | Out-File $FileName
$validCount = 0
$invalidCount = 0

for ($n=1; $n -le $Count; $n++) {
    $seq = $lastSeq + $n
    $upc = Get-UPC $seq $prefix
    $valid = Validate-UPC $upc
    if ($valid) {
        "Codigo valido ${n}: ${upc}" | Tee-Object -FilePath $FileName -Append
        $validCount++
    } else {
        "Codigo invalido ${n}: ${upc}" | Tee-Object -FilePath $FileName -Append
        $invalidCount++
    }
}

# Save the last # used for next exec.
    $newLastSeq = $lastSeq + $Count
    $config.lastSeq = $newlastSeq
    $config | ConvertTo-Json | Out-File $configFile -Force

"Resumen: $validCount válidos, $invalidCount inválidos" | Tee-Object -FilePath $FileName -Append
Write-Host "Resultados guardados en $FileName"
Write-Host "Último número guardado en ${newLastSeq}"

# Open the saved file
Start-Process notepad.exe $FileName
