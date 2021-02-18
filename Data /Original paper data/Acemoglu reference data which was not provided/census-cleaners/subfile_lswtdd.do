*******************************************************************
* IPUMS Labor Supply Weights
*******************************************************************

* David Dorn, May 16, 2007
* November 19, 2008: Updated file to run with occ1990dd variable

* This subfile creates labor supply weights. The labor supply weight
* is imputed whenever hours or weeks data is missing.

* This file should be run after the subfile that creates education 
* dummies.
* The file can be called whenever the data in memory contains the
* education dummies created by subfile_educYYYY.do, 
* and the variables perwt, uhrswork, wkswork.


********************************************************************
* Labor supply weights (Based on code from David Autor)
********************************************************************

** Labor supply weight - calculate where possible, impute by occupation 
** for those with missing hours or weeks 
gen lswt=perwt*(uhrswork/35)*(wkswork1/50)
replace lswt=. if lswt==0
summ lswt perwt
count if lswt==.

gen edcat= 1*edu_lths + 2*edu_hsch + 3*edu_scoll + 4*edu_coll
assert edcat!=. & edcat>=1 & edcat<=4
egen mnwt=sum(lswt),by(occ1990dd edcat)
egen temp=sum(perwt*(lswt!=.)),by(occ1990dd edcat)
replace mnwt=mnwt/temp
summ mnwt
count if mnwt==.

gen byte impute=lswt==.
replace lswt=perwt*mnwt if lswt==.
tab impute, summ(lswt)

* One more level of imputation if needed
count if lswt==.
drop temp mnwt
egen mnwt=sum(lswt),by(edcat)
egen temp=sum(perwt*(lswt!=.)),by(edcat)
replace mnwt=mnwt/temp
assert mnwt!=.
replace lswt=perwt*mnwt if lswt==.
tab impute, summ(lswt)
drop mnwt temp
