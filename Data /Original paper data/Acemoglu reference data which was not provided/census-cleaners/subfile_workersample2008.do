*******************************************************************
* IPUMS Sample of Workers 2008
*******************************************************************

* David Dorn, version August 3, 2007
* Updated 03/2010 by M. Wasserman
* This subfile selects a sample of workers with the following
* characteristics: 
* - Age 16-64 last year
* - Only persons who were in the labor force last year
* - No unpaid familiy members


* The file can be called whenever the data in memory contains the
* variables age, classwkrd, and workedyr.
* NOTE: As opposed to the Census 1980-2000, the ACS 2005 does not 
* have a variable for group quarter type.


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
