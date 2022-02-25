$Password = -join ((33..126) | Get-Random -Count 15 | ForEach-Object { [char]$_ })
$str = ""
 $ListOfUsers = Get-Content C:\Users\user\files.txt
 foreach ($user in $ListOfUsers) {
     #Generate a 12-character random password
     $Password = -join ((33..126) | Get-Random -Count 15 | ForEach-Object { [char]$_ })
     #Convert the password to secure string
     $Pass = ConvertTo-SecureString $Password -AsPlainText -Force
     #Reset the account password
     Set-ADAccountPassword $user -NewPassword $Pass -Reset
     #Force user to change password at next logon
     Set-ADUser -Identity $user -passwordNeverExpires $true -CannotChangePassword $true
     #Display userid and password values 
     Write-Host $user, $Password
     $str += $user, "`t", $Password, "`r`n" 
        
 }

 $str | Out-File -filepath C:\Users\user\files.csv
