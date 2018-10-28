# RDP File Password Encryptor

A PowerShell script to encrypt plain text passwords into byte streams that can be embedded into RDP files for auto logon.

## Synopsis

This script encrypts plain text passwords into byte streams represented as hexadecimal strings. The string can be embedded as the setting "password 51:b" in Remote Desktop Connection (Remote Desktop Protocol (RDP)) files to automatically logon using the password.

If you want to open a RDP file and automatically logon the remote computer without being prompted to enter user credentials, you can embed the user credentials (both the user name and password) into the RDP file. However, in order to do so, you must embed the password in its encrypted form. This script helps provide you the encrypted password which you can copy into the RDP file.

The reason behind developing this script was because certain work environments disallow saving or does not properly save remote computers' user credentials on the local computer, which created annoyances when having to frequently remote into many remote computers.

## Usage

Open PowerShell, run the PowerShell script file rdp-file-password-encryptor.ps1 with the remote computer's password as the argument:

```PowerShell
> .\rdp-file-password-encryptor.ps1 mysecret
```

This returns a hexadecimal string representing the encrypted password. The hexadecimal string can be embedded as the setting "password 51:b" in a RDP file:

```
full address:s:192.168.0.150
username:s:John
password 51:b:**YOUR HEXADECIMAL STRING HERE**
```

The hexadecimal string is fairly long and it maybe broken up into multiple lines in the PowerShell console. Remember to join it back as one line when copying it into the RDP file.

When embedded together with a user name in the RDP file, opening the RDP file can automatically logon without prompting to enter user credentials.

## Notes

- When PowerShell returns the hexadecimal string (usually more than 400 characters long), it is likely to be too long to be displayed on one line in the PowerShell console. When copying the string from the console, remember to join the lines back as one line.
- The hexadecimal string, as its name suggests, only consists of characters 0-9 and A-F.
- Encrypting and embedding the password in the RDP file is **per user account only**! RDP can only use the password credential on the user account where the encrypted password was generated from. That is, if you encrypt and embed a password into a RDP file when you are logged in as user A on the local computer, opening the RDP file will only automatically logon the remote computer when you are logged in as user A on the local computer. If you open the same RDP file when you are logged in as user B on the local or another computer, it will not automatically logon the remote computer and will prompt you to enter a password. This is the result of RDP's security design. As a result, this is not a good way of distributing RDP files nor is it replacement for memorising passwords.

## Author

Harry Wong (RedAndBlueEraser) RedAndBlueEraser@outlook.com
