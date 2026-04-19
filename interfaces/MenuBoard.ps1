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

# Menu board | Forms characteristics
Add-Type -AssemblyName System.Windows.Forms

$MenuBoard = New-Object System.Windows.Forms.Form
$MenuBoard.Text = "Generate Sample UPC Codes | qaotyk_dev"
$MenuBoard.Size = New-Object System.Drawing.Size(500, 500)

# Menu Board | Display elements
$Generate = New-Object System.Windows.Forms.Button
$Generate.Text = "Generate UPC Codes"
$Generate.Size = New-Object System.Drawing.Size(150, 50)
$Generate.Location = New-Object System.Drawing.Point(50, 50)
$Generate.Add_Click({ [System.Windows.Forms.MessageBox]::Show("Generating UPC codes...") })

$MenuBoard.Controls.Add($Generate)

[System.Windows.Forms.Application]::Run($MenuBoard)
[void]$MenuBoard.ShowDialog()