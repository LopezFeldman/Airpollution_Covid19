*** Program code by Alejandro Lopez-Feldman and Nathaly Rivera
*** Last update: Oct 04, 2022
*** Data: Cross-section of municipalities for Brazil, Chile, Colombia and Mexico
*** Variables: socioecon variables, covid deaths, PM exposure
******************************************************************************

set     more off
scalar 	drop _all
capture log close
clear   all
estimates clear

use "all_countries_PlosOne.dta"



***************************************************************************
** Table 3 **
***************************************************************************

global common hospital_beds pop_density pop_older65 pop_45_64 pop_15_44 rural_prop adults_less_than_high_school days_since_first_case
global pm pm2_5				
******************************************************
* Panel A. All municipalities
******************************************************
* Column (1) 
poisson cumulative_deaths $pm , exposure(population) vce(clu cont_state) irr
estimates store reg_a1 
* Column (2)
poisson cumulative_deaths $pm $common , exposure(population) vce(clu cont_state) irr
estimates store reg_a2 
* Column (3)
poisson cumulative_deaths $pm $common i.country , exposure(population) vce(clu cont_state) irr 
estimates store reg_a3 
******************************************************
* Panel B. Metro areas
******************************************************
* Column (1)
poisson cumulative_deaths $pm if metro ==1, exposure(population) vce(clu cont_state) irr
estimates store reg_b1 
* Column (2) 
poisson cumulative_deaths $pm $common if metro ==1 , exposure(population) vce(clu cont_state) irr
estimates store reg_b2 
* Column (3)
poisson cumulative_deaths $pm $common i.country if metro ==1 , exposure(population) vce(clu cont_state) irr  
estimates store reg_b3  
******************************************************
* Panel C. Non-metro areas
******************************************************
* Column (1) 
poisson cumulative_deaths $pm if metro ==0, exposure(population) vce(clu cont_state) irr
estimates store reg_c1 
* Column (2) 
poisson cumulative_deaths $pm $common if metro ==0 , exposure(population) vce(clu cont_state) irr
estimates store reg_c2 
* Column (3)
poisson cumulative_deaths $pm $common i.country if metro ==0 , exposure(population) vce(clu cont_state) irr  
estimates store reg_c3  

****
esttab reg_a1 reg_a2 reg_a3 using "results/all_1.tex", replace label  b(%7.4f) star(* 0.10 ** 0.05 *** 0.01)  ///
keep (pm*) ci(%7.4f) scalar(converged chi2) eform nonote

esttab reg_b1 reg_b2 reg_b3 using "results/all_1.tex", append label  b(%7.4f) star(* 0.10 ** 0.05 *** 0.01)  ///
keep (pm*) ci(%7.4f) scalar(converged chi2) eform nonote

esttab reg_c1 reg_c2 reg_c3 using "results/all_1.tex", append label  b(%7.4f) star(* 0.10 ** 0.05 *** 0.01) ///
keep (pm*) ci(%7.4f) scalar(converged chi2) eform nonote

***************************************************************************
** Table S2  **
***************************************************************************	

global pm pm2_5_last9y				
******************************************************
* Panel A. All municipalities
******************************************************
* Column (1) 
poisson cumulative_deaths $pm , exposure(population) vce(clu cont_state) irr
estimates store reg_a1_2 
* Column (2) 
poisson cumulative_deaths $pm $common , exposure(population) vce(clu cont_state) irr
estimates store reg_a2_2 
* Column (3) 
poisson cumulative_deaths $pm $common i.country , exposure(population) vce(clu cont_state) irr 
estimates store reg_a3_2 
******************************************************
* Panel B. Metro areas
******************************************************
* Column (1)  
poisson cumulative_deaths $pm if metro ==1, exposure(population) vce(clu cont_state) irr
estimates store reg_b1_2 
* Column (2)  
poisson cumulative_deaths $pm $common if metro ==1 , exposure(population) vce(clu cont_state) irr
estimates store reg_b2_2 
* Column (3) 
poisson cumulative_deaths $pm $common i.country if metro ==1 , exposure(population) vce(clu cont_state) irr  
estimates store reg_b3_2  
******************************************************
* Panel C. Non-metro areas
******************************************************
* Column (1)  
poisson cumulative_deaths $pm if metro ==0, exposure(population) vce(clu cont_state) irr
estimates store reg_c1_2 
* Column (2)  
poisson cumulative_deaths $pm $common if metro ==0 , exposure(population) vce(clu cont_state) irr
estimates store reg_c2_2 
* Column (3) 
poisson cumulative_deaths $pm $common i.country if metro ==0 , exposure(population) vce(clu cont_state) irr  
estimates store reg_c3_2  
***
esttab reg_a1_2 reg_a2_2 reg_a3_2  using "results/all_2.tex", replace label  b(%7.4f) star(* 0.10 ** 0.05 *** 0.01)  ///
keep (pm*) ci(%7.4f) scalar(converged chi2) eform nonote

esttab reg_b1_2 reg_b2_2 reg_b3_2  using "results/all_2.tex", append label  b(%7.4f) star(* 0.10 ** 0.05 *** 0.01)  ///
keep (pm*) ci(%7.4f) scalar(converged chi2) eform nonote

esttab reg_c1_2 reg_c2_2 reg_c3_2  using "results/all_2.tex", append label  b(%7.4f) star(* 0.10 ** 0.05 *** 0.01)  ///
keep (pm*) ci(%7.4f) scalar(converged chi2) eform nonote

***************************************************************************
** Table S4  **
***************************************************************************	

gen 	pm_high = 0
replace pm_high = 1 if pm2_5 >= 10 /// WHO GUIDELINE

gen 	pm25_1 = 0
replace pm25_1 = pm2_5 * pm_high if pm_high == 1
gen 	pm25_0 = 0
replace pm25_0 = pm2_5 if pm_high == 0

global common hospital_beds pop_density pop_older65 pop_45_64 pop_15_44 ///
			  rural_prop adults_less_than_high_school days_since_first_case
		
global pm pm25_1 pm25_0		
******************************************************
* Panel A. All municipalities
******************************************************
* Column (1) 
poisson cumulative_deaths $pm, exposure(population) vce(clu cont_state) irr
estimates store reg_a1
* Column (2) 
poisson cumulative_deaths $pm $common, exposure(population) vce(clu cont_state) irr
estimates store reg_a2
* Column (3) 
poisson cumulative_deaths $pm $common i.country, exposure(population) vce(clu cont_state) irr  diff
estimates store reg_a3
	
******************************************************
* Panel B. Metro areas
******************************************************	
* Column (1) 
poisson cumulative_deaths $pm if metro ==1, exposure(population) vce(clu cont_state) irr
estimates store reg_b1
* Column (2) 
poisson cumulative_deaths $pm $common if metro ==1, exposure(population) vce(clu cont_state) irr
estimates store reg_b2
* Column (3) 
poisson cumulative_deaths $pm $common i.country if metro ==1, exposure(population) vce(clu cont_state) irr diff
estimates store reg_b3
	
******************************************************
* Panel C. Non-metro areas
******************************************************	
* Column (1) 	
poisson cumulative_deaths $pm if metro ==0, exposure(population) vce(clu cont_state) irr
estimates store reg_c1
* Column (2) 
poisson cumulative_deaths $pm $common if metro ==0, exposure(population) vce(clu cont_state) irr
estimates store reg_c2
* Column (3) 
poisson cumulative_deaths $pm $common i.country if metro ==0, exposure(population) vce(clu cont_state) irr diff
estimates store reg_c3
	
	
***	
esttab reg_a1 reg_a2 reg_a3 using "$results/robustness_1.tex", replace label ///
	   b(%7.3f) star(* 0.10 ** 0.05 *** 0.01) keep ($pm) ci(%7.3f) scalar(converged chi2) eform
	   
esttab reg_b1 reg_b2 reg_b3 using "$results/robustness_1.tex", append label  ///
	   b(%7.3f) star(* 0.10 ** 0.05 *** 0.01)  keep ($pm) ci(%7.3f) scalar(converged chi2) eform
	   
esttab reg_c1 reg_c2 reg_c3 using "$results/robustness_1.tex", append label  ///
	   b(%7.3f) star(* 0.10 ** 0.05 *** 0.01) keep ($pm) ci(%7.3f) scalar(converged chi2) eform   
	
***************************************************************************
** Table S5  **
***************************************************************************	
global pm pm2_5				
******************************************************
* Panel A. All municipalities
******************************************************
* Column (1) 
nbreg cumulative_deaths $pm , exposure(population) vce(clu cont_state) irr
estimates store reg_a1 
* Column (2) 
nbreg cumulative_deaths $pm $common , exposure(population) vce(clu cont_state) irr
estimates store reg_a2 
* Column (3)
nbreg cumulative_deaths $pm $common i.country , exposure(population) vce(clu cont_state) irr 
estimates store reg_a3 
******************************************************
* Panel B. Metro areas
******************************************************
* Column (1) 
nbreg cumulative_deaths $pm if metro ==1, exposure(population) vce(clu cont_state) irr
estimates store reg_b1 
* Column (2) 
nbreg cumulative_deaths $pm $common if metro ==1 , exposure(population) vce(clu cont_state) irr
estimates store reg_b2 
* Column (3)
nbreg cumulative_deaths $pm $common i.country if metro ==1 , exposure(population) vce(clu cont_state) irr  
estimates store reg_b3  
******************************************************
* Panel C. Non-metro areas
******************************************************
* Column (1) 
nbreg cumulative_deaths $pm if metro ==0, exposure(population) vce(clu cont_state) irr
estimates store reg_c1 
* Column (2) 
nbreg cumulative_deaths $pm $common if metro ==0 , exposure(population) vce(clu cont_state) irr
estimates store reg_c2 
* Column (3)
nbreg cumulative_deaths $pm $common i.country if metro ==0 , exposure(population) vce(clu cont_state) irr  
estimates store reg_c3  

***
esttab reg_a1 reg_a2 reg_a3 using "results/all_1_nb.tex", replace label  b(%7.3f) star(* 0.10 ** 0.05 *** 0.01)  ///
keep (pm*) ci(%7.3f) scalar(converged chi2) eform nonote

esttab reg_b1 reg_b2 reg_b3 using "results/all_1_nb.tex", append label  b(%7.3f) star(* 0.10 ** 0.05 *** 0.01)  ///
keep (pm*) ci(%7.3f) scalar(converged chi2) eform nonote

esttab reg_c1 reg_c2 reg_c3 using "results/all_1_nb.tex", append label  b(%7.3f) star(* 0.10 ** 0.05 *** 0.01) ///
keep (pm*) ci(%7.3f) scalar(converged chi2) eform nonote
