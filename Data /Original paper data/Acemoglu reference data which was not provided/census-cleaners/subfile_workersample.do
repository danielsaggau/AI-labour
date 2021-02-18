*******************************************************************
* IPUMS Sample of Workers 1970/1980/1990/2000
*******************************************************************

* David Dorn, version August 3, 2007

* This subfile selects a sample of workers with the following
* characteristics: 
* - Age 16-64 last year
* - Only persons who were in the labor force last year
* - No unpaid familiy members
* - No residents of institutional group quarters.

* The file can be called whenever the data in memory contains the
* variables age, classwkd, workedyr, and gqtyped.


*******************************************************************
* Sample definition
*******************************************************************

* Keep if age 16-64 last year
drop if age<17 | age>65

* Drop unpaid family workers
drop if classwkrd==29

* Keep if in labor force last year
tab workedyr, miss
keep if workedyr==2

* Drop institutional group quarters 
drop if gqtyped>=100 & gqtyped<=499
