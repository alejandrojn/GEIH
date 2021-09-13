*********************************************
*Ocupados, Desocupados, Inactivos     *******
*Cuarto trimestre. Año 2017           *******
*Alejandro Navarro                *******
*********************************************
clear
set more off
********************************************************************************
                             *Descarga de datos
*********************************************************************************
*Descargar los microdatos de la página del DANE:
*http://microdatos.dane.gov.co/index.php/catalog/MICRODATOS/about_collection/23/1*
*Seleccionar el archivo GEIH 2017 en los siguientres formatos:
*octubre.dta, noviembre.dta, diciembre.dta
*También se pueden importar los datos en otro formato:
*octubre.txt, noviembre.txt y diciembre.txt*
*Crear una carpeta y luego guardar en el directorio C:\...\GEIH\guardar carpetas
*Primero veremos como cargar los archivos .txt en stata y cómo guardarlos en formato . dta
*Segundo, a partir de los archivos en formato .dta fusinaremos verticalmente
*Tercero, fusionaremos horizontalmente para crear una única base de datos
*Cuarto, haremos análisis descriptivo de los datos 
*como se muestra a continuación*
*********************************************************************************
*                             Importe de datos
*********************************************************************************
*Área - Características generales (Personas) = ACaragen
*Área - Desocupados = AOcu
*Área - Inactivos = AInac
*Área - Ocupados = ADesocu

*Archivo Caracteristicas Generales (Juntar octubre, noviembre y diciembre)
import delimited "C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Archivos txt\Diciembre.txt\Área - Características generales (Personas).txt", clear
save "C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Archivosdta\Diciembre\ACaGe.dta", replace
*Noviembre
import delimited "C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Archivos txt\Noviembre.txt\Área - Características generales (Personas).txt", clear
save "C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Archivosdta\Noviembre\ACaGe.dta", replace
*octubre
import delimited "C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Archivos txt\Octubre.txt\Área - Características generales (Personas).txt", clear
save "C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Archivosdta\Octubre\ACaGe.dta", replace

******************************************************************************
*Fusión vertical de arcgivos. Agregar observaciones o casos (IV Trimestre de 2017)
**************************************************************************
*agregar noviembre y octubre características generales
use "C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Archivosdta\Diciembre.dta\ACaragen.dta", clear
sum /*Resumen estadístico*/
append using C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Archivosdta\Noviembre.dta\ACaragen.dta 
append using C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Archivosdta\Octubre.dta\ACaragen.dta
display _N
egen LLAVE=concat(DIRECTORIO  SECUENCIA_P ORDEN)
destring LLAVE, replace
sort LLAVE
save "C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Archivosdta\Agregados\ACaGe.dta", replace

********************************************************************************
*agregar noviembre y octubre ocupados a diciembre
********************************************************************************

use "C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Archivosdta\Diciembre.dta\AOcu.dta", clear
append using C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Archivosdta\Noviembre.dta\AOcu.dta
append using C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Archivosdta\Octubre.dta\AOcu.dta
display _N
egen LLAVE=concat( DIRECTORIO  SECUENCIA_P ORDEN)
destring LLAVE, replace
sort LLAVE
save  "C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Archivosdta\Agregados\AOc.dta", replace

**********************************************************************
*agregar noviembre y octubre desocupados a diciembre
****************************************************************
use "C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Archivosdta\Diciembre.dta\ADesocu.dta", clear
append using  C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Archivosdta\Noviembre.dta\ADesocu.dta
append using  C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Archivosdta\Octubre.dta\ADesocu.dta
display _N
egen LLAVE=concat( DIRECTORIO  SECUENCIA_P ORDEN)
destring LLAVE, replace
sort LLAVE
save "C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Archivosdta\Agregados\ADe.dta", replace

**********************************************************************
*agregar noviembre y octubre inactivos diciembre
*********************************************************************
use "C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Archivosdta\Diciembre.dta\AInac.dta", clear
append using  C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Archivosdta\Noviembre.dta\AInac.dta
append using  C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Archivosdta\Octubre.dta\AInac.dta
display _N
egen LLAVE=concat( DIRECTORIO  SECUENCIA_P ORDEN)
destring LLAVE, replace
sort LLAVE
save "C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Archivosdta\Agregados\AIn.dta", replace

**************************************************************************
*Fusión horizontal Agregar variables generales a los ocupados, desocupados e inactivos
**************************************************************************
use "C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Archivosdta\Agregados\AOc.dta", clear
*agregar observaciones
append using C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Archivosdta\Agregados\AIn.dta
append using C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Archivosdta\Agregados\ADe.dta
merge 1:1 LLAVE using C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Archivosdta\Agregados\ACaGe.dta
*******************************************************************
       *Transformación y organización de los datos
*******************************************************************
*Convertir variables de cadena en  variables numericas
destring REGIS, replace
destring AREA, replace
*Generacion de la variable del factor expansion (Fex2) para el analisis de trimestre
gen fex2= round(fex_c_2011/3,4)
*Recodificar variables (crear etiquetas). 
*Asignar el nombre de cada Area metropolitana segun el codigo que registra la encuesta.
recode AREA  (11=0 "Bogotá")   (5=1 "MedellÃ­n")  (76=2 "Cali")   (8=3 "Barranquilla") (68=4 "Bucaramanga")  (17=5 "Manizales")  (52=6 "Pasto")  (66=7 "Pereira")  (54=8 "CÃºcuta") (73=9 "IbaguÃ©")   (23=10 "MonterÃ­a")  (13=11 "Cartagena")  (50=12 "Villavicencio"), into(AREAR)

********************************************************************
                      *Generacion de tabla descriptivas
********************************************************************
*Tabla de frecuencia variables categóricas
tab REGIS [fw=fex2]
tab REGIS P6020, row col 
tab REGIS P6020 [fw=fex2], row col
tab REGIS [fw=fex2] if REGIS==60 /*verificar en anexo del DANE en excel*/
tab AREAR REGIS [fw=fex2] if AREA==8
tab AREAR [fw=fex2] if REGIS==60 /*verificar en anexo del DANE en excel*/
*Total poblacion de las 13 Area metropolitanas  segun genero 
table AREAR  P6020 [fw=fex2], row col format(%10.0fc)
*Total ocupados de las 13 Area metropolitanas  segun genero 
table AREAR  P6020 [fw=fex2] if REGIS==60, row col format(%10.0fc)
*Total ocupados de las 13 Area metropolitanas  segun genero parentesco
table AREAR  P6050 [fw=fex2] if REGIS==60, row col format(%10.0fc)
*Total Desocupados de las 13 Area metropolitanas  segun genero 
table AREAR  P6020 [fw=fex2] if REGIS==70, row col format(%10.0fc)
*Total inactivos de las 13 Area metropolitanas  segun genero 
table AREAR  P6020 [fw=fex2] if REGIS==80, row col format(%10.0fc)

***************************************************************************
                        *Generacion de Graficos. 
***************************************************************************
*Total poblaciÃ³n de las 13 Area metropolitanas  segÃºn gÃ©nero 
graph pie fex2, over(P6020) plabel(_all percent, color(white)  size(vlarge))  title("PoblaciÃ³n  Total Por GÃ©nero") caption("Fuente: GEIH")  
*Total Ocupados de las 13 Area metropolitanas  segÃºn gÃ©nero
graph pie fex2 if REGIS==60, over(P6020)  plabel(_all percent, color(white)  size(vlarge)) title("PoblaciÃ³n Ocupada Por GÃ©nero") caption("Fuente: GEIH")  
*Total Desocupados de las 13 Area metropolitanas  segÃºn gÃ©nero
graph pie fex2 if REGIS==70, over(P6020)  plabel(_all percent, color(white)  size(vlarge)) title("PoblaciÃ³n  Desocupada Por GÃ©nero") caption("Fuente: GEIH")  
*Total Inactivos de las 13 Area metropolitanas  segÃºn gÃ©nero
graph pie fex2 if REGIS==80, over(P6020)  plabel(_all percent, color(white)  size(vlarge)) title("PoblaciÃ³n  Inactiva Por GÃ©nero") caption("Fuente: GEIH")
*Total Ocupados de las 13 Area metropolitanas segÃºn tipo de empleo
table AREAR  P6430 [fw=fex2], row col format(%10.0fc)

*********************************************************************************
*Introduccion de condicionales a partir de nuevas variables
********************************************************************************
*Poblacion Ocupada por rama de actividad en cada Area metropolitanarepla
********************************************************************************
*Generacion de la variable RAMAACT. A cada rama de actiividad se le crea un cÃ³digo segÃºn los datos de la variable RAMA2D
gen RAMAACT = 0
destring RAMA2D, replace
replace RAMAACT = 1 if RAMA2D >= 1 & RAMA2D <= 5 /* Agropecuario */
replace RAMAACT = 2 if RAMA2D >= 10 & RAMA2D <= 14 /* Minas */
replace RAMAACT = 3 if RAMA2D >= 15 & RAMA2D <= 37 /* Industrial */
replace RAMAACT = 4 if RAMA2D >= 40 & RAMA2D <= 41 /* Electricidad */
replace RAMAACT = 5 if RAMA2D == 45 /* Construccion */
replace RAMAACT = 6 if RAMA2D >= 60 & RAMA2D <= 64 /* Transporte */
replace RAMAACT = 7 if RAMA2D >= 65 & RAMA2D <= 67 /* Int Financieran */
replace RAMAACT = 8 if RAMA2D >= 70 & RAMA2D <= 74 /* Act Inmobiliarias */
replace RAMAACT = 9 if RAMA2D >= 75 & RAMA2D <= 99 /* S comun, soc y pers */
replace RAMAACT = 10 if RAMA2D >= 50 & RAMA2D <= 55 /* Comercio */
replace RAMAACT = 11 if RAMA2D == 0 /* NI */

*Recodificar variables (crear etiquetas). Asignar el nombre de la actividad segun los  codigo creados en la variable RAMAACT.
label define origin 1 "Agropecuarias" 2 "Minas" 3 "Industrial" 4 "Elect." 5 "Const." 6 "Transp." 7 "Financieras" 8 "Inmoboliarias" 9 "Comunales" 10 "Comercio" 11 "NI"
label values RAMAACT origin
replace RAMAACT = . if RAMAACT ==0
*********************************************************************
*Generacion de tabla por ramas de actividad 
*********************************************************************
*Total Ocupados por Rama de Actividad de las 13 Area metropolitanas 
table AREAR  RAMAACT [fw=fex2], row col format(%10.0fc) 
*Total Ocupados Por Rama de Actividad de las 13 Area metropolitanas  segun genero 
table AREAR  P6020 RAMAACT  [fw=fex2], row col format(%10.0fc) 
*Participacion de los Ocupados Por Rama de Actividad de las 13 Area metropolitanas  segun genero 
tab AREAR  RAMAACT [fw=fex2], nofreq row

********************************************************************************
*Poblacion Ocupada, Desocupada e Inactiva por edadaes de cada Area metropolitanarepla
********************************************************************************
*Generacion de la variable REDAD. A cada rango de edad se le crea un codigo segun los datos de la variable P6040
rename P6040 EDAD
gen byte Ran_EDAD = 1 if EDAD >= 0 & EDAD <= 11
replace Ran_EDAD = 2 if EDAD >= 12 & EDAD <= 29
replace Ran_EDAD = 3 if EDAD >= 30 & EDAD <= 65
replace Ran_EDAD = 4 if EDAD >= 66 & EDAD <= 110
tab Ran_EDAD
*Recodificar variables (crear etiquetas). Asignar a cada codigo de la variable REDAD una categoria.
label define rango_edad 1 "Niños" 2 "Joven" 3 "Adulto" 4 "Adulto Mayor" 
label values Ran_EDAD rango_edad
tab Ran_EDAD [fw=fex2]
*Generacion de tabla. 
*Poblacion total por  rango de edad de las 13 Area metropolitanas
table AREAR  Ran_EDAD [fw=fex2], row col format(%10.0fc) 
*Participacion de ls Poblacion total por  rango de edad de las 13 Area metropolitanas
tab AREAR  Ran_EDAD [fw=fex2],  nofreq row 
*Participacion de ls Poblacion total por  rango de edad de las 13 Area metropolitanas
tab AREAR  Ran_EDAD [fw=fex2],  nofreq col  
*Ocupados por  rango de edad de las 13 Area metropolitanas
table AREAR  Ran_EDAD [fw=fex2] if REGIS ==60, row col format(%10.0fc) 
*Desocupados por  rango de edad de las 13 Area metropolitanas
table AREAR  Ran_EDAD [fw=fex2] if REGIS ==70, row col format(%10.0fc)
*Inactivos por  rango de edad de las 13 Area metropolitanas
table AREAR  Ran_EDAD [fw=fex2] if REGIS ==80, row col format(%10.0fc)

*********************************************************************************************
*Generacion de la variable Nsalario la cual organiza la poblaciion por rango de salario 
*********************************************************************************************
gen Nsalario = 0
replace Nsalario = 1 if INGLABO  < 737717 
replace Nsalario = 2 if INGLABO  >= 737717 & INGLABO  < 2950868
replace Nsalario = 3 if INGLABO  >= 2950868 & INGLABO  < 5901736
replace Nsalario = 4 if INGLABO  >= 5901736 & INGLABO  < 8852604
replace Nsalario = 5 if INGLABO  >= 8852604

*Recodificar variables (crear etiquetas). Asignar a cada codigo de la variable Nsalario una categoria
label define origin3 1 "<SMLV" 2 "1-4SMLV" 3 "4-8SMLV" 4 "8-12SMLV" 5 ">12SMLV"  
label values Nsalario origin3
*Ocupados segun salarios minimos recibidos (13 Area metropolitanas)
table AREAR  Nsalario [fw=fex2] if REGIS ==60, row col format(%10.0fc) 
*Participacion ocupados segun salarios minimos recibidos (13 Area metropolitanas)
tab AREAR  Nsalario [fw=fex2] if REGIS ==60, nofreq row 

*******************************************************************************************+
                    *Indicadores Mercado de trabajo
***********************************************************************************
*PT
tab PT
tab Ran_EDAD [fw=fex2] /*verificar en anexo del DANE en excel*/
gen PT = Ran_EDAD
label values PT rango_edad
tab PT [fw=fex2]
sort PT
*PET
gen PET = EDAD if EDAD >=12 & EDA<=110
tab PET
tab PET [fw=fex2] /*verificar en anexo del DANE en excel*/
*PEA 
gen PEA = REGIS
recode PEA 60/70 = 90
tab PEA if PEA==90
tab PEA [fw=fex2] if PEA==90 /*verificar en anexo del DANE en excel*/
/*drop if PEA!=90*/
tab PEA [fw=fex2]
*Ocupados
tab REGIS if REGIS==60 
tab REGIS [fw=fex2] if REGIS==60
egen Ocupados =rowtotal(REGIS) if REGIS==60, miss
tab Ocupados [fw=fex2]
egen TO =group(Ocupados/PET)
*Desocupados
tab REGIS if REGIS==70
tab REGIS [fw=fex2] if REGIS==70
*Inactivos
tab REGIS [fw=fex2] if REGIS==80
******************************************************************


