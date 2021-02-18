#delimit;

/* This file will make adjustments to Census Occupations to create a consistent management category */

if `1'>=2000
{;
replace occ1990dd=22 if occ==16;
replace occ1990dd=22 if occ==131;
replace occ1990dd=22 if occ==271;

/* Only occs in their particular occ1990dd */
replace occ1990dd=22 if occ==500;
replace occ1990dd=22 if occ==700;
replace occ1990dd=22 if occ==900;
replace occ1990dd=22 if occ==904;
};

if `1'<=1990
{;
/* Place these occ1990dd's that no longer exist in another occ1990dd category: n.e.c. */
replace occ1990dd=389 if occ1990dd==303;
replace occ1990dd=549 if occ1990dd==503;
replace occ1990dd=859 if occ1990dd==803;
replace occ1990dd=235 if occ1990dd==227;
};