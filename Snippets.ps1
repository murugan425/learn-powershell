#Enum Example

Enum Category
{
    Eligibility = 1
    Day_Time = 2
    Seasonality = 3
    Flight_Appl = 4
    Adv_Res_Tkt = 5
    Min_Stay = 6
    Max_Stay = 7
};
Write-Host ([Category]7).ToString()