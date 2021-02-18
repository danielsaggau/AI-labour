#delimit;
set more off;
set mem 10g;

/* This launcher does the following:

(1) Defines sample for each Census year 1960, 1970, 1980, 1990, 2000 and ACS year 2008, adjusts wages, creates education categories
(2) Prepares data for wage regressions / partial r-squared calculations

Melanie Wasserman, 2010

(this file can be deleted)
*/
   

/* (1) Defines sample for each of the years, adjusts wages, creates education categories   */
  
 do microwage1960_ext.do;
 do microwage1970_ext.do;
 do microwage1980_ext.do;
 do microwage1990_2008_ext.do; 
 
 
/* (2) Prepares data for wage regressions / partial r-squared calculations */

foreach yr in  1960 1970 1980 1990 2000 2008
{;
    do census-wg-prep `yr';
};

/* (3) Constructs demographic cells */

foreach yr in  1960 1970 1980 1990 2000 2008
{;
    do census-cells-occ-demog `yr';
};

/* (4) Constructs occupation/industry cells */  
foreach yr in  1960 1970 1980 1990 2000 2008
{;
    do census-cells-ind-occ `yr';
};
