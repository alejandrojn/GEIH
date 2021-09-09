clear /*limpiar la memoria*/
set more off /*Comenzar programación*/
cd C:\ /*Directorio de trabajo*/
*Seleccionar base de datos*
use "C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Ejemplo4\Matriz ejemplo.dta"

****************************************************************
           **Cómo generar distintos tipos de variables**
*******************************************************************
gen str nombre=""
gen str apellido=""
gen byte genero=.
gen byte examen1=.
gen byte examen2=.
gen ord=_n, before(nombre)
edit
gen promedio=(examen1+examen2)/2
save "C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Ejemplo4\Matriz ejemplo.dta", replace
*******************************************************************
                 **Cómo etiquetar variables**
******************************************************************
label var nombre Nombre
label var apellido Apellido
label var ord "No de orden"
label var promedio "Nota Final"
label var genero Genero
label var examen1 "Primer Examen"
label var examen2 "Segundo Examen"
*******************************************************************
                 **Añadir etiqueta a la base de datos**
*****************************************************************
label data "Notas de mis estudiantes-Primer Grado

******************************************************************
            **Etiquetas de valor para variables categóricas*
*****************************************************************
label define sexo 1 Hombre 2 Mujer
label list
list
**********************************************************************
               **Asociar la categoria con la variable genero**
*********************************************************************
label values genero sexo
list  
********************************************************************
                 **Tablas de análisis**
********************************************************************
list
summarize examen1 examen2  promedio /*resumen datos numéricos mean, sd, min max*/
by genero, sort : summarize examen1 examen2  promedio/*clasificando por genero*/
table genero
table genero, row col format(%10.0fc)
tabulate genero
table genero promedio, row col format(%10.0fc)
tabulate genero promedio
table genero if promedio==18

********************************************************************
                 *Medidas de tendencia central
********************************************************************
sum examen1
mean examen1
********************************************************************
                  **Análisis grafico***
*******************************************************************
graph bar, over(genero)
graph pie, over(genero)
graph dot, over(examen1), over(examen2)
*******************************************************************
                    *Ajustar las opciones del gráfico*
*******************************************************************
graph pie, over(genero) plabel(_all percent, size(*2.0) color(white)) title("Estudiantes según Genero") caption("Fuente: DANE")
