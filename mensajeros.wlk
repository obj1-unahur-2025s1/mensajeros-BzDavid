//Personas ------------------------------------------
object roberto {
  var vehiculo = bicicleta

  method peso() = vehiculo.peso() + 90

  method puedeLlamar() = false

  method cambiarVehiculo(vehiculoNuevo) {
    vehiculo = vehiculoNuevo
  }
}

object chuckNorris {
  method peso() = 80

  method puedeLlamar() = true 
}

object neo {
  var puedeLlamar = true

  method peso() = 0

  method puedeLlamar() = puedeLlamar

  method cambiarSiPuedeLlamar() {
    puedeLlamar = not puedeLlamar
  }
}

object flash {
  var velocidad = 1000

  method peso() = if(velocidad > 500) 0 else 100

  method puedeLlamar() = velocidad > 500

  method cansarse() {
    velocidad = velocidad - 100
  }

  method restablecerVelocidad() {
    velocidad = 1000
  }
}

//Destinos -------------------------------------------
object puenteDeBrooklyn {
  method puedeEntrar(personaje) = personaje.peso() <= 1000
}

object laMatrix {
  method puedeEntrar(personaje) = personaje.puedeLlamar()
}

//Vehiculos ------------------------------------------
object bicicleta {
  method peso() = 5 
}

object camion {
  var cantidadDeAcoplados = 1

  method peso() = cantidadDeAcoplados * 500

  method agregarUnAcoplado() {
    cantidadDeAcoplados = cantidadDeAcoplados + 1
  }

  method quitarUnAcoplado() {
    cantidadDeAcoplados = cantidadDeAcoplados - 1
  }
}

//Paquetes ------------------------------------------
object paquetito {
  var destino = puenteDeBrooklyn

  method estaPago() = true

  method precio() = 0

  method cambiarDestino(nuevoDestino) {
    destino = nuevoDestino
  }

  method puedeSerEntregadoPor_(mensajero) = destino.puedeEntrar(mensajero) and self.estaPago()
}

object paquete {
  var destino = puenteDeBrooklyn

  var estaPago = true

  method precio() = 50

  method estaPago() = estaPago 

  method cambiarSiEstaPago() {
    estaPago = not estaPago
  }

  method cambiarDestino(nuevoDestino) {
    destino = nuevoDestino
  }

  method puedeSerEntregadoPor_(mensajero) = destino.puedeEntrar(mensajero) and self.estaPago()
}

object paquetonViajero { 
  const destino = [puenteDeBrooklyn, laMatrix]

  var cantidadPagada = 0

  method agregarUnDestino(nuevoDestino) {
    destino.add(nuevoDestino)
  }

  method quitarUnDestino(nuevoDestino) {
    destino.remove(nuevoDestino)
  }

  method destino() = destino

  method estaPago() = cantidadPagada >= self.precio()

  method precio() = 100 * destino.size()

  method cambiarCantidadPagada(nuevaCantidad) {
    cantidadPagada = nuevaCantidad
  }

  method pagarLaMitad() {
    self.cambiarCantidadPagada(cantidadPagada + 50 * destino.size())
  }

  method reducirPagoALaMitad() {
    self.cambiarCantidadPagada(cantidadPagada - 50 * destino.size())
  }

  method puedeSerEntregadoPor_(mensajero) = destino.all({unDestino => unDestino.puedeEntrar(mensajero)}) and self.estaPago()

}

object paquetePolimorfico {
  var quePaqueteEs = paquetito

  method estaPago() = quePaqueteEs.estaPago()

  method precio() = quePaqueteEs.precio()

  method cambiarQuePaqueteEs(nuevoPaquete) {
    quePaqueteEs = nuevoPaquete
  }

  method puedeSerEntregadoPor_(mensajero) = quePaqueteEs.puedeSerEntregadoPor_(mensajero)
}
