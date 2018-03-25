// Autores:
//   	 	Cristina Betancourt #11-10104
//   	 	Carlos Noria #10-10498
-----------------------------------------------------------------------------------

              INSTALACION SWIFT, COMPILACION Y EJECUCION

-----------------------------------------------------------------------------------
1. Descargar Swift https://swift.org/download/#releases

2. Instalar librerias por terminal (apt-get install clang libicu-dev)

3. Descomprimir Swift (tar -zxvf swift-4.0.3-RELEASE-ubuntu14.04.tar.gz)

4. Copiar los siguientes archivos en el directorio 
   /Swift/swift-4.0.3-RELEASE-ubuntu14.04/usr/bin
      -- ProyectoSwift.swift
      -- prueba.txt

5. Compilar el archivo con el comando ./swiftc ProyectoSwift.swift 

6. Ejecutar el archivo generado con el comando ./ProyectoSwift

** Si da un error de librerias, y es necesario instalar libicu5, instalar el archivo 
adjunto libicu52_52.1-3ubuntu0.7_amd64.deb (64bits) copiando el archivo en el 
directorio /Swift/swift-4.0.3-RELEASE-ubuntu14.04/usr/bin y ejecutando en consola 
el comando sudo dpkg -i libicu52_52.1-3ubuntu0.7_amd64.deb
Luego volver a compilar el proyecto **


--------------------------------------------------------------------------------

                  INSTRUCCIONES PROGRAMA

--------------------------------------------------------------------------------

Al ejecutar el programa la consola le pedira que ingrese el nombre del archivo 
que se va a procesar. Este nombre, al igual que el archivo no debe contener 
caracteres especiales y sin ninguna extensión. La carpeta contiene un archivo 
de prueba llamado "prueba.txt". Presione enter

Posteriormente la consola le pedirá que ingrese la operación que desea realizar
con el archivo. Se muestran tres opciones y debe ingresar el nombre como se muestra
en la pantalla (Ordenar, Palindromo, Filtrar). Mayor explicación en el documento 
Enunciado.pdf

Al finalizar el proceso de archivo, el programa imprimirá en consola el resultado
de la operacion especificada.
