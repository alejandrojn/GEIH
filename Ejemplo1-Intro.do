Título: Ejemplo Introductorio
autor: Alejandro Navarro
fecha:07/09/2021

*************************************************************
          * Ideas básicas de stata
*************************************************************
1. Es un lenguaje de programación
2. Tiene una sintaxis y una gramática que siguen unas reglas que no necesitamos conocer
3. Análisis estadístico descriptivo de bases de datos
4. Modelaciones

************************************************************
          *Datos
************************************************************
1. Pueden entenderse como una colección de valores que pueden ser números caracteres o símbolos.
2. Los datos en sí mismo no son información. Son información si se obtiene de ellos una respuesta a una pregunta.
3. Las personas usan la información para transformarla en conocimiento a partir de la interpretación y la experiencia.

*********************************************************************************
                  *¿Cómo crear datos en stata?
*********************************************************************
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
edit /*Manipular la hoja de cáluclo*/
list /* Observar la tabla*/
sort /*Organizar la tabla orden alfabético de los apellidos*/
gen ord=_n, before(nombre) /*Ordenar númericamente las variables*/
list
gen promedio=(examen1+examen2)/2
save "C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Ejemplo4\Matriz ejemplo.dta", replace
*******************************************************************
                 **Cómo etiquetar variables**
******************************************************************
label var nombre Nombre
label var apellido Apellido
label var ord "No de orden"
label var examen1 "Primer Examen"
label var examen2 "Examen Final"
label var promedio "Nota Final"
label var genero Genero
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
