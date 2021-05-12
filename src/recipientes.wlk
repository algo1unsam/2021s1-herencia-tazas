class Recipiente {

	const property capacidad = 250
	var cantidad = 0

	method cantidad() = cantidad

	method estaLlena() {
		return cantidad >= capacidad
	}

	method agregar(liquido) {
		// TODO: controlar que la taza no rebalse?
		cantidad += liquido
	}

	method tomar() {
		if (cantidad <= 0) {
			throw new DomainException(message= "No hay suficiente líquido para tomar")
		// Es equivalente a
//			self.error("No hay suficiente líquido para tomar")
		}
		cantidad -= 10
		cantidad = cantidad.max(0)
	}

	method realizarMerienda() {
		if (!self.estaLlena()) self.agregar(250)
		5.times({ x => self.tomar() })
		self.vaciar()
	}
	
	method vaciar() // No tiene comportamiento (aka. Método abstracto)

}

// Nunca voy a querer instanciar un recipiente (Clase abstracta)
// Ahora no voy a poder hacerlo porque es una clase incompleta
// const recipiente = new Recipiente()

/////////////////////////////////////
class Vaso inherits Recipiente {

	const material = "vidrio" // Salvo que se indique lo contrario al instanciar, los vasos son de vidrio 

	method esFragil() {
		return material == "vidrio"
	}

	method caer() {
		if (self.esFragil()) {
			cantidad = 0
		}
	}

	method vaciar() {
		cantidad = cantidad.min(1)
	}

}

/////////////////////////////////////
class Taza inherits Recipiente {

	var temperatura // Se debe inicializar al instanciar

	method temperatura() = temperatura

	method pasarElTiempo() {
		temperatura -= 1
	}

	override method estaLlena() {
		return cantidad >= capacidad - 10
	}

	override method tomar() {
		super()
		self.pasarElTiempo()
	}

	method vaciar() {
		cantidad = 0
	}

}

const tazaEspecial = new Taza(temperatura = 15, capacidad = 100)

const pi = 3.14

object tazaCaricatura inherits Taza(temperatura = 20) {

	const nombre = "AAAA"

	method esDivertida() = true

}

/////////////////////////////////////
class Mate inherits Taza {

	method cebar() {
		self.agregar(100) // Asumimos que se ceba de a 100 unidades
	}

	method ronda() {
	// No tenemos el detalle de cómo es una ronda de mate. En otro momento se lo definirá.
	}

	override method estaLlena() {
		return false
	}

}

object pepe {

	var property recipienteEnMano // taza | vaso | mate | tazaCaricatura

	method cargarLiquido() {
		recipienteEnMano.agregar(100) // No hay polimorfismo -> hay solo un único mensaje
	}

	method tirarTodo() {
		recipienteEnMano.vaciar() // Sí hay polimorfismo -> varias formas de resolver esto
	}

}

