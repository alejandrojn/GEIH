clear all
set more off
*******************************************************************
********************************************************************
*Importar datos de la hoja ocupado del archivo Ejemplo4
import excel "C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Ejemplo4\DatosEjemplo4.xls", sheet("Ocupados") firstrow clear

*Colocar etiqueta a la variable TipoContrato
label define ECONTRATO 1 "Verbal" 2 "Escrito"
label values TipoContrato ECONTRATO

*Guardar datos como archivos de STATA (.dta)
save "C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Ejemplo4\Ocup.dta", replace


***********************************************************************
***********************************************************************
*Importar datos de la hoja deocupado del archivo Ejemplo4
import excel "C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Ejemplo4\DatosEjemplo4.xls", sheet("Desocupados") firstrow clear

*Colocar etiqueta a la variable  SubsdioDesem
label define SUBSIDIO 1 "SI" 2 "No"
label values SubsdioDesem SUBSIDIO

*Guardar datos como archivos de STATA (.dta)
save "C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Ejemplo4\Desocupados.dta", replace



***********************************************************************
***********************************************************************
*Importar datos de la hoja inactivos del archivo Ejemplo4
import excel "C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Ejemplo4\DatosEjemplo4.xls", sheet("Inactivos") firstrow clear

*Colocar etiqueta a la variable   CotizaPen
label define COTIZAP 1 "SI" 2 "No"
label values  CotizaPen COTIZAP

*Guardar datos como archivos de STATA (.dta)
save "C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Ejemplo4\Inactivos.dta", replace


************************************************************************
************************************************************************

*Importar datos de la hoja CGen del archivo Ejemplo4
import excel "C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Ejemplo4\DatosEjemplo4.xls", sheet("CGen") firstrow clear

*Guardar datos como archivos de STATA (.dta)
save "C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Ejemplo4\CGen.dta", replace

*********************************************************************
*Fusion Vertical
************************************************************************
*Creacionn de archivo que contiene los casos de ocupados, desocupados e inactivos
use "C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Ejemplo4\Ocup.dta", clear
append using C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Ejemplo4\Desocupados.dta
append using C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Ejemplo4\Inactivos.dta
display _N

**************************************************************************
*Fusion Horizontal Agregar variables generales a los ocupados, desocupados e inactivos
**************************************************************************
merge 1:1  Ident using C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Ejemplo4\CGen.dta
drop  _merge

*Colocar etiqueta a la variable  Sexo
label define GENERO 1 "Hombre" 2 "Mujer"
label values   Sexo GENERO

*************************************
*Tablas y graficos
*************************************
*Tablas 
tab Sexo
table Sexo, row col format(%10.0fc)
table Sexo Edad, row col format(%10.0fc)
tab Sexo if Edad==17
table Sexo if Registro==80, row col format(%10.0fc)
table Sexo if Registro==60, row col format(%10.0fc)
table Sexo if TipoContrato==2, row col format(%10.0fc) 
table Sexo if CotizaPen==1, row col format(%10.0fc)
table Sexo CotizaPen, row col format(%10.0fc)
*Gráfico 
graph pie, over(Sexo) plabel(_all percent, color(white)  size(vlarge))  title("Poblacion  Total Por Genero") caption("Fuente: GEIH")
graph pie, over(Registro) plabel(_all percent, color(white)  size(vlarge))  title("Poblacion  Total Por Genero") caption("Fuente: GEIH")

