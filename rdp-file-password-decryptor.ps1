<#
rdp-file-password-decryptor.ps1
Version 20201229
Written by Harry Wong (RedAndBlueEraser)
#>

<#
.SYNOPSIS
A PowerShell script to decrypt password byte streams embedded in RDP files into plain text passwords.
.DESCRIPTION
This script decrypts password byte streams represented as hexadecimal strings into plain text passwords. The password byte stream are embedded as the setting "password 51:b" in RDP files.
.PARAMETER PasswordEncryptedAsHex
The password byte stream as a hexadecimal string to be decrypted.
#>

Param(
    [Parameter(Mandatory=$true)]
    [string]$PasswordEncryptedAsHex
)

Add-Type -AssemblyName System.Security

[System.Text.UnicodeEncoding]$encoding = [System.Text.Encoding]::Unicode
[int]$passwordEncryptedAsBytesLength = $PasswordEncryptedAsHex.Length / 2
[byte[]]$passwordEncryptedAsBytes = New-Object -TypeName byte[] -ArgumentList $passwordEncryptedAsBytesLength
for ($i = 0; $i -lt $passwordEncryptedAsBytesLength; $i++) {
    $passwordEncryptedAsBytes[$i] = [Convert]::ToByte($PasswordEncryptedAsHex.Substring($i * 2, 2), 16)
}
[byte[]]$passwordAsBytes = [System.Security.Cryptography.ProtectedData]::Unprotect($passwordEncryptedAsBytes, $null, [System.Security.Cryptography.DataProtectionScope]::CurrentUser)
[string]$password = $encoding.GetString($passwordAsBytes)
return $password
