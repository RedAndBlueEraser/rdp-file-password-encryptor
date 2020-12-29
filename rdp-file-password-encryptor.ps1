<#
rdp-file-password-encryptor.ps1
Version 20201229
Written by Harry Wong (RedAndBlueEraser)
#>

<#
.SYNOPSIS
A PowerShell script to encrypt plain text passwords into byte streams that can be embedded into RDP files for auto logon.
.DESCRIPTION
This script encrypts plain text passwords into byte streams represented as hexadecimal strings. The string can be embedded as the setting "password 51:b" in RDP files to automatically logon using the password.
.PARAMETER Password
The plain text password to be encrypted.
.EXAMPLE
./rdp-file-password-encryptor.ps1 mysecret
Get the byte stream (as a hexadecimal string) of the encrypted password "mysecret".
#>

Param(
    [Parameter(Mandatory=$true)]
    [string]$Password
)

Add-Type -AssemblyName System.Security

[System.Text.UnicodeEncoding]$encoding = [System.Text.Encoding]::Unicode
[byte[]]$passwordAsBytes = $encoding.GetBytes($Password)
[byte[]]$passwordEncryptedAsBytes = [System.Security.Cryptography.ProtectedData]::Protect($passwordAsBytes, $null, [System.Security.Cryptography.DataProtectionScope]::CurrentUser)
[string]$passwordEncryptedAsHex = -join ($passwordEncryptedAsBytes | ForEach-Object { $_.ToString("X2") })
return $passwordEncryptedAsHex
