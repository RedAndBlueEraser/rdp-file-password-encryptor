[System.Text.UnicodeEncoding]$encoding = [System.Text.Encoding]::Unicode
[string]$password = "password"
[byte[]]$passwordAsBytes = $encoding.GetBytes($password)
[byte[]]$passwordEncryptedAsBytes = [Security.Cryptography.ProtectedData]::Protect($passwordAsBytes, $null, [Security.Cryptography.DataProtectionScope]::CurrentUser);
[string]$passwordEncryptedAsHex = ($passwordEncryptedAsBytes | ForEach-Object ToString X2) -join ""
Write-Host $passwordEncryptedAsHex
