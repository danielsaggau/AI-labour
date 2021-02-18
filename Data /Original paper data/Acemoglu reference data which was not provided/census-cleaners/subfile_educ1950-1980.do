*******************************************************************
* IPUMS Education 1950-1980
*******************************************************************

* David Dorn, version October 10, 2007

* This subfile creates education dummy variables for IPUMS 1950-1980 data
* (Note: this file has previously been named "subfile_educ1980.do")

* The file can be called whenever the data in memory contains the
* variable higraded.


*******************************************************************
* Education
* Note: The underlying variable differs between 1980, and 1990/2000
* The groups are defined as follows:
* 1) Less than high school (lths) - up to 11th grade of high school 
* 2) High school (hsch) - 12th grade of high school, with or without
* graduation (in 1990/2000, this category includes GEDs which cannot 
* be identified separately)
* 3) Some college (scoll) - 1 to 3 years of college in 1980; some college
* with no degree or associate degree in 1990/2000
* 4) Bachelors degree (bach) - 4+ years of college in 1980, bachelors degree
* in 1990 
* 5) Masters degree (master) - 6+ years of college in 1980, 
* masters degree/professional degree/doctoral degree in 1990/2000
*******************************************************************

foreach v in lths hsch scoll coll bach master {
   gen edu_`v'=0 if (higraded>=010 & higraded<=230)
}

replace edu_lths=1 if (higraded>=010 & higraded<=142)
replace edu_hsch=1 if (higraded>=150 & higraded<=150)
replace edu_scoll=1 if (higraded>=151 & higraded<=182)
replace edu_coll=1 if (higraded>=190 & higraded<=230)
replace edu_bach=1 if (higraded>=190 & higraded<=200)
replace edu_master=1 if (higraded>=201 & higraded<=230)

assert edu_lths + edu_hsch + edu_scoll + edu_coll == 1 if (higraded>=010 & higraded<=230)
assert edu_bach + edu_master == edu_coll if (higraded>=010 & higraded<=230)
