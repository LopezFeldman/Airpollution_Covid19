
**** Program code by Jorge Bonilla
**** Last update: Oct 10, 2022
**** Data: Cross-section of Colombian municipalities
**** Variables: socioecon variables, covid deaths, PM exposure

set more off
clear all

use "colombia_PlosOne.dta"

***************************************************************************;
** Table 1 - Colombia **
***************************************************************************;

* Panel A - Colombia
sum cumulative_deaths

* Panel B - Colombia
sum cumulative_deaths_rate


***************************************************************************;
** Table 2 - Colombia  **
***************************************************************************;

sum pm25 

***************************************************************************;
** Table 4 - Colombia (Panel III) **
***************************************************************************;

* Panel A - All municipalities

eststo clear

* Panel A, Column (1) - All municipalities
eststo NO_CONTROLS: quiet poisson cumulative_deaths pm25, exposure(population) irr vce(cl state)
* Panel A, Column (2) - All municipalities
global common hospital_beds adults_less_than_high_school pop_15_44 pop_45_64 pop_older65 pop_density rural_area days_since_first_case
eststo COMMON_CONTROLS: quiet poisson cumulative_deaths pm25 $common, exposure(population) irr vce(cl state)
* Panel A, Column (3) - All municipalities
eststo COMMON_CONTROLS_F: quiet poisson cumulative_deaths pm25 $common i.state, exposure(population) irr vce(cl state)
* Panel A, Column (4) - All municipalities
global richer black pop_poverty diabetes hypertension respiratory obese
eststo RICHER_CONTROLS: quiet poisson cumulative_deaths pm25 $common $richer i.state, exposure(population) irr vce(cl state)
esttab  , star(* 0.1 ** 0.05 *** 0.01) b(%7.3f) ci(%7.3f) sfmt(%7.3f)  label eform replace keep(pm25) mtitles("NO_CONTROLS" "COMMON_CONTROLS" "COMMON_CONTROLS_F" "RICHER_CONTROLS")

* Panel B - Metropolitan areas

preserve
eststo clear
keep if metro_area==1
* Panel B, Column (1) - Metropolitan areas
eststo NO_CONTROLS: quiet poisson cumulative_deaths pm25, exposure(population) irr vce(cl regions1)
* Panel B, Column (2) - Metropolitan areas
global common hospital_beds adults_less_than_high_school pop_15_44 pop_45_64 pop_older65 pop_density rural_area days_since_first_case
eststo COMMON_CONTROLS: quiet poisson cumulative_deaths pm25 $common, exposure(population) irr vce(cl regions1)
* Panel B, Column (3) - Metropolitan areas
eststo COMMON_CONTROLS_F: quiet poisson cumulative_deaths pm25 $common i.regions1, exposure(population) irr vce(cl regions1)
* Panel B, Column (4) - Metropolitan areas
global richer black pop_poverty diabetes hypertension respiratory obese
eststo RICHER_CONTROLS: quiet poisson cumulative_deaths pm25 $common $richer i.regions1, exposure(population) irr vce(cl regions1)
esttab  , star(* 0.1 ** 0.05 *** 0.01) b(%7.3f) ci(%7.3f) sfmt(%7.3f)  label eform replace keep(pm25) mtitles("NO_CONTROLS" "COMMON_CONTROLS" "COMMON_CONTROLS_F" "RICHER_CONTROLS")
restore

* Panel C - Non-Metropolitan areas

preserve
eststo clear
keep if metro_area==0
* Panel C, Column (1) - Non-Metropolitan areas
eststo NO_CONTROLS: quiet poisson cumulative_deaths pm25, exposure(population) irr vce(cl state)
* Panel C, Column (1) - Non-Metropolitan areas
global common hospital_beds adults_less_than_high_school pop_15_44 pop_45_64 pop_older65 pop_density rural_area days_since_first_case
eststo COMMON_CONTROLS: quiet poisson cumulative_deaths pm25 $common, exposure(population) irr vce(cl state)
* Panel C, Column (1) - Non-Metropolitan areas
eststo COMMON_CONTROLS_F: quiet poisson cumulative_deaths pm25 $common i.state, exposure(population) irr vce(cl state)
* Panel C, Column (1) - Non-Metropolitan areas
global richer black pop_poverty diabetes hypertension respiratory obese
eststo RICHER_CONTROLS: quiet poisson cumulative_deaths pm25 $common $richer i.state, exposure(population) irr vce(cl state)
esttab  , star(* 0.1 ** 0.05 *** 0.01) b(%7.3f) ci(%7.3f) sfmt(%7.3f)  label eform replace keep(pm25) mtitles("NO_CONTROLS" "COMMON_CONTROLS" "COMMON_CONTROLS_F" "RICHER_CONTROLS")
restore

***************************************************************************;
** Table S1 - Colombia  **
***************************************************************************;

sum pm25_last9y
	
***************************************************************************;
** Table S3 - Colombia (Panel III) **
***************************************************************************;	

* Panel A - All municipalities

eststo clear

* Panel A, Column (1) - All municipalities
eststo NO_CONTROLS: quiet poisson cumulative_deaths pm25_last9y, exposure(population) irr vce(cl state)
* Panel A, Column (2) - All municipalities
global common hospital_beds adults_less_than_high_school pop_15_44 pop_45_64 pop_older65 pop_density rural_area days_since_first_case
eststo COMMON_CONTROLS: quiet poisson cumulative_deaths pm25_last9y $common, exposure(population) irr vce(cl state)
* Panel A, Column (3) - All municipalities
eststo COMMON_CONTROLS_F: quiet poisson cumulative_deaths pm25_last9y $common i.state, exposure(population) irr vce(cl state)
* Panel A, Column (4) - All municipalities
global richer black pop_poverty diabetes hypertension respiratory obese
eststo RICHER_CONTROLS: quiet poisson cumulative_deaths pm25_last9y $common $richer i.state, exposure(population) irr vce(cl state)
esttab  , star(* 0.1 ** 0.05 *** 0.01) b(%7.3f) ci(%7.3f) sfmt(%7.3f)  label eform replace keep(pm25_last9y) mtitles("NO_CONTROLS" "COMMON_CONTROLS" "COMMON_CONTROLS_F" "RICHER_CONTROLS")

* Panel B - Metropolitan areas

preserve
eststo clear
keep if metro_area==1
* Panel B, Column (1) - Metropolitan areas
eststo NO_CONTROLS: quiet poisson cumulative_deaths pm25_last9y, exposure(population) irr vce(cl regions1)
* Panel B, Column (2) - Metropolitan areas
global common hospital_beds adults_less_than_high_school pop_15_44 pop_45_64 pop_older65 pop_density rural_area days_since_first_case
eststo COMMON_CONTROLS: quiet poisson cumulative_deaths pm25_last9y $common, exposure(population) irr vce(cl regions1)
* Panel B, Column (3) - Metropolitan areas
eststo COMMON_CONTROLS_F: quiet poisson cumulative_deaths pm25_last9y $common i.regions1, exposure(population) irr vce(cl regions1)
* Panel B, Column (4) - Metropolitan areas
global richer black pop_poverty diabetes hypertension respiratory obese
eststo RICHER_CONTROLS: quiet poisson cumulative_deaths pm25_last9y $common $richer i.regions1, exposure(population) irr vce(cl regions1)
esttab  , star(* 0.1 ** 0.05 *** 0.01) b(%7.3f) ci(%7.3f) sfmt(%7.3f)  label eform replace keep(pm25_last9y) mtitles("NO_CONTROLS" "COMMON_CONTROLS" "COMMON_CONTROLS_F" "RICHER_CONTROLS")
restore

* Panel C - Non-Metropolitan areas

preserve
eststo clear
keep if metro_area==0
* Panel C, Column (1) - Non-Metropolitan areas
eststo NO_CONTROLS: quiet poisson cumulative_deaths pm25_last9y, exposure(population) irr vce(cl state)
* Panel C, Column (2) - Non-Metropolitan areas
global common hospital_beds adults_less_than_high_school pop_15_44 pop_45_64 pop_older65 pop_density rural_area days_since_first_case
eststo COMMON_CONTROLS: quiet poisson cumulative_deaths pm25_last9y $common, exposure(population) irr vce(cl state)
* Panel C, Column (3) - Non-Metropolitan areas
eststo COMMON_CONTROLS_F: quiet poisson cumulative_deaths pm25_last9y $common i.state, exposure(population) irr vce(cl state)
* Panel C, Column (4) - Non-Metropolitan areas
global richer black pop_poverty diabetes hypertension respiratory obese
eststo RICHER_CONTROLS: quiet poisson cumulative_deaths pm25_last9y $common $richer i.state, exposure(population) irr vce(cl state)
esttab  , star(* 0.1 ** 0.05 *** 0.01) b(%7.3f) ci(%7.3f) sfmt(%7.3f)  label eform replace keep(pm25_last9y) mtitles("NO_CONTROLS" "COMMON_CONTROLS" "COMMON_CONTROLS_F" "RICHER_CONTROLS")
restore

***************************************************************************;
** Table S6 - Colombia (Panel III) **
***************************************************************************;

* Panel A - All municipalities

eststo clear

* Panel A, Column (1) - All municipalities
eststo NO_CONTROLS: quiet nbreg cumulative_deaths pm25, exposure(population) irr vce(cl state)
* Panel A, Column (2) - All municipalities
global common hospital_beds adults_less_than_high_school pop_15_44 pop_45_64 pop_older65 pop_density rural_area days_since_first_case
eststo COMMON_CONTROLS: quiet nbreg cumulative_deaths pm25 $common, exposure(population) irr vce(cl state)
* Panel A, Column (3) - All municipalities
eststo COMMON_CONTROLS_F: quiet nbreg cumulative_deaths pm25 $common i.state, exposure(population) irr vce(cl state)
* Panel A, Column (4) - All municipalities
global richer black pop_poverty diabetes hypertension respiratory obese
eststo RICHER_CONTROLS: quiet nbreg cumulative_deaths pm25 $common $richer i.state, exposure(population) irr vce(cl state)
esttab  , star(* 0.1 ** 0.05 *** 0.01) b(%7.3f) ci(%7.3f) sfmt(%7.3f)  label eform replace keep(pm25) mtitles("NO_CONTROLS" "COMMON_CONTROLS" "COMMON_CONTROLS_F" "RICHER_CONTROLS")

* Panel B - Metropolitan areas

preserve
eststo clear
keep if metro_area==1
* Panel B, Column (1) - Metropolitan areas
eststo NO_CONTROLS: quiet nbreg cumulative_deaths pm25, exposure(population) irr vce(cl regions1)
* Panel B, Column (2) - Metropolitan areas
global common hospital_beds adults_less_than_high_school pop_15_44 pop_45_64 pop_older65 pop_density rural_area days_since_first_case
eststo COMMON_CONTROLS: quiet nbreg cumulative_deaths pm25 $common, exposure(population) irr vce(cl regions1)
* Panel B, Column (3) - Metropolitan areas
eststo COMMON_CONTROLS_F: quiet nbreg cumulative_deaths pm25 $common i.regions1, exposure(population) irr vce(cl regions1)
* Panel B, Column (4) - Metropolitan areas
global richer black pop_poverty diabetes hypertension respiratory obese
eststo RICHER_CONTROLS: quiet nbreg cumulative_deaths pm25 $common $richer i.regions1, exposure(population) irr vce(cl regions1)
esttab  , star(* 0.1 ** 0.05 *** 0.01) b(%7.3f) ci(%7.3f) sfmt(%7.3f)  label eform replace keep(pm25) mtitles("NO_CONTROLS" "COMMON_CONTROLS" "COMMON_CONTROLS_F" "RICHER_CONTROLS")
restore


* Panel C - Non-Metropolitan areas

preserve
eststo clear
keep if metro_area==0
* Panel C, Column (1) - Non-Metropolitan areas
eststo NO_CONTROLS: quiet nbreg cumulative_deaths pm25, exposure(population) irr vce(cl state)
* Panel C, Column (1) - Non-Metropolitan areas
global common hospital_beds adults_less_than_high_school pop_15_44 pop_45_64 pop_older65 pop_density rural_area days_since_first_case
eststo COMMON_CONTROLS: quiet nbreg cumulative_deaths pm25 $common, exposure(population) irr vce(cl state)
* Panel C, Column (1) - Non-Metropolitan areas
eststo COMMON_CONTROLS_F: quiet nbreg cumulative_deaths pm25 $common i.state, exposure(population) irr vce(cl state)
* Panel C, Column (1) - Non-Metropolitan areas
global richer black pop_poverty diabetes hypertension respiratory obese
eststo RICHER_CONTROLS: quiet nbreg cumulative_deaths pm25 $common $richer i.state, exposure(population) irr vce(cl state)
esttab  , star(* 0.1 ** 0.05 *** 0.01) b(%7.3f) ci(%7.3f) sfmt(%7.3f)  label eform replace keep(pm25) mtitles("NO_CONTROLS" "COMMON_CONTROLS" "COMMON_CONTROLS_F" "RICHER_CONTROLS")
restore


