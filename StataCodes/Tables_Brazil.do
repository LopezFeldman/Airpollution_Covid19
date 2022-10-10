
**** Program code by Paula Pereda
**** Last update: March 18, 2021
**** Data: Cross-section of Brazilian municipalities
**** Variables: socioecon variables, covid deaths, PM exposure


clear all

use "Brazil_PlosOne.dta"


***************************************************************************
** Table 1 - Brazil  **
***************************************************************************

* Panel A - Brazil
sum cumulative_deaths 

* Panel B - Brazil
sum cumulative_deaths_rate



***************************************************************************
** Table 2 - Brazil  **
***************************************************************************


sum pm2_5



***************************************************************************
** Table 4 - Brazil (Panel I) **
***************************************************************************

global controls1 pop_density ln_hh_inc pop_older65 pop_4564 pop_1544 pop_poverty_1 black native hospital_beds adults_less_than_high_school owner_occup_house days_since_first_case d_diab2_rate d_circ_rate d_respiratory_rate rural_prop 
global controls2 i.uf
global controls3 pop_density pop_older65 pop_4564 pop_1544 hospital_beds adults_less_than_high_school days_since_first_case rural_prop


* Panel A, Column (1) - All municipalities
poisson cumulative_deaths pm2_5 , exposure(population) irr vce(cl uf)
est sto reg1
* Panel A, Column (2) - All municipalities
poisson cumulative_deaths pm2_5 $controls3, exposure(population) irr vce(cl uf)
est sto reg2
* Panel A, Column (3) - All municipalities
poisson cumulative_deaths pm2_5 $controls3 $controls2 , exposure(population) irr vce(cl uf)
est sto reg3
* Panel A, Column (4) - All municipalities
poisson cumulative_deaths pm2_5 $controls1 $controls2 , exposure(population) irr vce(cl uf)
est sto reg4
 
esttab reg1 reg2 reg3 reg4 using "Tab4_BRAZIL_PanelA.tex", eform ci replace label star(* 0.10 ** 0.05 *** 0.01) nocons ///
drop (*uf $controls1 $controls3 _cons) ///
addnote("\begin{minipage}[t]{\columnwidth} \textit{Notes:} This table shows regression estimates of COVID-19 mortality rate on annual PM$_{2.5}$ concentrations averaged from 2000 to 2018. Results are coefficient estimates of Poisson regressions offsetting by population. Metropolitan and rural areas are defined by the Brazilian Institute of Geography and Statistics (IBGE). Clustered standard errors by state in parentheses. Significance levels: $^* p<0.10$, $^{**} p<0.05$, $^{***} p<0.01$. \end{minipage}")

* Panel B, Column (1) - Metropolitan area
poisson cumulative_deaths pm2_5 if metro==1, exposure(population) irr vce(cl uf)
est sto r1
* Panel B, Column (2) - Metropolitan area
poisson cumulative_deaths pm2_5 $controls3 if metro==1, exposure(population) irr vce(cl uf)
est sto r2
* Panel B, Column (3) - Metropolitan area
poisson cumulative_deaths pm2_5 $controls3 $controls2 if metro==1, exposure(population) irr vce(cl uf)
est sto r3
* Panel B, Column (4) - Metropolitan area
poisson cumulative_deaths pm2_5 $controls1 $controls2 if metro==1, exposure(population) irr vce(cl uf) 
est sto r4

esttab r1 r2 r3 r4 using "Tab4_BRAZIL_PanelB.tex", eform ci replace label  star(* 0.10 ** 0.05 *** 0.01) nocons ///
drop (*uf $controls1 $controls3 _cons) ///
addnote("\begin{minipage}[t]{\columnwidth} \textit{Notes:} This table shows regression estimates of COVID-19 mortality rate on annual PM$_{2.5}$ concentrations averaged from 2000 to 2018. Results are coefficient estimates of Poisson regressions offsetting by population. Metropolitan and rural areas are defined by the Brazilian Institute of Geography and Statistics (IBGE). Clustered standard errors by state in parentheses. Significance levels: $^* p<0.10$, $^{**} p<0.05$, $^{***} p<0.01$. \end{minipage}")


* Panel C, Column (1) - Non-Metropolitan Areas
poisson cumulative_deaths pm2_5 if metro==0, exposure(population) irr vce(cl uf)
est sto r_1
* Panel C, Column (2) - Non-Metropolitan Areas
poisson cumulative_deaths pm2_5 $controls3 if metro==0, exposure(population) irr vce(cl uf)
est sto r_2
* Panel C, Column (3) - Non-Metropolitan Areas
poisson cumulative_deaths pm2_5 $controls3 $controls2 if metro==0, exposure(population) irr vce(cl uf)
est sto r_3
* Panel C, Column (4) - Non-Metropolitan Areas
poisson cumulative_deaths pm2_5 $controls1 $controls2 if metro==0, exposure(population) irr vce(cl uf)
est sto r_4

esttab r_1 r_2 r_3 r_4 using "Tab4_BRAZIL_PanelC.tex", eform ci replace label  star(* 0.10 ** 0.05 *** 0.01) nocons ///
drop (*uf $controls1 $controls3 _cons) ///
addnote("\begin{minipage}[t]{\columnwidth} \textit{Notes:} This table shows regression estimates of COVID-19 mortality rate on annual PM$_{2.5}$ concentrations averaged from 2000 to 2018. Results are coefficient estimates of Poisson regressions offsetting by population. Metropolitan and rural areas are defined by the Brazilian Institute of Geography and Statistics (IBGE). Clustered standard errors by state in parentheses. Significance levels: $^* p<0.10$, $^{**} p<0.05$, $^{***} p<0.01$. \end{minipage}")



***************************************************************************
** Table S1 - Brazil  **
***************************************************************************

sum pm2_5_last9y




***************************************************************************
** Table S3 - Panel I Brazil  **
***************************************************************************

global pm pm2_5_last9y 

* Panel A, Column (1) - All municipalities
poisson cumulative_deaths $pm , exposure(population) irr vce(cl uf)
est sto reg1

* Panel A, Column (2) - All municipalities
poisson cumulative_deaths $pm $controls3 , exposure(population) irr vce(cl uf)
est sto reg2

* Panel A, Column (3) - All municipalities
poisson cumulative_deaths $pm $controls3 $controls2 , exposure(population) irr vce(cl uf)
est sto reg3

* Panel A, Column (4) - All municipalities
cap poisson cumulative_deaths $pm $controls1 $controls2 , exposure(population) irr vce(cl uf)
est sto reg4

esttab reg1 reg2 reg3 reg4 using "TableB3_Brazil_PanelA.tex", eform ci replace label  star(* 0.10 ** 0.05 *** 0.01) nocons ///
drop (*uf $controls1 $controls3 _cons) ///
addnote("\begin{minipage}[t]{\columnwidth} \textit{Notes:} This table shows regression estimates of COVID-19 mortality rate on annual PM$_{2.5}$ concentrations averaged from 2000 to 2018. Results are coefficient estimates of Poisson regressions offsetting by population. Metropolitan and rural areas are defined by the Brazilian Institute of Geography and Statistics (IBGE). Clustered standard errors by state in parentheses. Significance levels: $^* p<0.10$, $^{**} p<0.05$, $^{***} p<0.01$. \end{minipage}")


* Panel B, Column (1) - Metropolitan Areas
poisson cumulative_deaths $pm if metro==1, exposure(population) irr vce(cl uf)
est sto r1

* Panel B, Column (2) - Metropolitan Areas
poisson cumulative_deaths $pm $controls3 if metro==1, exposure(population) irr vce(cl uf)
est sto r2

* Panel B, Column (3) - Metropolitan Areas
poisson cumulative_deaths $pm $controls3 $controls2 if metro==1, exposure(population) irr vce(cl uf)
est sto r3

* Panel B, Column (4) - Metropolitan Areas
poisson cumulative_deaths $pm $controls1 $controls2 if metro==1, exposure(population) irr vce(cl uf)
est sto r4

esttab r1 r2 r3 r4 using "TableB3_Brazil_PanelB.tex", eform ci replace label  star(* 0.10 ** 0.05 *** 0.01) nocons ///
drop (*uf $controls1 $controls3 _cons) ///
addnote("\begin{minipage}[t]{\columnwidth} \textit{Notes:} This table shows regression estimates of COVID-19 mortality rate on annual PM$_{2.5}$ concentrations averaged from 2000 to 2018. Results are coefficient estimates of Poisson regressions offsetting by population. Metropolitan and rural areas are defined by the Brazilian Institute of Geography and Statistics (IBGE). Clustered standard errors by state in parentheses. Significance levels: $^* p<0.10$, $^{**} p<0.05$, $^{***} p<0.01$. \end{minipage}")


* Panel C, Column (1) - Non-Metropolitan Areas
poisson cumulative_deaths $pm if metro==0, exposure(population) irr vce(cl uf)
est sto r_1

* Panel C, Column (2) - Non-Metropolitan Areas
poisson cumulative_deaths $pm $controls3 if metro==0, exposure(population) irr vce(cl uf)
est sto r_2

* Panel C, Column (3) - Non-Metropolitan Areas
poisson cumulative_deaths $pm $controls3 $controls2 if metro==0, exposure(population) irr vce(cl uf)
est sto r_3

* Panel C, Column (4) - Non-Metropolitan Areas
poisson cumulative_deaths $pm $controls1 $controls2 if metro==0, exposure(population) irr vce(cl uf)
est sto r_4


esttab r_1 r_2 r_3 r_4 using "TableB3_Brazil_PanelC.tex", eform ci replace label  star(* 0.10 ** 0.05 *** 0.01) nocons ///
drop (*uf $controls1 $controls3 _cons) ///
addnote("\begin{minipage}[t]{\columnwidth} \textit{Notes:} This table shows regression estimates of COVID-19 mortality rate on annual PM$_{2.5}$ concentrations averaged from 2000 to 2018. Results are coefficient estimates of Poisson regressions offsetting by population. Metropolitan and rural areas are defined by the Brazilian Institute of Geography and Statistics (IBGE). Clustered standard errors by state in parentheses. Significance levels: $^* p<0.10$, $^{**} p<0.05$, $^{***} p<0.01$. \end{minipage}")



***************************************************************************
** Table S6 - Panel I Brazil  **
***************************************************************************


* Panel A, Column (1) - All municipalities
nbreg cumulative_deaths pm2_5 , exposure(population) irr vce(cl uf)
est sto reg1

* Panel A, Column (2) - All municipalities
nbreg cumulative_deaths pm2_5 $controls3, exposure(population) irr vce(cl uf)
est sto reg2

* Panel A, Column (3) - All municipalities
nbreg cumulative_deaths pm2_5 $controls3 $controls2 , exposure(population) irr vce(cl uf)
est sto reg3

* Panel A, Column (4) - All municipalities
nbreg cumulative_deaths pm2_5 $controls1 $controls2 , exposure(population) irr vce(cl uf)
est sto reg4

esttab reg1 reg2 reg3 reg4 using "TableB6_Brazil_PanelA.tex", eform ci replace label star(* 0.10 ** 0.05 *** 0.01) nocons ///
drop (*uf $controls1 $controls3 _cons) ///
addnote("\begin{minipage}[t]{\columnwidth} \textit{Notes:} This table shows regression estimates of COVID-19 mortality rate on annual PM$_{2.5}$ concentrations averaged from 2000 to 2018. Results are coefficient estimates of Negative Binomial regressions offsetting by population. Metropolitan and rural areas are defined by the Brazilian Institute of Geography and Statistics (IBGE). Clustered standard errors by state in parentheses. Significance levels: $^* p<0.10$, $^{**} p<0.05$, $^{***} p<0.01$. \end{minipage}")



* Panel B, Column (1) - Metropolitan area
nbreg cumulative_deaths pm2_5 if metro==1, exposure(population) irr vce(cl uf)
est sto r1

* Panel B, Column (2) - Metropolitan area
nbreg cumulative_deaths pm2_5 $controls3 if metro==1, exposure(population) irr vce(cl uf)
est sto r2

* Panel B, Column (3) - Metropolitan area
nbreg cumulative_deaths pm2_5 $controls3 $controls2 if metro==1, exposure(population) irr vce(cl uf)
est sto r3

* Panel B, Column (4) - Metropolitan area
nbreg cumulative_deaths pm2_5 $controls1 $controls2 if metro==1, exposure(population) irr vce(cl uf) 
est sto r4

esttab r1 r2 r3 r4 using "TableB6_Brazil_PanelB.tex", eform ci replace label  star(* 0.10 ** 0.05 *** 0.01) nocons ///
drop (*uf $controls1 $controls3 _cons) ///
addnote("\begin{minipage}[t]{\columnwidth} \textit{Notes:} This table shows regression estimates of COVID-19 mortality rate on annual PM$_{2.5}$ concentrations averaged from 2000 to 2018. Results are coefficient estimates of Negative Binomial regressions offsetting by population. Metropolitan and rural areas are defined by the Brazilian Institute of Geography and Statistics (IBGE). Clustered standard errors by state in parentheses. Significance levels: $^* p<0.10$, $^{**} p<0.05$, $^{***} p<0.01$. \end{minipage}")



* Panel C, Column (1) - Non-Metropolitan area
nbreg cumulative_deaths pm2_5 if metro==0, exposure(population) irr vce(cl uf)
est sto r_1

* Panel C, Column (2) - Non-Metropolitan area
nbreg cumulative_deaths pm2_5 $controls3 if metro==0, exposure(population) irr vce(cl uf)
est sto r_2

* Panel C, Column (3) - Non-Metropolitan area
nbreg cumulative_deaths pm2_5 $controls3 $controls2 if metro==0, exposure(population) irr vce(cl uf)
est sto r_3

* Panel C, Column (4) - Non-Metropolitan area
nbreg cumulative_deaths pm2_5 $controls1 $controls2 if metro==0, exposure(population) irr vce(cl uf)
est sto r_4

esttab r_1 r_2 r_3 r_4 using "TableB6_Brazil_PanelC.tex", eform ci replace label  star(* 0.10 ** 0.05 *** 0.01) nocons ///
drop (*uf $controls1 $controls3 _cons) ///
addnote("\begin{minipage}[t]{\columnwidth} \textit{Notes:} This table shows regression estimates of COVID-19 mortality rate on annual PM$_{2.5}$ concentrations averaged from 2000 to 2018. Results are coefficient estimates of Negative Binomial regressions offsetting by population. Metropolitan and rural areas are defined by the Brazilian Institute of Geography and Statistics (IBGE). Clustered standard errors by state in parentheses. Significance levels: $^* p<0.10$, $^{**} p<0.05$, $^{***} p<0.01$. \end{minipage}")



