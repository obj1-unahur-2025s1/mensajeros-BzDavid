import mensajeros.*

object mensajeria {
    const empleados = []

    const paquetesPendientes = []

    var cantidadFacturada = 0

    method contratarMensajero(mensajero) {
        empleados.add(mensajero)
    }

    method despedirMensajero(mensajero) {
        empleados.remove(mensajero)
    }

    method despedirATodosLosMensajeros() {
        empleados.clear()
    }

    method esGrande() = empleados.size() > 2

    method paquete_PuedeSerEntregadoPorElPrimero(paqueteAEntregar) = paqueteAEntregar.puedeSerEntregadoPor_(empleados.first())

    method pesoDelUltimoMensajero() = empleados.last().peso()

    method primerMensajero() = empleados.first()

    method empleados() = empleados

    method paquete_PuedeSerEntregadoPorAlgunMensajero(paqueteAEntregar) = empleados.any({mensajero => paqueteAEntregar.puedeSerEntregadoPor_(mensajero)}) 

    method cualesMensajerosPuedenEntregarPaquete_(paqueteAEntregar) = empleados.filter({mensajero => paqueteAEntregar.puedeSerEntregadoPor_(mensajero)})

    method tieneSobrepeso() {
	    const pesoTotal = empleados.sum({mensajero => mensajero.peso()})
	    return 500 < (pesoTotal / empleados.size()) 
    }

    method enviarPaquete_(paqueteAEntregar) {
	    if(self.paquete_PuedeSerEntregadoPorAlgunMensajero(paqueteAEntregar)) {
		    cantidadFacturada += paqueteAEntregar.precio()
	    }
	    else {
		    paquetesPendientes.add(paqueteAEntregar)
	    }
    }

    method primerMensajeroQuePuedeEntregarElPaquete_(paqueteAEntregar) = self.cualesMensajerosPuedenEntregarPaquete_(paqueteAEntregar).first()

    method cantidadFacturada() = cantidadFacturada

    method paquetesPendientes() = paquetesPendientes

    method enviarConjuntoDePaquetes_(conjuntoDePaquetes) {
        conjuntoDePaquetes.forEach({paqueteDeLista => self.enviarPaquete_(paqueteDeLista)})
    }

    method enviarElPaqueteMasCaroDeLosPendientes() {
        const paqueteMasCaro = paquetesPendientes.max({pendiente => pendiente.precio()})
        self.enviarPaquete_(paqueteMasCaro)
        paquetesPendientes.remove(paqueteMasCaro)
    }
}