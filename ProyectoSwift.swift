/* Universidad Simon Bolivar
   Departamento de Computacion y Tecnologia de la Informacion
   CI-3641  Lenguajes de Programacion
   Enero-Marzo 2018

   Autores:
   	 	Cristina Betancourt #11-10104
   	 	Carlos Noria #10-10498
*/

/* Programa escrito en lenguaje Swift y consiste en leer un archivo que contiene
   una lista de palabras y dada una funcion, crea una lista nueva con las 
   palabras en orden lexicografico, una lista con solo las palabras palindromo o
   una lista sin palabras repetidas
*/


import Foundation

//Variables Globales correspondiente al manejo de archivos
let fileManager = FileManager.default
let sourcePath = URL(fileURLWithPath: fileManager.currentDirectoryPath, 
				     isDirectory: true)


//Clase Operaciones la cual contiene todos los procedimientos de las Operaciones
// que se pueden realizar con el archivo
class Operaciones{
	
	//Funcion recursiva que ordena una lista de Strins de forma lexicografica
	func Ordenar(lista: [String])->[String]{
		
	    if lista.count <= 1 {
	        return lista
	    }

	    let pivote = lista[0]

	    var menor: [String] = []
	    var igual: [String] = []
	    var mayor: [String] = []

	    for x in lista {
	        switch x {
	            case let x where x < pivote:
	                menor.append(x)
	            case let x where x == pivote:
	                igual.append(x)
	            case let x where x > pivote:
	                mayor.append(x)
	            default:
	                break
	        }
	    }

    	return Ordenar(lista: menor)+igual+Ordenar(lista: mayor)
	}

	//Funcion que determina que palabras de una lista son Palindromo y las 
	//guarda en una nueva lista
	func Palindromo(lista: [String])->[String]{

		var palindromos : [String] = []
		 
		//Funcion que convierte todas las letras de una palabra en minusculas y
		//y elimina la tilde de las vocales 
		func NormalizarPalabra(palabra: String) -> String { 
		    return palabra.lowercased()  
		} 
		 
		//Funcion que verifica si una palabra es Palindromo o no 
		func EsPalin(palabra: String) -> Bool { 
		     
		    let nPalabra = NormalizarPalabra(palabra: palabra) 
		     
		    let revCaracteres = nPalabra.reversed() 
		    let revPalabra = String(revCaracteres) 
		    return revPalabra == nPalabra 
		} 
		 
		//Generacion de una nueva lista de palabras que incluye unicamente 
		//aquellas que sean palindromo  
		for palabra in lista where EsPalin(palabra: palabra) { 
		    palindromos.append(palabra) 
		} 

		return palindromos
	}


	//Funcion que elimina las palabras repetidas de una lista de String 
	//generando una nueva lista
	func Filtrar(lista: [String])->[String]{

		var listaFiltrada : [String] = []
		
		for i in 0...lista.count-1{

			if !listaFiltrada.contains(lista[i]){
				listaFiltrada.append(lista[i])
			}
		}

		return listaFiltrada
	}
}

//Clase archivo la cual contiene las funciones necesarias para la lectura y procesamiento 
//del archivo
class Archivo{
	var nombre: String
	var operacion: String
	var lista: [String]
	var resultado: Operaciones

	init(nombre:String, operacion: String, lista:[String] = []){
		self.nombre = nombre
		self.operacion = operacion
		self.lista = lista
		self.resultado = Operaciones()
	}

	//Funcion que llama a la funcion Ordenar de la clase Operaciones
	func Ordenar()->[String]{
		
	    return self.resultado.Ordenar(lista: self.lista)
	}

	//Funcion que llama a la funcion Palindromo de la clase Operaciones
	func Palindromo()->[String]{

		return self.resultado.Palindromo(lista: self.lista)
	}


	//Funcion que llama a la funcion Filtrar de la clase Operaciones
	func Filtrar()->[String]{

		return self.resultado.Filtrar(lista: self.lista)
	}

	//Funcion que lee un archivo y guarda las palabras en un arreglo 
    //eliminando los espacios en blanco, los signos de puntuacion y los
    //saltos de linea
    func LeerArchivo(){

		let nombre = self.nombre + ".txt"
		let separadores = CharacterSet.punctuationCharacters.union(CharacterSet
			.whitespacesAndNewlines)
		
		do {
	    
		    //Obtener el contenido del archivo
		    let archivo = try NSString(contentsOfFile: sourcePath.appendingPathComponent(nombre)
		    	.path, encoding: String.Encoding.utf8.rawValue)

		    //Eliminar espacios, signos de puntuacion y saltos de linea
		    self.lista = archivo.components(separatedBy: separadores)
		    for i in self.lista{
		    	if i == ""{
		    		self.lista.remove(at:self.lista.index(of: "")!)  
		    	}
		    }

		} catch let error as NSError { //En caso de error
	    	
	    	print("\nOoops! Ha ocurrido un error: \(error)\n")

		}catch{

		}
		
	}

	//Funcion que dado el nombre de un archivo y otra funcion, lee el archivo,
	//genera una lista con el contenido y llama a la siguiente funcion
	func Procesar(op: () -> ([String])) -> [String] {
	    
		//Leer el archivo
		self.LeerArchivo()

		//Llamar a la funcion correspondiente
		
		return op()
	}

	//Funcion que verifica la escritura correcta de las funciones y llama al 
	//procedimiento principal
	func Verificar()-> [String]{
		var resultado : [String]

		if self.operacion=="Ordenar"{
			resultado = self.Procesar(op: Ordenar)
		}
		else if operacion == "Palindromo" {
			resultado = self.Procesar(op: Palindromo)			
		}
		else if operacion == "Filtrar"{
			resultado = self.Procesar(op: Filtrar)
		}
		else {
			print("\nNo ingreso una operacion valida. Intente de nuevo\n")
			self.operacion = readLine()!
			resultado = self.Verificar()
		}
		return resultado
	}
	 
}


// MAIN DEL PROGRAMA

//Entrada de nombre del archivo a leer
print("\nPor favor ingrese el nombre del archivo sin la extension .txt y sin comillas \n")

var nomb = readLine()

//Entrada de la operacion a realizar
print("\nPor favor ingrese uno de los siguientes comandos \n\n")
print("     Ordenar : Lee el archivo y entrega una lista de las palabras contenidas en orden lexicografico\n")
print("     Palindromo : Lee el archivo y entrega una lista de las palabras que son palindromo\n")
print("     Filtrar : Lee el archivo y entrega una lista de las palabras contenidas eliminando las que estan repetidas\n")

var funcion = readLine()

var objeto = Archivo(nombre: nomb!,operacion: funcion!) //Instancia de la clase Funciones


//Verificacion y desencadenamiento de las funciones
let resultado = objeto.Verificar()

print("\n----------------------------------------------------------------\n")
print("\nLa lista obtenida de la funcion ",funcion!, " es: \n")
print(resultado)
print("\n")
	