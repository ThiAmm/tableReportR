# tableReportR

The aim of this project is to provide data manipulations for tables. 

Suppose for example you have the following table which lists the effect of a treatment on a disease by country, gender and eye color:

```
treatments <- tribble(~country ,~gender,~eye.color,~effectOfTreatment
        ,"Norway",  "male",   "green",     "cured"           
        ,"Norway",  "male",   "blue",     "notcured"         
        ,"Norway",  "female", "green",      "cured"            
        ,"Norway","female", "blue",      "notcured"         
        ,"Sweden",  "male",   "green",     "cured"            
        ,"Sweden",  "male",   "green",     "cured"            
        ,"Sweden",  "female", "blue",      "cured"            
        ,"Sweden",  "female", "blue",      "cured"            
)
treatments
# A tibble: 8 x 4
  country gender eye.color effectOfTreatment
  <chr>   <chr>  <chr>     <chr>            
1 Norway  male   green     cured            
2 Norway  male   blue      notcured         
3 Norway  female green     cured            
4 Norway  female blue      notcured         
5 Sweden  male   green     cured            
6 Sweden  male   green     cured            
7 Sweden  female blue      cured            
8 Sweden  female blue      cured            
```
Then, one can see that all people in Sweden got cured by the treatment. Also, all norwegians with green eye color are cured and with blue eye color are not cured independently of the gender. 

In a report, the whole table might look a bit lengthy. 
By using the function call 
```
reduceData(treatments,keyColumnNames = c("country","gender","eye.color"),stringWhichReplacesData = '')
```

one gets the following table, which stil contains all the informations the table was meant to highlight:

```
# A tibble: 3 x 3
  country eye.color effectOfTreatment
  <chr>   <chr>     <chr>            
1 Norway  green     cured            
2 Norway  blue      notcured         
3 Sweden  ""        cured            
```

