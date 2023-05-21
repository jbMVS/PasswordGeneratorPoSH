Function Get-RandomPassword
{
    #default parameter if one isn't given
    param([int]$PasswordLength = 10)
 
    #ASCII Character set for Password
    $CharacterSet = @{
        Lowercase   = (97..122) | Get-Random -Count 10 | % {[char]$_}
        Uppercase   = (65..90)  | Get-Random -Count 10 | % {[char]$_}
        Numeric     = (48..57)  | Get-Random -Count 10 | % {[char]$_}
        SpecialChar = (33..47)+(58..64)+(91..96)+(123..126) | Get-Random -Count 10 | % {[char]$_}
    }
    
    #Frame Random Password from given character set
    $StringSet = $CharacterSet.Uppercase + $CharacterSet.Lowercase + $CharacterSet.Numeric + $CharacterSet.SpecialChar
 
    -join(Get-Random -Count $PasswordLength -InputObject $StringSet)
}

$PWDone = $false

$HasLower = $false
$HasUpper = $false
$HasNumeric = $false
$HasSpecial = $false

While($PWDone -eq $false){

    #Call the function to generate random password of 12 characters
    $StoredPW = Get-RandomPassword -PasswordLength 12
    #Write-Host $StoredPW

    foreach($Char in $StoredPW){
        if($Char -cmatch "[a-z]"){
            #Write-Host "Has Lower"
            $HasLower = $true
        }
        if($Char -cmatch "[A-Z]"){
            #Write-Host "Has Upper"
            $HasUpper = $true
        }
        if($Char -cmatch "[0-9]"){
            #Write-Host "Has Numeric"
            $HasNumeric = $true
        }
        if($Char -match '[~#%&*{}\\:<>?!@$^()-_=/|+"]'){
            #Write-Host "Has SpecialChar"
            $HasSpecial = $true
        }
    }

    if(($HasLower -eq $true) -and ($HasUpper -eq $true) -and ($HasNumeric -eq $true) -and ($HasSpecial -eq $true)){
        $PWDone = $true
        #Write-Host "Password complete"
    }
}

$StoredPW = $StoredPW -join ""
$StoredPW | Set-Clipboard

Write-Host ($StoredPW + " copied to clipboard")

pause