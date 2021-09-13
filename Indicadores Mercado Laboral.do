*******************************************************************************************+
                    *Indicadores Mercado de trabajo
***********************************************************************************
clear
use "C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Archivosdta\Agregados\AOc.dta", clear
*agregar observaciones
append using C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Archivosdta\Agregados\AIn.dta
append using C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Archivosdta\Agregados\ADe.dta
merge 1:1 LLAVE using C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Archivosdta\Agregados\ACaGe.dta
gen FacTri=fex_c_2011/3
destring REGIS, replace
destring AREA, replace

****************************************************************
             *Estructura de la matriz de indicadores
****************************************************************
local Filas Tareas Bquilla Cartagena MonterÃ­a  
local Col  PropPET  TGP TOCUP TDESEM PT PET PEA OCUPADOS DESOCUPADOS 
local NFilas : word count `Filas'
local NCol : word count `Col'
matrix D = J(`NFilas',`NCol',.)
matrix rowname D = `Filas'
matrix colname D = `Col'
matrix list D

******************************************************************
                    *Indicadores Agregados
*****************************************************************
*Total por Area
*PT
egen PT=sum (FacTri)
format PT %20.10f
scalar PT2 = PT
display PT2
*Total ocupados en las 13 Areas Metropolitanas
egen Ocup=sum(FacTri) if REGIS ==60
egen Ocup2=mean(Ocup)
drop Ocup
format  Ocup  %20.10f  
scalar Ocup2 = Ocup
display Ocup2
*total Desocupados de las 13 ciudades
egen Desocup=sum(FacTri) if REGIS ==70
egen Desocup1=mean(Desocup)
drop Desocup
format  Desocup1  %20.10f 
scalar Deso2= Desocup
display Desocup1
*Total Inactivos de las 13 ciudades
egen Inactivos=sum(FacTri) if REGIS ==80
egen Inactivos1=mean(Inactivos)
drop Inactivos
format  Inactivos1  %20.10f 
display Inactivos1
*Total PET de las 13 ciudades
scalar PET = Ocup2+Deso2+Inactivos1
display PET
*Total PEA de las 13 ciudades
scalar PEA = Ocup2+Deso2
display PEA
*Proporcion PET
matrix D[1,1] = PET/PT2*100
*Tasa Global de ParticipaciÃ³n
matrix D[1,2] = PEA/PET*100
*Tasa de Ocupados
matrix D[1,3] = Ocup2/PET*100
*Tasa de desocupados
matrix D[1,4] = Deso2/PEA*100
*PoblaciÃ³n Total
matrix D[1,5] = PT2
*PET
matrix D[1,6] = PET
*PEA
matrix D[1,7] = PEA
*Ocupados
matrix D[1,8] = Ocup2
*Desocupados
matrix D[1,9] = Deso2
matrix list D

************************************************************
               *Indicadores Barranquilla
************************************************************
/*destring AREA, replace*/ 
*ProblaciÃ³n Total
egen PTB=sum(FacTri) if AREA == 8
egen PTB1=mean(PTB)
drop PTB
format  PTB1  %20.10f 
scalar PTB2 = PTB1
display PTB1
*total ocupados de Barranquilla
egen Ocupb=sum(FacTri) if REGIS ==60 & AREA == 8
egen Ocupb1=mean(Ocupb)
drop Ocupb
format  Ocupb1  %20.10f  
scalar Ocupb2 = Ocupb1
display Ocupb2
*total Desocupados de Barranquilla
egen Desocupb=sum(FacTri) if REGIS ==70 & AREA == 8
egen Desocupb1=mean( Desocupb)
drop Desocupb
format  Desocupb1  %20.10f 
scalar Desocupb2= Desocupb1
display Desocupb2
*Total Inactivos de Barranquilla
egen Inactivosb=sum(FacTri) if REGIS ==80 & AREA == 8
egen Inactivosb1=mean(Inactivosb)
drop Inactivosb
format  Inactivosb1  %20.10f 
scalar Inactivosb2 =Inactivosb1
display Inactivosb2
*Total PET de de Barranquilla
scalar PETb = Ocupb2+Desocupb2+Inactivosb2
display PETb
*Total PEA de de Barranquilla
scalar PEAb = Ocupb2+Desocupb2
display PEAb
*Proporcion PET
matrix D[2,1] = PETb/Ptotalb2*100
*Tasa Global de ParticipaciÃ³n
matrix D[2,2] = PEAb/PETb*100
*Tasa de Ocupados
matrix D[2,3] = Ocupb2/PETb*100
*Tasa de desocupados
matrix D[2,4] = Desocupb2/PEAb*100
*PoblaciÃ³n Total
matrix D[2,5] = PTB2
*PET
matrix D[2,6] = PETb
*PEA
matrix D[2,7] = PEAb
*Ocupados
matrix D[2,8] = Ocupb2
*Desocupados
matrix D[2,9] = Desocupb2

matrix list D

**************************************************************
                  *Indicadores Cartagena
*************************************************************
*Problacion Total
egen PTC=sum(FacTri) if AREA == 13
egen PTC1=mean(PTC)
drop PTC
format  PTC1  %20.10f 
scalar PTC2 = PTC1
display PTC1
*total ocupados de Cartagena
egen Ocupc=sum(FacTri) if REGIS ==60 & AREA == 13
egen Ocupc1=mean(Ocupc)
drop Ocupc
format  Ocupc1  %20.10f  
scalar Ocupc2 = Ocupc1
display Ocupc2
*total Desocupados de Cartagena
egen Desocupc=sum(FacTri) if REGIS ==70 & AREA == 13
egen Desocupc1=mean( Desocupc)
drop Desocupc
format  Desocupc1  %20.10f 
scalar Desocupc2= Desocupc1
display Desocupc2
*Total Inactivos de Cartagena
egen Inactivosc=sum(FacTri) if REGIS ==80 & AREA == 13
egen Inactivosc1=mean(Inactivosc)
drop Inactivosc
format  Inactivosc1  %20.10f 
scalar Inactivosc2 =Inactivosc1
display Inactivosc2
*Total PET de de Cartagena
scalar PETc = Ocupc2+Desocupc2+Inactivosc2
display PETc
*Total PEA de Cartagena
scalar PEAc = Ocupc2+Desocupc2
display PEAc
*ProporciÃ³n PEA
matrix D[3,1] = PETc/Ptotalc2*100
*Tasa Global de ParticipaciÃ³n
matrix D[3,2] = PEAc/PETc*100
*Tasa de Ocupados
matrix D[3,3] = Ocupc2/PETc*100
*Tasa de desocupados
matrix D[3,4] = Desocupc2/PEAc*100
*PoblaciÃ³n Total
matrix D[3,5] = PTC2
*PET
matrix D[3,6] = PETc
*PEA
matrix D[3,7] = PEAc
*Ocupados
matrix D[3,8] = Ocupc2
*Desocupados
matrix D[3,9] = Desocupc2

matrix list D

*****************************************************************
                 *Indicadores Monteria
***************************************************************
*Problacion Total
egen PTM=sum(FacTri) if AREA == 23
egen PTM1=mean(PTM)
drop PTM
format  PTM1  %20.10f 
scalar PTM2 = PTM1
display PTM1
*total ocupados de Monteria
egen Ocupm=sum(FacTri) if REGIS ==60 & AREA == 23
egen Ocupm1=mean(Ocupm)
drop Ocupm
format  Ocupm1  %20.10f  
scalar Ocupm2 = Ocupm1
display Ocupm2
*total Desocupados de Monteria
egen Desocupm=sum(FacTri) if REGIS ==70 & AREA == 23
egen Desocupm1=mean( Desocupm)
drop Desocupm
format  Desocupm1  %20.10f 
scalar Desocupm2= Desocupm1
display Desocupm2
*Total Inactivos de Monteria
egen Inactivosm=sum(FacTri) if REGIS ==80 & AREA == 23
egen Inactivosm1=mean(Inactivosm)
drop Inactivosm
format  Inactivosm1  %20.10f 
scalar Inactivosm2 =Inactivosm1
display Inactivosm2
*Total PET de Monteria
scalar PETm = Ocupm2+Desocupm2+Inactivosm2
display PETm
*Total PEA de Monteria
scalar PEAm = Ocupm2+Desocupm2
display PEAm
*ProporciÃ³n PEA
matrix D[4,1] = PETm/Ptotalm2*100
*Tasa Global de ParticipaciÃ³n
matrix D[4,2] = PEAm/PETm*100
*Tasa de Ocupados
matrix D[4,3] = Ocupm2/PETm*100
*Tasa de desocupados
matrix D[4,4] = Desocupm2/PEAm*100
*PoblaciÃ³n Total
matrix D[4,5] = PTM2
*PET
matrix D[4,6] = PETm
*PEA
matrix D[4,7] = PEAm
*Ocupados
matrix D[4,8] = Ocupm2
*Desocupados
matrix D[4,9] = Desocupm2

matrix list D
