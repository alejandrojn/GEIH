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
local Filas  Bquilla Cartagena Monteria  13Areas  
local Col PTotal  PET PEA Ocupados Desocupados Inactivos %PET  TGP TO  TD  
local NFilas : word count `Filas'
local NCol : word count `Col'
matrix D = J(`NFilas',`NCol',.)
matrix rowname D = `Filas'
matrix colname D = `Col'
matrix list D
******************************************************************
                    *Indicadores Agregados
*****************************************************************
*Total 13 Areas
*Poblacion Total
egen Ptotal=sum(FacTri)
format  Ptotal  %20.10f 
scalar IND41 = Ptotal
display I
*Total ocupados en las 13 Areas Metropolitanas
egen Ocup=sum(FacTri) if REGIS ==60
egen Ocup2=mean(Ocup)
drop Ocup
format  Ocup  %20.10f  
scalar IND44 = Ocup
display Ocup
*total Desocupados de las 13 ciudades
egen Desocup=sum(FacTri) if REGIS ==70
egen Desocup1=mean(Desocup)
drop Desocup
format  Desocup1  %20.10f 
scalar IND45= Desocup1
display Desocup1
*Total Inactivos de las 13 ciudades
egen Inactivos=sum(FacTri) if REGIS ==80
egen Inactivos1=mean(Inactivos)
drop Inactivos
format  Inactivos1  %20.10f 
scalar IND46 =Inactivos1
display Inactivos1
*Total PET de las 13 ciudades
scalar IND42 = IND44+IND45+IND46
display IND42
*Total PEA de las 13 ciudades
scalar IND43 = IND44+IND45
display IND43
*Proporcion PEA
scalar IND47 = IND42/IND41*100
display IND47
*Tasa Global de ParticipaciÃ³n
scalar IND48 = IND43/IND42*100
display IND48
*Tasa de Ocupados
scalar IND49 = IND44/IND42*100
display IND49
*Tasa de desocupados
scalar IND410 = IND45/IND43*100
display IND410
************************************************************
               *Indicadores Barranquilla
************************************************************
/*destring AREA, replace*/ 
*ProblaciÃ³n Total
egen PTB=sum(FacTri) if AREA == 8
egen PTB1=mean(PTB)
drop PTB
format  PTB1  %20.10f 
scalar IND11 = PTB1
display IND11
*total ocupados de Barranquilla
egen Ocupb=sum(FacTri) if REGIS ==60 & AREA == 8
egen Ocupb1=mean(Ocupb)
drop Ocupb
format  Ocupb1  %20.10f  
scalar IND14 = Ocupb1
display IND14
*total Desocupados de Barranquilla
egen Desocupb=sum(FacTri) if REGIS ==70 & AREA == 8
egen Desocupb1=mean( Desocupb)
drop Desocupb
format  Desocupb1  %20.10f 
scalar IND15= Desocupb1
display IND15
*Total Inactivos de Barranquilla
egen Inactivosb=sum(FacTri) if REGIS ==80 & AREA == 8
egen Inactivosb1=mean(Inactivosb)
drop Inactivosb
format  Inactivosb1  %20.10f 
scalar IND16 =Inactivosb1
display IND16
*Total PET de de Barranquilla
scalar IND12 = IND14+IND15+IND16
display IND12
*Total PEA de de Barranquilla
scalar IND13 = IND14+IND15
display IND13
*Proporcion PEA Barranquilla
scalar IND17 = IND12/IND11*100
*Tasa Global de Participacion Barranquilla
scalar IND18 = IND13/IND12*100
*Tasa de Ocupados Barranquilla
scalar IND19 = IND14/IND12*100
*Tasa de desocupados Barranquilla
scalar IND110 = IND15/IND13*100

**************************************************************
                  *Indicadores Cartagena
*************************************************************
*Problacion Total
egen PTC=sum(FacTri) if AREA == 13
egen PTC1=mean(PTC)
drop PTC
format  PTC1  %20.10f 
scalar IND21 = PTC1
display IND21
*total ocupados de Cartagena
egen Ocupc=sum(FacTri) if REGIS ==60 & AREA == 13
egen Ocupc1=mean(Ocupc)
drop Ocupc
format  Ocupc1  %20.10f  
scalar IND24 = Ocupc1
display IND24
*total Desocupados de Cartagena
egen Desocupc=sum(FacTri) if REGIS ==70 & AREA == 13
egen Desocupc1=mean( Desocupc)
drop Desocupc
format  Desocupc1  %20.10f 
scalar IND25= Desocupc1
display IND25
*Total Inactivos de Cartagena
egen Inactivosc=sum(FacTri) if REGIS ==80 & AREA == 13
egen Inactivosc1=mean(Inactivosc)
drop Inactivosc
format  Inactivosc1  %20.10f 
scalar IND26 =Inactivosc1
display IND26
*Total PET de de Cartagena
scalar IND22 = IND24+IND25+IND26
display IND22
*Total PEA de Cartagena
scalar IND23 = IND24+IND25
display IND23
*Proporcion PET Cartagena
scalar IND27 = IND22/IND21*100
*Tasa Global de Participacion Cartagena
scalar IND28 = IND23/IND22*100
*Tasa de Ocupados Cartagena
scalar IND29 = IND24/IND22*100
*Tasa de desocupados Cartagena
scalar IND210 = IND25/IND23*100

*****************************************************************
                 *Indicadores Monteria
***************************************************************
*Problacion Total
egen PTM=sum(FacTri) if AREA == 23
egen PTM1=mean(PTM)
drop PTM
format  PTM1  %20.10f 
scalar IND31 = PTM1
display IND31
*total ocupados de Monteria
egen Ocupm=sum(FacTri) if REGIS ==60 & AREA == 23
egen Ocupm1=mean(Ocupm)
drop Ocupm
format  Ocupm1  %20.10f  
scalar IND34 = Ocupm1
display IND34
*total Desocupados de Monteria
egen Desocupm=sum(FacTri) if REGIS ==70 & AREA == 23
egen Desocupm1=mean( Desocupm)
drop Desocupm
format  Desocupm1  %20.10f 
scalar IND35= Desocupm1
display IND35
*Total Inactivos de Monteria
egen Inactivosm=sum(FacTri) if REGIS ==80 & AREA == 23
egen Inactivosm1=mean(Inactivosm)
drop Inactivosm
format  Inactivosm1  %20.10f 
scalar IND36 =Inactivosm1
display IND36
*Total PET de Monteria
scalar IND32 = IND34+IND35+IND36
display IND32
*Total PEA de Monteria
scalar IND33 = IND34+IND35
display IND33
*ProporciÃ³n PEA
scalar IND37 = IND32/IND31*100
*Tasa Global de Participacion Monteria
scalar IND38 = IND33/IND32*100
*Tasa de Ocupados Monteria
scalar IND39 = IND34/IND32*100
*Tasa de desocupados Monteria
scalar IND310 = IND35/IND33*100

forvalues i = 1/4 {
	forvalues j = 1/10 {
		 matrix D[`i',`j']= IND`i'`j'
	}
}

matrix list D
