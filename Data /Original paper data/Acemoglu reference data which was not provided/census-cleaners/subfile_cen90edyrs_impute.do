/*  FOR USE WITH 1990 CENSUS ONLY    This program imputes years of education for calculating experience to workers using highest degree held, race, and gender.  Imputations are based on figures in Jim Heun Park, Princeton IRS Working Paper #338, 1994.    The following variables are required:    grade92 - Degree completed from CPS (values 31-46)  race - 1=white, 2=black, 3=other  sex - 1=male, 2=female* Note: Updated by M. Wasserman for 'educ', which replaced 'educ99' in the 1990-2008 samples*/gen edyrs=  0replace edyrs= .32  if (race==1 & sex==1 & educ>=10 & educ<=12)replace edyrs= 3.19 if (race==1 & sex==1 & (educ>=13 & educ<=17))replace edyrs= 7.24 if (race==1 & sex==1 & (educ>=20 & educ<=26))replace edyrs= 8.97 if (race==1 & sex==1 & (educ==30))replace edyrs= 9.92 if (race==1 & sex==1 & (educ==40))replace edyrs= 10.86 if (race==1 & sex==1 & (educ==50))replace edyrs= 11.58 if (race==1 & sex==1 & (educ==61))replace edyrs= 11.99 if (race==1 & sex==1 & (educ>=62 & educ<=64))replace edyrs= 13.48 if (race==1 & sex==1 & (educ==65 | educ==71))replace edyrs= 14.23 if (race==1 & sex==1 & (educ>=80 & educ<=83))replace edyrs= 16.17 if (race==1 & sex==1 & (educ==100 | educ==101))replace edyrs= 17.68 if (race==1 & sex==1 & educ==114)replace edyrs= 17.71 if (race==1 & sex==1 & educ==115)replace edyrs= 17.83 if (race==1 & sex==1 & educ==116)* female, whitereplace edyrs= 0.62 if (race==1 & sex==2 & educ>=10 & educ<=12)replace edyrs= 3.15 if (race==1 & sex==2 & (educ>=13 & educ<=17))replace edyrs= 7.23 if (race==1 & sex==2 & (educ>=20 & educ<=26))replace edyrs= 8.99 if (race==1 & sex==2 & (educ==30))replace edyrs= 9.95 if (race==1 & sex==2 & (educ==40))replace edyrs= 10.87 if (race==1 & sex==2 & (educ==50))replace edyrs= 11.73 if (race==1 & sex==2 & (educ==61))replace edyrs= 12.00 if (race==1 & sex==2 & (educ>=62 & educ<=64))replace edyrs= 13.35 if (race==1 & sex==2 & (educ==65 | educ==71))replace edyrs= 14.22 if (race==1 & sex==2 & (educ>=80 & educ<=83))replace edyrs= 16.15 if (race==1 & sex==2 & (educ==100 | educ==101))replace edyrs= 17.64 if (race==1 & sex==2 & educ==114)replace edyrs= 17.00 if (race==1 & sex==2 & educ==115)replace edyrs= 17.76 if (race==1 & sex==2 & educ==116)* men, blackreplace edyrs= .92  if (race==2 & sex==1 & educ>=10 & educ<=12)replace edyrs= 3.28 if (race==2 & sex==1 & (educ>=13 & educ<=17))replace edyrs= 7.04 if (race==2 & sex==1 & (educ>=20 & educ<=26))replace edyrs= 9.02 if (race==2 & sex==1 & (educ==30))replace edyrs= 9.91 if (race==2 & sex==1 & (educ==40))replace edyrs= 10.90 if (race==2 & sex==1 & (educ==50))replace edyrs= 11.41 if (race==2 & sex==1 & (educ==61))replace edyrs= 11.98 if (race==2 & sex==1 & (educ>=62 & educ<=64))replace edyrs= 13.57 if (race==2 & sex==1 & (educ==65 | educ==71))replace edyrs= 14.33 if (race==2 & sex==1 & (educ>=80 & educ<=83))replace edyrs= 16.13 if (race==2 & sex==1 & (educ==100 | educ==101))replace edyrs= 17.51 if (race==2 & sex==1 & educ==114)replace edyrs= 17.83 if (race==2 & sex==1 & educ==115)replace edyrs= 18.00 if (race==2 & sex==1 & educ==116)* female, blackreplace edyrs= 0.00 if (race==2 & sex==2 & educ>=10 & educ<=12)replace edyrs= 2.90 if (race==2 & sex==2 & (educ>=13 & educ<=17))replace edyrs= 7.03 if (race==2 & sex==2 & (educ>=20 & educ<=26))replace edyrs= 9.05 if (race==2 & sex==2 & (educ==30))replace edyrs= 9.99 if (race==2 & sex==2 & (educ==40))replace edyrs= 10.85 if (race==2 & sex==2 & (educ==50))replace edyrs= 11.64 if (race==2 & sex==2 & (educ==61))replace edyrs= 12.00 if (race==2 & sex==2 & (educ>=62 & educ<=64))replace edyrs= 13.43 if (race==2 & sex==2 & (educ==65 | educ==71))replace edyrs= 14.33 if (race==2 & sex==2 & (educ>=80 & educ<=83))replace edyrs= 16.04 if (race==2 & sex==2 & (educ==100 | educ==101))replace edyrs= 17.69 if (race==2 & sex==2 & educ==114)replace edyrs= 17.40 if (race==2 & sex==2 & educ==115)replace edyrs= 18.00 if (race==2 & sex==2 & educ==116)** NOTE:  I am assigning the unweighted average of black & white** educ99ation levels by category to other race groups (this is done** seperately by gender)* men, otherreplace edyrs= .62  if (race==3 & sex==1 & educ>=10 & educ<=12)replace edyrs= 3.24 if (race==3 & sex==1 & (educ>=13 & educ<=17))replace edyrs= 7.14 if (race==3 & sex==1 & (educ>=20 & educ<=26))replace edyrs= 9.00 if (race==3 & sex==1 & (educ==30))replace edyrs= 9.92 if (race==3 & sex==1 & (educ==40))replace edyrs= 10.88 if (race==3 & sex==1 & (educ==50))replace edyrs= 11.50 if (race==3 & sex==1 & (educ==61))replace edyrs= 11.99 if (race==3 & sex==1 & (educ>=62 & educ<=64))replace edyrs= 13.53 if (race==3 & sex==1 & (educ==65 | educ==71))replace edyrs= 14.28 if (race==3 & sex==1 & (educ>=80 & educ<=83))replace edyrs= 16.15 if (race==3 & sex==1 & (educ==100 | educ==101))replace edyrs= 17.60 if (race==3 & sex==1 & educ==114)replace edyrs= 17.77 if (race==3 & sex==1 & educ==115)replace edyrs= 17.92 if (race==3 & sex==1 & educ==116)* female, otherreplace edyrs= 0.31 if (race==3 & sex==2 & educ>=10 & educ<=12)replace edyrs= 3.03 if (race==3 & sex==2 & (educ>=13 & educ<=17))replace edyrs= 7.13 if (race==3 & sex==2 & (educ>=20 & educ<=26))replace edyrs= 9.02 if (race==3 & sex==2 & (educ==30))replace edyrs= 9.97 if (race==3 & sex==2 & (educ==40))replace edyrs= 10.86 if (race==3 & sex==2 & (educ==50))replace edyrs= 11.69 if (race==3 & sex==2 & (educ==61))replace edyrs= 12.00 if (race==3 & sex==2 & (educ>=62 & educ<=64))replace edyrs= 13.47 if (race==3 & sex==2 & (educ==65 | educ==71))replace edyrs= 14.28 if (race==3 & sex==2 & (educ>=80 & educ<=83))replace edyrs= 16.10 if (race==3 & sex==2 & (educ==100 | educ==101))replace edyrs= 17.67 if (race==3 & sex==2 & educ==114)replace edyrs= 17.20 if (race==3 & sex==2 & educ==115)replace edyrs= 17.88 if (race==3 & sex==2 & educ==116)