**** Program code by Alejandro Lopez-Feldman
**** Last update: Oct 04, 2022
**** Data: Cross-section of Mexican municipalities
**** Variables: socioecon variables, covid deaths, PM exposure

set     more off
scalar 	drop _all
capture log close
clear   all

use "Mexico_PlosOne.dta"

***************************************************************************
** Table 1 - Mexico **
***************************************************************************
* Panel A - Mexico
sum cumulative_deaths

* Panel B - Mexico
sum cumulative_deaths_rate

***************************************************************************
** Table 2 - Mexico  **
***************************************************************************
sum pm2_5

***************************************************************************
** Table 4 - Mexico (Panel IV) **
***************************************************************************
global comunes hospital_beds pop_density pop_older65 pop_45_64 ///
 pop_15_44 prop_rural adults_less_than_high_school days_since_first_case
global adicionales d_diab d_hiper afro native por_sin_ss 

* There are a few municipalities without data for the variables native and afro which 
* are used as controls. To ensure that we use the same sample for all our estimations
* we restricte the analysis to municipalities with full information using the if operator 

* Panel A, Column (1) - All municipalities
poisson cumulative_deaths pm2_5 if  native<. & afro<. , exposure(population) vce(clu state) irr
estimates store reg_a1 
* Panel A, Column (2) - All municipalities
poisson cumulative_deaths pm2_5 $comunes if  native<. & afro<. , exposure(population) vce(clu state) irr
estimates store reg_a2
* Panel A, Column (3) - All municipalities
poisson cumulative_deaths pm2_5 $comunes i.state if native<. & afro<. , exposure(population) vce(clu state) irr
estimates store reg_a3
* Panel A, Column (4) - All municipalities
poisson cumulative_deaths pm2_5 $comunes $adicionales  i.state if  native<. & afro<. , exposure(population) vce(clu state) irr
estimates store reg_a4

* Panel B, Column (1) - Metropolitan areas
poisson cumulative_deaths pm2_5 if metro==1 &  native<. & afro<. , exposure(population) vce(clu state) irr
estimates store reg_b1 
* Panel B, Column (2) - Metropolitan areas
poisson cumulative_deaths pm2_5 $comunes if metro==1 &  native<. & afro<. , exposure(population) vce(clu state) irr
estimates store reg_b2
* Panel B, Column (3) - Metropolitan areas
poisson cumulative_deaths pm2_5 $comunes i.state if metro==1 &  native<. & afro<. , exposure(population) vce(clu state) irr
estimates store reg_b3
* Panel B, Column (4) - Metropolitan areas
poisson cumulative_deaths pm2_5 $comunes $adicionales  i.state if metro==1 &  native<. & afro<. , exposure(population) vce(clu state) irr
estimates store reg_b4
		
* Panel C, Column (1) - Non-Metropolitan areas
poisson cumulative_deaths pm2_5 if metro==0 &  native<. & afro<. , exposure(population) vce(clu state) irr
estimates store reg_c1 
* Panel C, Column (2) - Non-Metropolitan areas
poisson cumulative_deaths pm2_5 $comunes if metro==0 & native<. & afro<. , exposure(population) vce(clu state) irr
estimates store reg_c2
* Panel C, Column (3) - Non-Metropolitan areas
poisson cumulative_deaths pm2_5 $comunes i.state if metro==0 &  native<. & afro<., exposure(population) vce(clu state) irr
estimates store reg_c3
* Panel C, Column (4) - Non-Metropolitan areas
poisson cumulative_deaths pm2_5 $comunes $adicionales  i.state if metro==0 &  native<. & afro<., exposure(population) vce(clu state) irr
estimates store reg_c4

****
esttab reg_a1 reg_a2 reg_a3 reg_a4 using "tables/mexico_a.tex", replace label  b(%7.4f) star(* 0.10 ** 0.05 *** 0.01) nocons ///
keep (pm*) ci(%7.4f) scalar(converged chi2) eform nonotes

esttab reg_b1 reg_b2 reg_b3 reg_b4 using "tables/mexico_a.tex", append label  b(%7.4f) star(* 0.10 ** 0.05 *** 0.01) nocons ///
keep (pm*) ci(%7.4f) scalar(converged chi2) eform nonotes

esttab reg_c1 reg_c2 reg_c3 reg_c4 using "tables/mexico_a.tex", append label  b(%7.4f) star(* 0.10 ** 0.05 *** 0.01) nocons ///
keep (pm*) ci(%7.4f) scalar(converged chi2) eform nonotes

***************************************************************************
** Table B1 - Mexico  **
***************************************************************************
sum pm2_5_last9y

***************************************************************************
** Table B3 - Mexico (Panel IV) **
***************************************************************************	
* Panel A, Column (1) - All municipalities
poisson cumulative_deaths pm2_5_last9y if  native<. & afro<. , exposure(population) vce(clu state) irr
estimates store reg_a1_2 
* Panel A, Column (2) - All municipalities
poisson cumulative_deaths pm2_5_last9y $comunes if  native<. & afro<. , exposure(population) vce(clu state) irr
estimates store reg_a2_2
* Panel A, Column (3) - All municipalities
poisson cumulative_deaths pm2_5_last9y $comunes i.state if  native<. & afro<. , exposure(population) vce(clu state) irr
estimates store reg_a3_2
* Panel A, Column (4) - All municipalities
poisson cumulative_deaths pm2_5_last9y $comunes $adicionales  i.state if  native<. & afro<. , exposure(population) vce(clu state) irr
estimates store reg_a4_2
		
* Panel B, Column (1) - Metropolitan areas
poisson cumulative_deaths pm2_5_last9y if metro==1 &  native<. & afro<. , exposure(population) vce(clu state) irr
estimates store reg_b1_2 
* Panel B, Column (2) - Metropolitan areas
poisson cumulative_deaths pm2_5_last9y $comunes if metro==1 &  native<. & afro<. , exposure(population) vce(clu state) irr
estimates store reg_b2_2
* Panel B, Column (3) - Metropolitan areas
poisson cumulative_deaths pm2_5_last9y $comunes i.state if metro==1 &  native<. & afro<. , exposure(population) vce(clu state) irr
estimates store reg_b3_2
* Panel B, Column (4) - Metropolitan areas
poisson cumulative_deaths pm2_5_last9y $comunes $adicionales  i.state if metro==1 &  native<. & afro<. , exposure(population) vce(clu state) irr
estimates store reg_b4_2
			
* Panel C, Column (1) - Non-Metropolitan areas
poisson cumulative_deaths pm2_5_last9y if metro==0 & native<. & afro<. , exposure(population) vce(clu state) irr
estimates store reg_c1_2 
* Panel C, Column (2) - Non-Metropolitan areas
poisson cumulative_deaths pm2_5_last9y $comunes if metro==0 & native<. & afro<. , exposure(population) vce(clu state) irr
estimates store reg_c2_2
* Panel C, Column (3) - Non-Metropolitan areas
poisson cumulative_deaths pm2_5_last9y $comunes i.state if metro==0 & native<. & afro<. , exposure(population) vce(clu state) irr
estimates store reg_c3_2
* Panel C, Column (4) - Non-Metropolitan areas
poisson cumulative_deaths pm2_5_last9y $comunes $adicionales  i.state if metro==0 & native<. & afro<. , exposure(population) vce(clu state) irr
estimates store reg_c4_2

***
esttab reg_a1_2 reg_a2_2 reg_a3_2 reg_a4_2 using "tables/mexico_b.tex", replace label  b(%7.4f) star(* 0.10 ** 0.05 *** 0.01) nocons ///
keep (pm*) ci(%7.4f) scalar(converged chi2) eform nonotes

esttab reg_b1_2 reg_b2_2 reg_b3_2 reg_b4_2 using "tables/mexico_b.tex", append label  b(%7.4f) star(* 0.10 ** 0.05 *** 0.01) nocons ///
keep (pm*) ci(%7.4f) scalar(converged chi2) eform nonotes

esttab reg_c1_2 reg_c2_2 reg_c3_2 reg_c4_2 using "tables/mexico_b.tex", append label  b(%7.4f) star(* 0.10 ** 0.05 *** 0.01) nocons ///
keep (pm*) ci(%7.4f) scalar(converged chi2) eform nonotes

***************************************************************************
** Table B6 - Panel IV Mexico  **
***************************************************************************
* Panel A, Column (1) - All municipalities
nbreg cumulative_deaths pm2_5 if  native<. & afro<. , exposure(population) vce(clu state) irr
estimates store reg_a1_nb 
* Panel A, Column (2) - All municipalities
nbreg cumulative_deaths pm2_5 $comunes if  native<. & afro<. , exposure(population) vce(clu state) irr
estimates store reg_a2_nb
* Panel A, Column (3) - All municipalities
nbreg cumulative_deaths pm2_5 $comunes i.state if native<. & afro<. , exposure(population) vce(clu state) irr
estimates store reg_a3_nb
* Panel A, Column (4) - All municipalities
nbreg cumulative_deaths pm2_5 $comunes $adicionales  i.state if  native<. & afro<. , exposure(population) vce(clu state) irr
estimates store reg_a4_nb

* Panel B, Column (1) - Metropolitan areas
nbreg cumulative_deaths pm2_5 if metro==1 &  native<. & afro<. , exposure(population) vce(clu state) irr
estimates store reg_b1_nb 
* Panel B, Column (2) - Metropolitan areas
nbreg cumulative_deaths pm2_5 $comunes if metro==1 &  native<. & afro<. , exposure(population) vce(clu state) irr
estimates store reg_b2_nb
* Panel B, Column (3) - Metropolitan areas
nbreg cumulative_deaths pm2_5 $comunes i.state if metro==1 &  native<. & afro<. , exposure(population) vce(clu state) irr
estimates store reg_b3_nb
* Panel B, Column (4) - Metropolitan areas
nbreg cumulative_deaths pm2_5 $comunes $adicionales  i.state if metro==1 &  native<. & afro<. , exposure(population) vce(clu state) irr
estimates store reg_b4_nb
		
* Panel C, Column (1) - Non-Metropolitan areas
nbreg cumulative_deaths pm2_5 if metro==0 &  native<. & afro<. , exposure(population) vce(clu state) irr
estimates store reg_c1_nb 
* Panel C, Column (2) - Non-Metropolitan areas
nbreg cumulative_deaths pm2_5 $comunes if metro==0 & native<. & afro<. , exposure(population) vce(clu state) irr
estimates store reg_c2_nb
* Panel C, Column (3) - Non-Metropolitan areas
nbreg cumulative_deaths pm2_5 $comunes i.state if metro==0 &  native<. & afro<., exposure(population) vce(clu state) irr
estimates store reg_c3_nb
* Panel C, Column (4) - Non-Metropolitan areas
nbreg cumulative_deaths pm2_5 $comunes $adicionales  i.state if metro==0 &  native<. & afro<., exposure(population) vce(clu state) irr
estimates store reg_c4_nb

esttab reg_a1_nb reg_a2_nb reg_a3_nb reg_a4_nb using "tables/mexico_a_nb.tex", replace label  b(%7.4f) star(* 0.10 ** 0.05 *** 0.01) nocons ///
keep (pm*) ci(%7.4f) scalar(converged chi2) eform nonotes

esttab reg_b1_nb reg_b2_nb reg_b3_nb reg_b4_nb using "tables/mexico_a_nb.tex", append label  b(%7.4f) star(* 0.10 ** 0.05 *** 0.01) nocons ///
keep (pm*) ci(%7.4f) scalar(converged chi2) eform nonotes

esttab reg_c1_nb reg_c2_nb reg_c3_nb reg_c4_nb using "tables/mexico_a_nb.tex", append label  b(%7.4f) star(* 0.10 ** 0.05 *** 0.01) nocons ///
keep (pm*) ci(%7.4f) scalar(converged chi2) eform nonotes


