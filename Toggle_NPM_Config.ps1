Write-Host 'Automatically detect proxy settings and Configure Git accordingly'
$username = git config user.name

$infyuserid = 'murugan_nagarajan'
$infypassword = 'tejashree%26123'
$proxy = 'indpunsbd6intpxy01.ad.infosys.com:80'

$httpproxy = 'http://' + $infyuserid + ':' + $infypassword + '@' + $proxy

if ($username -eq " ") {
    Write-Host 'Username is not configured yet'
    git config --global user.name "Murugan Nagarajan"
}
else {
    Write-Host 'Username is configured already'    
    git config --global user.name " "
}
Write-Host $username
Write-Host $httpproxy
Write-Host 'http://murugan_nagarajan:tejashree%26123@indpunsbd6intpxy01.ad.infosys.com:80'
Read-Host "Git Proxy Updated"