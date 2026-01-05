!classDefinition: #MarsRover category: #MarsRover!
Object subclass: #MarsRover
	instanceVariableNames: 'posicion direccion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'publico' stamp: 'max'!
direccionCardinal
	^direccion! !

!MarsRover methodsFor: 'publico' stamp: 'max'!
posicion
	^posicion! !

!MarsRover methodsFor: 'publico' stamp: 'max'!
realizarAccion: unaSecuenciaDeComandos
	
	unaSecuenciaDeComandos do: [:unComando |
			(unComando = $f) ifTrue: [ self avanzar ].
			(unComando = $b) ifTrue: [ self retroceder ].
			(unComando = $r) ifTrue: [ self rotar90GradosDerecha ].
			(unComando = $l) ifTrue: [ self rotar90GradosIzquierda ].
			(unComando ~= $f and: unComando ~= $b and: unComando ~= $r and: unComando ~= $l) ifTrue: [ self error: self class errorComandoInvalido. ]
			].
	^#Recibido.! !


!MarsRover methodsFor: 'movimiento' stamp: 'max'!
avanzar
	posicion := posicion + direccion comoVersor.
! !

!MarsRover methodsFor: 'movimiento' stamp: 'max'!
initialize
	posicion := 0@0.
	direccion := DireccionNorte new.! !

!MarsRover methodsFor: 'movimiento' stamp: 'max'!
retroceder
	posicion := posicion - direccion comoVersor.
! !

!MarsRover methodsFor: 'movimiento' stamp: 'max'!
rotar90GradosDerecha
	direccion := direccion girar90GradosALaDerecha.
! !

!MarsRover methodsFor: 'movimiento' stamp: 'max'!
rotar90GradosIzquierda
	direccion := direccion girar90GradosALaIzquierda.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #MarsRover!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'errores' stamp: 'max'!
errorComandoInvalido
	^'Comando es Invalido: Se detendra la ejecucion de proximos comandos!!'! !


!classDefinition: #SistemaDireccionalRover category: #MarsRover!
Object subclass: #SistemaDireccionalRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!SistemaDireccionalRover methodsFor: 'acceso' stamp: 'max'!
comoVersor
	self subclassResponsibility ! !

!SistemaDireccionalRover methodsFor: 'acceso' stamp: 'max'!
girar90GradosALaDerecha

	self subclassResponsibility ! !

!SistemaDireccionalRover methodsFor: 'acceso' stamp: 'max'!
girar90GradosALaIzquierda

	self subclassResponsibility ! !


!classDefinition: #DireccionEste category: #MarsRover!
SistemaDireccionalRover subclass: #DireccionEste
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!DireccionEste methodsFor: 'acceso' stamp: 'max'!
comoVersor
	^(1@0)! !

!DireccionEste methodsFor: 'acceso' stamp: 'max'!
girar90GradosALaDerecha

	^DireccionSur new! !

!DireccionEste methodsFor: 'acceso' stamp: 'max'!
girar90GradosALaIzquierda

	^DireccionNorte new! !


!classDefinition: #DireccionNorte category: #MarsRover!
SistemaDireccionalRover subclass: #DireccionNorte
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!DireccionNorte methodsFor: 'acceso' stamp: 'max'!
comoVersor
	^(0@1)! !

!DireccionNorte methodsFor: 'acceso' stamp: 'max'!
girar90GradosALaDerecha

	^DireccionEste new! !

!DireccionNorte methodsFor: 'acceso' stamp: 'max'!
girar90GradosALaIzquierda

	^DireccionOeste new! !


!classDefinition: #DireccionOeste category: #MarsRover!
SistemaDireccionalRover subclass: #DireccionOeste
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!DireccionOeste methodsFor: 'acceso' stamp: 'max'!
comoVersor
	^(-1@0)! !

!DireccionOeste methodsFor: 'acceso' stamp: 'max'!
girar90GradosALaDerecha

	^DireccionNorte new! !

!DireccionOeste methodsFor: 'acceso' stamp: 'max'!
girar90GradosALaIzquierda

	^DireccionSur new! !


!classDefinition: #DireccionSur category: #MarsRover!
SistemaDireccionalRover subclass: #DireccionSur
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!DireccionSur methodsFor: 'acceso' stamp: 'max'!
comoVersor
	^(0@-1)! !

!DireccionSur methodsFor: 'acceso' stamp: 'max'!
girar90GradosALaDerecha

	^DireccionOeste new! !

!DireccionSur methodsFor: 'acceso' stamp: 'max'!
girar90GradosALaIzquierda

	^DireccionEste new! !


!classDefinition: #MarsRoverTests category: #MarsRover!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTests methodsFor: 'Tests - Rotacion' stamp: 'max'!
test07RoverRota90GradosALaDerecha
	| rover |
	rover := MarsRover new.
	rover realizarAccion: 'r'.
	self assert: (rover direccionCardinal class) = DireccionEste.
	! !

!MarsRoverTests methodsFor: 'Tests - Rotacion' stamp: 'max'!
test08RoverRota180GradosALaDerecha
	| rover |
	rover := MarsRover new.
	rover realizarAccion: 'rr'.
	self assert: (rover direccionCardinal class) = DireccionSur .
	! !

!MarsRoverTests methodsFor: 'Tests - Rotacion' stamp: 'max'!
test09RoverRota270GradosALaDerecha
	| rover |
	rover := MarsRover new.
	rover realizarAccion: 'rrr'.
	self assert: (rover direccionCardinal class) = DireccionOeste .
	! !

!MarsRoverTests methodsFor: 'Tests - Rotacion' stamp: 'max'!
test10RoverRota360GradosALaDerecha
	| rover |
	rover := MarsRover new.
	rover realizarAccion: 'rrrr'.
	self assert: (rover direccionCardinal class) = DireccionNorte .
	! !

!MarsRoverTests methodsFor: 'Tests - Rotacion' stamp: 'max'!
test11RoverRota90GradosALaIzquierda
	| rover |
	rover := MarsRover new.
	rover realizarAccion: 'l'.
	self assert: (rover direccionCardinal class) = DireccionOeste.
	! !

!MarsRoverTests methodsFor: 'Tests - Rotacion' stamp: 'max'!
test12RoverRota180GradosALaIzquierda
	| rover |
	rover := MarsRover new.
	rover realizarAccion: 'll'.
	self assert: (rover direccionCardinal class) = DireccionSur .
	! !

!MarsRoverTests methodsFor: 'Tests - Rotacion' stamp: 'max'!
test13RoverRota270GradosALaIzquierda
	| rover |
	rover := MarsRover new.
	rover realizarAccion: 'lll'.
	self assert: (rover direccionCardinal class) = DireccionEste.
	! !

!MarsRoverTests methodsFor: 'Tests - Rotacion' stamp: 'max'!
test14RoverRota360GradosALaIzquierda
	| rover |
	rover := MarsRover new.
	rover realizarAccion: 'llll'.
	self assert: (rover direccionCardinal class) = DireccionNorte .
	! !


!MarsRoverTests methodsFor: 'Tests - En Reposo' stamp: 'max'!
test01RoverRecibeComandos
	
	self assert: (MarsRover new realizarAccion: '') = #Recibido.
	! !

!MarsRoverTests methodsFor: 'Tests - En Reposo' stamp: 'max'!
test02SiElComandoEsVacioRoverNoSeMueve
	| rover |
	rover := MarsRover new.
	rover realizarAccion: ''.
	self assert: (rover posicion) = (0@0).
	! !

!MarsRoverTests methodsFor: 'Tests - En Reposo' stamp: 'max'!
test03SiElComandoEsVacioRoverNoRota
	| rover |
	rover := MarsRover new.
	rover realizarAccion: ''.
	self assert: (rover direccionCardinal class) = DireccionNorte.
	! !


!MarsRoverTests methodsFor: 'Tests - Acciones Combinadas' stamp: 'max'!
test15RoverRota90GradosALaDerechaYAvanzaUnPunto
	| rover |
	rover := MarsRover new.
	rover realizarAccion: 'rf'.
	self assert: (rover posicion ) = (1@0).
	! !

!MarsRoverTests methodsFor: 'Tests - Acciones Combinadas' stamp: 'max'!
test16RoverRota180GradosALaDerechaYAvanzaUnPunto
	| rover |
	rover := MarsRover new.
	rover realizarAccion: 'rrf'.
	self assert: (rover posicion ) = (0@-1).
	! !

!MarsRoverTests methodsFor: 'Tests - Acciones Combinadas' stamp: 'max'!
test17RoverRota270GradosALaDerechaYAvanzaUnPunto
	| rover |
	rover := MarsRover new.
	rover realizarAccion: 'rrrf'.
	self assert: (rover posicion ) = (-1@0).
	! !

!MarsRoverTests methodsFor: 'Tests - Acciones Combinadas' stamp: 'max'!
test18RoverRota90GradosALaDerechaYRetrocedeUnPunto
	| rover |
	rover := MarsRover new.
	rover realizarAccion: 'rb'.
	self assert: (rover posicion ) = (-1@0).
	! !

!MarsRoverTests methodsFor: 'Tests - Acciones Combinadas' stamp: 'max'!
test19RoverRota180GradosALaDerechaYRetrocedeUnPunto
	| rover |
	rover := MarsRover new.
	rover realizarAccion: 'rrb'.
	self assert: (rover posicion ) = (0@1).
	! !

!MarsRoverTests methodsFor: 'Tests - Acciones Combinadas' stamp: 'max'!
test20RoverRota270GradosALaDerechaYRetrocedeUnPunto
	| rover |
	rover := MarsRover new.
	rover realizarAccion: 'rrrb'.
	self assert: (rover posicion ) = (1@0).
	! !


!MarsRoverTests methodsFor: 'Tests - Error' stamp: 'max'!
test21RoverDetieneLaEjecucionYDaErrorAlRecibirComandoInvalido
	| rover |
	rover := MarsRover new.

	self should: [ rover realizarAccion: 'ffpbb'. ]
	 raise: Error
	 withExceptionDo: [:unError |
			self assert: rover posicion = (0@2). 
			self assert: unError messageText = MarsRover errorComandoInvalido.
		]
	! !


!MarsRoverTests methodsFor: 'Tests - Movimiento' stamp: 'max'!
test04RoverAvanzaUnPunto
	| rover |
	rover := MarsRover new.
	rover realizarAccion: 'f'.
	self assert: (rover posicion) = (0@1).
	! !

!MarsRoverTests methodsFor: 'Tests - Movimiento' stamp: 'max'!
test05RoverAvanzaMasDeUnPunto
	| rover |
	rover := MarsRover new.
	rover realizarAccion: 'ff'.
	self assert: (rover posicion) = (0@2).
	! !

!MarsRoverTests methodsFor: 'Tests - Movimiento' stamp: 'max'!
test06RoverRetrocedeUnPunto
	| rover |
	rover := MarsRover new.
	rover realizarAccion: 'b'.
	self assert: (rover posicion) = (0@-1).
	! !
(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 124 112 122 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 124 112 122 99 74 124 112 122 92 117 112 125 108 121 122 112 123 128 52 62 61 59 56 53 112 116 104 110 108 17 94 112 117 58 57 17 61 53 57 17 95 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 100 17 94 112 117 107 118 126 122 17 94 112 117 58 57 39 105 124 112 115 123 39 118 117 39 84 104 121 39 39 56 39 57 55 57 60 39 55 56 65 55 59 65 57 57 39 78 84 91 39 74 118 116 119 112 115 108 121 65 39 59 53 57 53 56 39 74 118 116 119 104 123 112 105 115 108 39 74 115 104 117 110 39 63 53 55 53 56 39 47 123 104 110 122 54 89 76 83 76 72 90 76 102 63 55 56 54 109 112 117 104 115 48 17 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 84 104 121 39 39 56 39 57 55 57 60 17 83 112 125 108 91 128 119 112 117 110 74 118 110 112 123 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 84 104 121 39 39 56 39 57 55 57 60 17 93 84 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 39 75 104 123 108 65 39 84 118 117 39 86 106 123 39 61 39 56 57 65 58 59 65 57 56 39 57 55 57 60 39 74 118 116 116 112 123 79 104 122 111 65 39 108 107 58 60 59 63 61 39 87 115 124 110 112 117 122 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 17 179 38 135 8 17 56 62 57 53 58 56 53 56 57 63 53 56 17 75 76 90 82 91 86 87 52 63 85 61 64 60 76 82 53 116 122 111 118 116 108 53 117 108 123 17 75 76 90 82 91 86 87 52 63 85 61 64 60 76 82 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 57 56 91 57 57 65 59 63 65 58 62 53 59 64 62 60 62 60 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 118 107 112 110 118 52 121 108 119 108 123 112 107 118 52 110 121 124 119 118 52 58 57 99 74 118 107 112 110 118 89 108 119 108 123 112 107 118 52 76 113 108 121 106 112 106 112 118 53 122 123 17 62 63 58 63 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 57 56 91 57 58 65 60 57 65 57 55 53 55 60 55 60 62 60 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 121 108 119 104 122 118 122 99 121 108 119 104 122 118 52 57 55 57 58 52 56 106 52 57 107 118 87 104 121 106 112 104 115 99 72 115 110 118 80 80 80 52 57 55 57 58 52 56 74 52 57 87 104 121 106 112 104 115 52 74 118 116 105 104 123 112 108 117 123 108 122 77 104 117 123 104 122 123 112 106 118 122 52 87 59 53 80 117 112 106 112 104 115 53 122 123 17 59 58 60 64 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 57 58 91 56 64 65 57 56 65 57 61 53 63 59 57 62 64 62 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 121 108 119 104 122 118 122 99 57 55 57 58 52 56 106 52 57 107 118 87 104 121 106 112 104 115 99 72 115 110 118 80 80 80 52 57 55 57 58 52 56 74 52 57 87 104 121 106 112 104 115 52 74 118 116 105 104 123 112 108 117 123 108 122 77 104 117 123 104 122 123 112 106 118 122 52 87 59 53 90 118 115 124 106 112 118 117 53 122 123 17 61 57 64 58 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 57 58 91 56 64 65 57 62 65 55 58 53 55 56 60 62 64 62 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 124 112 122 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 72 115 110 118 80 80 80 52 57 55 57 58 52 56 74 52 57 87 104 121 106 112 104 115 52 74 118 116 105 104 123 112 108 117 123 108 122 77 104 117 123 104 122 123 112 106 118 122 52 87 59 53 58 53 122 123 17 61 60 56 59 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 57 59 65 56 61 53 57 62 56 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 56 106 57 55 57 58 52 52 52 122 108 121 125 112 106 112 118 122 52 109 112 117 104 117 106 112 108 121 118 122 52 57 52 110 121 124 119 118 52 58 57 99 90 108 121 125 112 106 112 118 122 77 112 117 104 117 106 112 108 121 118 122 52 90 118 115 124 106 112 118 117 53 122 123 17 59 63 57 61 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 57 60 65 56 61 53 61 61 64 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 124 112 122 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 90 108 121 125 112 106 112 118 122 77 112 117 104 117 106 112 108 121 118 122 52 90 118 115 124 106 112 118 117 53 56 53 122 123 17 60 60 60 60 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 57 62 65 58 64 53 63 59 60 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 124 112 122 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 93 112 122 112 123 118 121 102 119 104 123 123 108 121 117 52 56 53 122 123 17 56 55 55 61 62 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 59 57 65 60 61 53 58 56 58 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 124 112 122 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 72 115 110 118 80 80 80 52 57 55 57 58 52 56 74 52 57 87 104 121 106 112 104 115 52 74 118 116 105 104 123 112 108 117 123 108 122 77 104 117 123 104 122 123 112 106 118 122 52 87 59 53 58 53 122 123 17 61 60 56 59 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 59 59 65 56 58 53 62 63 59 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 124 112 122 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 72 115 110 118 80 80 80 52 57 55 57 58 52 56 74 52 57 87 104 121 106 112 104 115 52 74 118 116 105 104 123 112 108 117 123 108 122 77 104 117 123 104 122 123 112 106 118 122 52 87 59 53 58 53 122 123 17 61 60 56 59 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 59 61 65 57 57 53 63 55 56 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 110 112 123 102 121 108 119 118 122 99 87 118 121 123 109 118 115 112 118 99 87 121 118 110 121 104 116 104 106 112 118 117 102 118 121 112 108 117 123 104 107 104 102 104 102 118 105 113 108 123 118 122 102 108 117 102 122 116 104 115 115 123 104 115 114 99 74 118 116 105 104 123 112 108 117 123 108 122 77 104 117 123 104 122 123 112 106 118 122 53 122 123 17 61 64 64 57 62 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 60 58 65 57 60 53 62 59 62 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 124 112 122 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 90 108 121 125 112 106 112 118 122 77 112 117 104 117 106 112 108 121 118 122 52 90 118 115 124 106 112 118 117 53 56 53 122 123 17 60 60 60 60 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 60 63 65 55 60 53 60 61 60 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 56 106 57 55 57 58 52 116 104 121 122 52 121 118 125 108 121 52 110 121 124 119 118 52 58 57 99 84 104 121 122 89 118 125 108 121 53 122 123 17 64 57 63 55 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 57 58 91 56 64 65 57 55 65 57 62 53 59 56 61 62 64 62 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 124 112 122 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 72 115 110 118 80 80 80 52 57 55 57 58 52 56 74 52 57 87 104 121 106 112 104 115 52 74 118 116 105 104 123 112 108 117 123 108 122 77 104 117 123 104 122 123 112 106 118 122 52 87 59 53 58 53 122 123 17 61 55 57 64 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 59 60 65 60 55 53 58 63 61 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 110 112 123 102 121 108 119 118 122 99 87 118 121 123 109 118 115 112 118 99 87 121 118 110 121 104 116 104 106 112 118 117 102 118 121 112 108 117 123 104 107 104 102 104 102 118 105 113 108 123 118 122 102 108 117 102 122 116 104 115 115 123 104 115 114 99 74 118 116 105 104 123 112 108 117 123 108 122 77 104 117 123 104 122 123 112 106 118 122 53 122 123 17 61 55 57 64 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 59 64 65 57 55 53 58 55 56 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 110 112 123 102 121 108 119 118 122 99 87 118 121 123 109 118 115 112 118 99 87 121 118 110 121 104 116 104 106 112 118 117 102 118 121 112 108 117 123 104 107 104 102 104 102 118 105 113 108 123 118 122 102 108 117 102 122 116 104 115 115 123 104 115 114 99 74 118 116 105 104 123 112 108 117 123 108 122 77 104 117 123 104 122 123 112 106 118 122 102 56 53 122 123 17 60 64 55 64 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 60 60 65 55 62 53 58 55 61 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 110 112 123 102 121 108 119 118 122 99 87 118 121 123 109 118 115 112 118 99 87 121 118 110 121 104 116 104 106 112 118 117 102 118 121 112 108 117 123 104 107 104 102 104 102 118 105 113 108 123 118 122 102 108 117 102 122 116 104 115 115 123 104 115 114 99 90 108 121 125 112 106 112 118 122 77 112 117 104 117 106 112 108 121 118 122 53 122 123 17 59 62 62 58 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 60 64 65 57 60 53 57 63 60 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 110 112 123 102 121 108 119 118 122 99 87 118 121 123 109 118 115 112 118 99 87 121 118 110 121 104 116 104 106 112 118 117 102 118 121 112 108 117 123 104 107 104 102 104 102 118 105 113 108 123 118 122 102 108 117 102 122 116 104 115 115 123 104 115 114 99 84 104 121 122 89 118 125 108 121 53 122 123 17 64 57 62 57 17 52 52 52 52 52 52 52 52 52 52 17 17))!