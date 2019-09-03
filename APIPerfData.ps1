# This function will be able to generate the test data required to 
# do performance testing using Jmeter for Record3 API.

Write-Host "*************************"
$catlist = @(
    [pscustomobject]@{catnum=1;catparam='eligibity1';catname='Eligibility'}
    [pscustomobject]@{catnum=2;catparam='daytime2';catname='Day/Time'}
    [pscustomobject]@{catnum=3;catparam='seasonality3';catname='Seasonality'}
    [pscustomobject]@{catnum=4;catparam='flightapp4';catname='Flight Appl'}
    [pscustomobject]@{catnum=5;catparam='advrsvtkt5';catname='Adv Res Tkt'}
    [pscustomobject]@{catnum=6;catparam='minstay6';catname='Min Stay'}
    [pscustomobject]@{catnum=7;catparam='maxstay7';catname='Max Stay'}
);

# List all the categories to the user for which performance data can be generated.
for ( $index = 0; $index -lt $catlist.count; $index++ ) {
    Write-Host $catlist[$index].catnum". " -ForeGroundColor Yellow -NoNewLine; Write-Host $catlist[$index].catname -ForeGroundColor Green
}
Write-Host "*************************"
# Get the category number from user as input.
Write-Host "Enter the Category Number for which performance data needs to be generated?";
$selectedcatnum = Read-Host -Prompt 'Category Number'

# Hard code the category number if required, for development purpose
# $selectedcatnum = 5

# Filter the selected category and pass it as input argument for the data generator tool.
$selectedcat = $catlist | Where-Object {$_.catnum -eq $selectedcatnum}
Write-Host $selectedcat.catparam

$currentTime = Get-Date
Write-Host "Triggering the Performance data tool generator for" $selectedcat.catname "category @" $currentTime;

