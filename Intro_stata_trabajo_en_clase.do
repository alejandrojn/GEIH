clear
cd /*muestra el directorio actual de trabajo que utiliza el stata*/
dir /*conocer las carpetas que contiene el directorio*/
mkdir /*para crear una nueva carpeta en el directorio de trabajo*/
gen str nombre=""/*crear una variable alpha numerica*/
set obs 1 /* programar primera observación*/
replace nombre = "alejandro" in 1 /*integrar valores alpha numericos a la variable*/
set obs 2
replace nombre = "rafael" in 2
set obs 3
replace nombre = "juan" in 3
gen str apellido=""/*variable alpha numerica de apellido*/
gen byte examen1=. /*crear variable numerica examen1*/
replace examen1 = 17 in 1/*valores primera celda variable numerica*/
replace examen1 = 18 in 2
replace examen1 = 16 in 4
replace examen1 = 18 in 5
gen byte final=./*variable numerica final*/
list /*desplegar la tabla en la ventana de resultados*/
sort apellido/*organizar alfabeticamente la tabla*/
gen ord=_n, before (nombre)/*creando variable ordinal*/
gen promedio=(examen1+final)/2/*creando una variable a partir de una funcion matematica*/
save"C:\Users\USER\OneDrive\Desktop\DiplomadoStata\Ejemplo4\nuevofolder\Matrizejemplo.dta", replace /*guardar matriz de trabajo*/
label var nombre Nombre /*etiquetado variables alpha numericas*/
label var apellido Apellido/*etiquetando la variable apellido*/
gen byte genero=./*variable genero*/
label define sexo 1 Hombre 2 Mujer /*configurar la eiqueta*/
label values genero sexo/*asignando a la variable de interes la etiqueta*/
