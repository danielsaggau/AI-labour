*******************************************************************
* IPUMS Occupation Groups
*******************************************************************

* David Dorn, version November 11, 2007
* Updated March 11, 2009: Adjusted for occ1990dd variable

* The file can be called whenever the data in memory contains the
* variable occ1990dd.


********************************************************************
* Occupation Dummies
********************************************************************

* CENSUS Occupations - First level of differentiation (6 categories) *

gen occ_managprof=0       /* managerial and professional specialty occs */
replace occ_managprof=1 if (occ1990dd>=4 & occ1990dd<=200)

gen occ_techsalad=0  /* technicians, sales, and administrative support occs */
replace occ_techsalad=1 if (occ1990dd>=203 & occ1990dd<=389)

gen occ_service=0         /* service occs */
replace occ_service=1 if (occ1990dd>=405 & occ1990dd<=472)

gen occ_farm=0            /* farming, forestry, and fishing occs */
replace occ_farm=1 if (occ1990dd>=473 & occ1990dd<=498)

gen occ_product=0      /* precision production, craft and repair occs */
replace occ_product=1 if (occ1990dd>=503 & occ1990dd<=699)

gen occ_operator=0        /* operators, fabricators, and laborers */
replace occ_operator=1 if (occ1990dd>=703 & occ1990dd<=889)


* CENSUS Occupations - Second level of differentiation *

gen occ2_exec=0          /* executive, administrative and managerial occs */
replace occ2_exec=1 if (occ1990dd>=3 & occ1990dd<=22)

gen occ2_mgmtrel=0       /* management related occs */
replace occ2_mgmtrel=1 if (occ1990dd>=23 & occ1990dd<=37)

gen occ2_prof=0          /* professional specialty occs */
replace occ2_prof=1 if (occ1990dd>=43 & occ1990dd<=200)

gen occ2_tech=0          /* technicians and related support occs */
replace occ2_tech=1 if (occ1990dd>=203 & occ1990dd<=235)

gen occ2_sales=0         /* sales occs */
replace occ2_sales=1 if (occ1990dd>=243 & occ1990dd<=283)

gen occ2_cleric=0        /* administrative support occs */
replace occ2_cleric=1 if (occ1990dd>=303 & occ1990dd<=389)

gen occ2_clean=0          /* housekeeping and related occs */
replace occ2_clean=1 if (occ1990dd>=405 & occ1990dd<=408)

gen occ2_protect=0        /* protective service occs */
replace occ2_protect=1 if (occ1990dd>=415 & occ1990dd<=427)

gen occ2_otherserv=0      /* other service occs */
replace occ2_otherserv=1 if (occ1990dd>=433 & occ1990dd<=472)

gen occ2_farmer=0        /* farm operators and managers */
replace occ2_farmer=1 if (occ1990dd>=473 & occ1990dd<=475)

gen occ2_otheragr=0           /* other agricultural and related occs */
replace occ2_otheragr=1 if (occ1990dd>=479 & occ1990dd<=498)

gen occ2_mechanic=0      /* mechanics and repairers */
replace occ2_mechanic=1 if (occ1990dd>=503 & occ1990dd<=549)

gen occ2_constr=0         /* construction trades */
replace occ2_constr=1 if (occ1990dd>=558 & occ1990dd<=599)

gen occ2_mining=0         /* extractive occs */
replace occ2_mining=1 if (occ1990dd>=614 & occ1990dd<=617)

gen occ2_product=0         /* precision production occs */
replace occ2_product=1 if (occ1990dd>=628 & occ1990dd<=699)

gen occ2_operator=0        /* machine operators, assemblers, and inspectors */
replace occ2_operator=1 if (occ1990dd>=703 & occ1990dd<=799)

gen occ2_transp=0        /* transportation and material moving occs */
replace occ2_transp=1 if (occ1990dd>=803 & occ1990dd<=889)

assert occ2_exec + occ2_mgmtrel + occ2_prof == occ_managprof
assert occ2_tech + occ2_sales + occ2_cleric == occ_techsalad
assert occ2_clean + occ2_protect + occ2_otherserv == occ_service
assert occ2_farmer + occ2_otheragr == occ_farm
assert occ2_mechanic + occ2_constr + occ2_mining + occ2_product == occ_product
assert occ2_operator + occ2_transp == occ_operator


* CENSUS Occupations - Third level of differentiation (Service Occs) *

gen occ3_clean=0            /* housekeeping, cleaning, laundry */
replace occ3_clean=1 if     (occ1990dd>=405 & occ1990dd<=408)

gen occ3_protect=0        /* all protective service */
replace occ3_protect=1 if (occ1990dd>=415 & occ1990dd<=427)

   gen occ3a_guard=0          /* supervisors of guards; guards */
   replace occ3a_guard=1 if (occ1990dd==415 | (occ1990dd>=425 & occ1990dd<=427))

   gen occ3a_firepol=0        /* fire fighting, police, and correctional insitutions */
   replace occ3a_firepol=1 if (occ1990dd>=417 & occ1990dd<=423)

gen occ3_food=0           /* food preparation and service occs */
replace occ3_food=1 if (occ1990dd>=433 & occ1990dd<=444)

gen occ3_shealth=0        /* health service occs (dental ass., health/nursing aides) */
replace occ3_shealth=1 if (occ1990dd>=445 & occ1990dd<=447)

gen occ3_janitor=0          /* building and grounds cleaning and maintenance occs */
replace occ3_janitor=1 if (occ1990dd>=448 & occ1990dd<=455)

gen occ3_beauty=0           /* personal appearance occs */
replace occ3_beauty=1 if (occ1990dd>=457 & occ1990dd<=458)

gen occ3_recreation=0      /* recreation and hospitality occs */
replace occ3_recreation=1 if (occ1990dd>=459 & occ1990dd<=467)

gen occ3_child=0           /* child care workers */
replace occ3_child=1 if (occ1990dd==468)

gen occ3_othpers=0        /* misc. personal care and service occs */
replace occ3_othpers=1 if (occ1990dd>=469 & occ1990dd<=472)

assert occ3_clean + occ3a_guard + occ3a_firepol + occ3_food + occ3_shealth + occ3_janitor + occ3_beauty + occ3_child + occ3_recreation + occ3_othpers == occ_service



* special samples of service occupations *

gen occ_service_np=0    /* Census service occupations w/o fire fighting/police/prison */
replace occ_service_np=1 if (occ_service==1 & occ3a_firepol==0)

gen occ_service_broad=0    /* broad definition of service workers, including retail sales, info. clerks, and motor vehicle ops., w/o fire/police */
replace occ_service_broad=1 if (occ_service_np==1 | (occ1990dd>=275 & occ1990dd<=283) | (occ1990dd>=316 & occ1990dd<=319) | (occ1990dd>=316 & occ1990dd<=319) | ((occ1990dd>=803 & occ1990dd<=813) | occ1990dd==887))


* set values to missing for missing/non-civilian occupations *

foreach var of varlist occ_* occ2* occ3* {
   replace `var'=. if occ1990dd<4 | occ1990dd>889 | occ1990dd==.
}

