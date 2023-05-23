* Opening a log
cap log close
log using p_code.log, replace

* Clear memory
clear all

* Change directories
cd "\\citrix-ps2.ads.utm.utoronto.ca\StudData$\abbasium\Documents\ECO344H5"

* Read occupation data
use "cps_00004"
// Data on Year (2010-2022), age, educ, diffany, wkswork1, wksunem1, incwage,
// caidly

* Dropping NIU or Missing data
drop if incwage>=99999998 // NIU or Missing
drop if educ<002 | educ>=999 // NIU or Missing
drop if diffany==0 // NIU
drop if caidly==9 // NIU
drop if wksunem1 == 99 // NIU

* Statistical summaries
sum wkswork1 if age > 21 & age < 62 & caidly == 1 // Not on Medicaid LY
sum wkswork1 if age > 21 & age < 62 & caidly == 2 // On Medicaid LY
// Results: On Medicaid, reduced the number of weeks worked (~5)

sum wksunem1 if age > 21 & age < 62 & caidly == 1 // Not on Medicaid LY
sum wksunem1 if age > 21 & age < 62 & caidly == 2 // On Medicaid LY
// Results: On Medicaid, increased the number of weeks unemployed (~3)

sum incwage if age > 21 & age < 62 & caidly == 1 // Not on Medicaid LY
sum incwage if age > 21 & age < 62 & caidly == 2 // On Medicaid LY
// Results: On Medicaid, decreased income (~13896.89)

* Being on Medicaid is associated with ________ increase/decrease in the number
* of weeks worked controlling for education and restricting the data to an age 
* group to 22-61 year olds (excl. those who can be claimed as dependents and 
* individuals who can access other forms of aid)
reg wkswork1 educ caidly if age > 21 & age < 62 & diffany == 1, r
// Medicaid premium is associated with around 4.5 weeks decrease in weeks worked, 
// holding other factors constant.

* Closing a log
cap log close
