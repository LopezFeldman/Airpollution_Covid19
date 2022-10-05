
**** Program code by Nathaly Rivera
**** Last update: Oct 03, 2022
**** Data: Cross-section of Chilean municipalities
**** Variables: socioecon variables, covid deaths, PM exposure


#delimit ;

set     more off;
scalar 	drop _all;
capture log close;
clear   all;

use "chile_PlosOne.dta";


***************************************************************************;
** Table 1 - Chile **
***************************************************************************;

* Panel A - Chile;
sum cumulative_deaths; 

* Panel B - Chile;
sum cumulative_deaths_rate;

***************************************************************************;
** Table 2 - Chile  **
***************************************************************************;

sum pm25; 

***************************************************************************;
** Table 4 - Chile (Panel II) **
***************************************************************************;
global controls1 hospital_beds adults_less_than_high_school pop_15_44 
				 pop_45_64 pop_older65 pop_density rural days_since_first_case;
global controls2 hospital_beds owner_occup_house median_hh_inc prop_poor
				 gini lowhmto_pop medhmto_pop highhmto_pop publichc_pop
				 adults_less_than_high_school adults_less_than_elementary
				 pop_15_44 pop_45_64 pop_older65 native mining_prop
				 respiratory_casen hypertension_casen diabetes_casen 
				 pop_density rural days_since_first_case daysfirstathome;
global statefe   i.state;				 

* Panel A, Column (1) - All municipalities;
poisson cumulative_deaths pm25, exposure(pop) irr vce(cl state);
est sto col1;
* Panel A, Column (2) - All municipalities;
poisson cumulative_deaths pm25 $controls1, exposure(pop) irr vce(cl state);
est sto col2;
* Panel A, Column (3) - All municipalities;
poisson cumulative_deaths pm25 $controls1 $statefe, exposure(pop) irr vce(cl state);
est sto col3;
* Panel A, Column (4) - All municipalities;
poisson cumulative_deaths pm25 $controls2 $statefe, exposure(pop) irr vce(cl state);
est sto col4;

esttab col1 col2 col3 col4 using "$results/Tab4_CHILE_PanelA.tex", 
		eform ci replace label  star(* 0.10 ** 0.05 *** 0.01) nocons
		drop ($demo $income $educ $hosp $health 
		pop_density rural days_since_first_case daysfirstathome *state _cons);
		
* Panel B, Column (1) - Metropolitan areas;
poisson cumulative_deaths pm25 if metroarea == 1, exposure(pop) irr vce(cl state);
est sto col1;
* Panel B, Column (2) - Metropolitan areas;
poisson cumulative_deaths pm25 $controls1 if metroarea == 1, exposure(pop) irr vce(cl state);
est sto col2;
* Panel B, Column (3) - Metropolitan areas;
poisson cumulative_deaths pm25 $controls1 $statefe if metroarea == 1, exposure(pop) irr vce(cl state);
est sto col3;
* Panel B, Column (4) - Metropolitan areas;
poisson cumulative_deaths pm25 $controls2 $statefe if metroarea == 1, exposure(pop) irr vce(cl state);
est sto col4;	

esttab col1 col2 col3 col4 using "$results/Tab4_CHILE_PanelB.tex", 
		eform ci replace label  star(* 0.10 ** 0.05 *** 0.01) nocons
		drop ($demo $income $educ $hosp $health 
		pop_density rural days_since_first_case daysfirstathome *state _cons);	
	
		
* Panel C, Column (1) - Non-Metropolitan areas;
poisson cumulative_deaths pm25 if metroarea == 0, exposure(pop) irr vce(cl state);
est sto col1;
* Panel C, Column (2) - Non-Metropolitan areas;
poisson cumulative_deaths pm25 $controls1 if metroarea == 0, exposure(pop) irr vce(cl state);
est sto col2;
* Panel C, Column (3) - Non-Metropolitan areas;
poisson cumulative_deaths pm25 $controls1 $statefe if metroarea == 0, exposure(pop) irr vce(cl state);
est sto col3;
* Panel C, Column (4) - Non-Metropolitan areas;
poisson cumulative_deaths pm25 $controls2 $statefe if metroarea == 0, exposure(pop) irr vce(cl state);
est sto col4;	

esttab col1 col2 col3 col4 using "$results/Tab4_CHILE_PanelC.tex", 
		eform ci replace label  star(* 0.10 ** 0.05 *** 0.01) nocons
		drop ($demo $income $educ $hosp $health 
		pop_density rural days_since_first_case daysfirstathome *state _cons);	
	
	
***************************************************************************;
** Table B1 - Chile  **
***************************************************************************;

sum pm25_last9y;
	
	
***************************************************************************;
** Table B3 - Chile (Panel II) **
***************************************************************************;	
	
global pm pm25_last9y;

* Panel A, Column (1) - All municipalities;
poisson cumulative_deaths $pm, exposure(pop) irr vce(cl state);
est sto col1;
* Panel A, Column (2) - All municipalities;
poisson cumulative_deaths $pm $controls1, exposure(pop) irr vce(cl state);
est sto col2;
* Panel A, Column (3) - All municipalities;
poisson cumulative_deaths $pm $controls1 $statefe, exposure(pop) irr vce(cl state);
est sto col3;
* Panel A, Column (4) - All municipalities;
poisson cumulative_deaths $pm $controls2 $statefe, exposure(pop) irr vce(cl state);
est sto col4;

esttab col1 col2 col3 col4 using "$results/TabB3_CHILE_PanelA.tex", 
		eform ci replace label  star(* 0.10 ** 0.05 *** 0.01) nocons
		drop ($demo $income $educ $hosp $health 
		pop_density rural days_since_first_case daysfirstathome *state _cons);
		
* Panel B, Column (1) - Metropolitan areas;
poisson cumulative_deaths $pm if metroarea == 1, exposure(pop) irr vce(cl state);
est sto col1;
* Panel B, Column (2) - Metropolitan areas;
poisson cumulative_deaths $pm $controls1 if metroarea == 1, exposure(pop) irr vce(cl state);
est sto col2;
* Panel B, Column (3) - Metropolitan areas;
poisson cumulative_deaths $pm $controls1 $statefe if metroarea == 1, exposure(pop) irr vce(cl state);
est sto col3;
* Panel B, Column (4) - Metropolitan areas;
poisson cumulative_deaths $pm $controls2 $statefe if metroarea == 1, exposure(pop) irr vce(cl state);
est sto col4;	

esttab col1 col2 col3 col4 using "$results/TabB3_CHILE_PanelB.tex", 
		eform ci replace label  star(* 0.10 ** 0.05 *** 0.01) nocons
		drop ($demo $income $educ $hosp $health 
		pop_density rural days_since_first_case daysfirstathome *state _cons);	
	
		
* Panel C, Column (1) - Non-Metropolitan areas;
poisson cumulative_deaths $pm if metroarea == 0, exposure(pop) irr vce(cl state);
est sto col1;
* Panel C, Column (2) - Non-Metropolitan areas;
poisson cumulative_deaths $pm $controls1 if metroarea == 0, exposure(pop) irr vce(cl state);
est sto col2;
* Panel C, Column (3) - Non-Metropolitan areas;
poisson cumulative_deaths $pm $controls1 $statefe if metroarea == 0, exposure(pop) irr vce(cl state);
est sto col3;
* Panel C, Column (4) - Non-Metropolitan areas;
poisson cumulative_deaths $pm $controls2 $statefe if metroarea == 0, exposure(pop) irr vce(cl state);
est sto col4;	

esttab col1 col2 col3 col4 using "$results/TabB3_CHILE_PanelC.tex", 
		eform ci replace label  star(* 0.10 ** 0.05 *** 0.01) nocons
		drop ($demo $income $educ $hosp $health 
		pop_density rural days_since_first_case daysfirstathome *state _cons);	
	
***************************************************************************;
** Table B6 - Panel II Chile  **
***************************************************************************;

* Panel A, Column (1) - All municipalities;
nbreg cumulative_deaths pm25, exposure(pop) irr vce(cl state);
est sto col1;
* Panel A, Column (2) - All municipalities;
nbreg cumulative_deaths pm25 $controls1, exposure(pop) irr vce(cl state);
est sto col2;
* Panel A, Column (3) - All municipalities;
nbreg cumulative_deaths pm25 $controls1 $statefe, exposure(pop) irr vce(cl state);
est sto col3;
* Panel A, Column (4) - All municipalities;
nbreg cumulative_deaths pm25 $controls2 $statefe, exposure(pop) irr vce(cl state);
est sto col4;

esttab col1 col2 col3 col4 using "$results/TabB6_CHILE_PanelA.tex", 
		eform ci replace label  star(* 0.10 ** 0.05 *** 0.01) nocons
		drop ($demo $income $educ $hosp $health 
		pop_density rural days_since_first_case daysfirstathome *state 
		_cons lnalpha);
		
* Panel B, Column (1) - Metropolitan areas;
nbreg cumulative_deaths pm25 if metroarea == 1, exposure(pop) irr vce(cl state);
est sto col1;
* Panel B, Column (2) - Metropolitan areas;
nbreg cumulative_deaths pm25 $controls1 if metroarea == 1, exposure(pop) irr vce(cl state);
est sto col2;
* Panel B, Column (3) - Metropolitan areas;
nbreg cumulative_deaths pm25 $controls1 $statefe if metroarea == 1, exposure(pop) irr vce(cl state);
est sto col3;
* Panel B, Column (4) - Metropolitan areas;
nbreg cumulative_deaths pm25 $controls2 $statefe if metroarea == 1, exposure(pop) irr vce(cl state);
est sto col4;	

esttab col1 col2 col3 col4 using "$results/TabB6_CHILE_PanelB.tex", 
		eform ci replace label  star(* 0.10 ** 0.05 *** 0.01) nocons
		drop ($demo $income $educ $hosp $health 
		pop_density rural days_since_first_case daysfirstathome *state 
		_cons lnalpha);	
	
		
* Panel C, Column (1) - Non-Metropolitan areas;
nbreg cumulative_deaths pm25 if metroarea == 0, exposure(pop) irr vce(cl state);
est sto col1;
* Panel C, Column (2) - Non-Metropolitan areas;
nbreg cumulative_deaths pm25 $controls1 if metroarea == 0, exposure(pop) irr vce(cl state);
est sto col2;
* Panel C, Column (3) - Non-Metropolitan areas;
nbreg cumulative_deaths pm25 $controls1 $statefe if metroarea == 0, exposure(pop) irr vce(cl state);
est sto col3;
* Panel C, Column (4) - Non-Metropolitan areas;
nbreg cumulative_deaths pm25 $controls2 $statefe if metroarea == 0, exposure(pop) irr vce(cl state);
est sto col4;	

esttab col1 col2 col3 col4 using "$results/TabB6_CHILE_PanelC.tex", 
		eform ci replace label  star(* 0.10 ** 0.05 *** 0.01) nocons
		drop ($demo $income $educ $hosp $health 
		pop_density rural days_since_first_case daysfirstathome *state 
		_cons lnalpha);
	
	
	
	
	
	
	
	
	
	
	
	
	
		
		
