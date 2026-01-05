!classDefinition: #Numero category: 'Numeros'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !


!Numero methodsFor: 'private' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numeros'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 5/7/2020 17:47:38'!
canNotDivideByZeroErrorDescription

	^'No se puede Dividir por Cero'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 5/7/2020 17:46:56'!
invalidNumberTypeErrorDescription
	^ 'Tipo de Número Inválido'! !


!classDefinition: #Entero category: 'Numeros'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros'!

!Entero methodsFor: 'arithmetic operations' stamp: 'j 4/28/2023 19:09:03'!
* aMultiplier 

	^ aMultiplier multiplicarConEntero: self.
	"(aMultiplier isKindOf: Entero) ifTrue: [^self class with: value * aMultiplier integerValue].

	(aMultiplier isKindOf: Fraccion) ifTrue: [^Fraccion with: self * aMultiplier numerator over: aMultiplier denominator]."
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'j 4/28/2023 18:34:48'!
+ anAdder 
	
	^anAdder sumarConEntero: self.
	
	"(anAdder isKindOf: Entero) ifTrue: [^self class with: value + anAdder integerValue].
	^Fraccion with: (self * anAdder denominator) + anAdder numerator  over: anAdder denominator."
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'max 4/30/2023 08:31:05'!
- aSubtrahend 
	^ aSubtrahend restarEnteroPorSelf: self.
	"(aSubtrahend isKindOf: Entero) ifTrue: [^self class with: value - aSubtrahend integerValue].
	
	(aSubtrahend isKindOf: Fraccion) ifTrue: [^Fraccion with: (self * aSubtrahend denominator) - aSubtrahend numerator  over: aSubtrahend denominator]."! !

!Entero methodsFor: 'arithmetic operations' stamp: 'max 4/30/2023 08:24:35'!
/ aDivisor 
	^ aDivisor dividirEnteroPorSelf: self.
	"(aDivisor isKindOf: Entero) ifTrue: [^Fraccion with: self over: aDivisor].
	
	(aDivisor isKindOf: Fraccion) ifTrue: [^ (self * aDivisor denominator) / aDivisor numerator]."! !

!Entero methodsFor: 'arithmetic operations' stamp: 'max 4/30/2023 08:24:35'!
dividirEnteroPorSelf: aDividend
	
	^Fraccion with: aDividend over: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'max 4/30/2023 08:25:56'!
dividirFraccionPorSelf: aDividend

	^aDividend numerator / (aDividend denominator * self)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'max 5/1/2023 08:28:06'!
fibonacci
	self subclassResponsibility ! !

!Entero methodsFor: 'arithmetic operations' stamp: 'max 4/30/2023 09:33:27'!
multiplicarConEntero: aMultiplicand

	^Entero with: value * aMultiplicand integerValue.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'max 4/30/2023 08:28:12'!
multiplicarConFraccion: aMultiplicand
	
	^Fraccion with: self * aMultiplicand numerator over: aMultiplicand denominator! !

!Entero methodsFor: 'arithmetic operations' stamp: 'max 4/30/2023 09:33:15'!
restarEnteroPorSelf: aMinuend
	
	^Entero with: (aMinuend integerValue - value )! !

!Entero methodsFor: 'arithmetic operations' stamp: 'max 4/30/2023 08:32:13'!
restarFraccionPorSelf: aMinuend
	
	^Fraccion with: (aMinuend numerator - (aMinuend denominator * self)) over: aMinuend denominator
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'max 4/30/2023 09:32:58'!
sumarConEntero: anAdder

	^Entero with: (value + anAdder integerValue)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'j 4/28/2023 19:02:48'!
sumarConFraccion: anAdder
	
	
	^Fraccion with: (self * anAdder denominator) + anAdder numerator  over: anAdder denominator.! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'JS 5/5/2022 03:55:37'!
initializeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'NR 9/23/2018 22:17:55'!
isNegative
	
	^value < 0! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:14'!
isOne
	
	^value = 1! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:12'!
isZero
	
	^value = 0! !


!Entero methodsFor: 'arithmetic operations - private' stamp: 'max 5/1/2023 08:41:24'!
// aDivisor 
	
	^Entero with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'HernanWilkinson 5/7/2016 21:00'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numeros'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NR 4/8/2019 02:57:57'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos'! !

!Entero class methodsFor: 'instance creation' stamp: 'max 4/30/2023 09:06:51'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	Entero subclassesDo: [ :unaSubclaseEntero | (unaSubclaseEntero fitsInThisClass: aValue) ifTrue: [^ unaSubclaseEntero with: aValue] ].
! !


!classDefinition: #EnteroCero category: 'Numeros'!
Entero subclass: #EnteroCero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros'!

!EnteroCero methodsFor: 'extra operations' stamp: 'max 5/1/2023 08:28:06'!
fibonacci
	^Entero with: 1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroCero class' category: 'Numeros'!
EnteroCero class
	instanceVariableNames: ''!

!EnteroCero class methodsFor: 'as yet unclassified' stamp: 'max 4/30/2023 09:09:25'!
fitsInThisClass: aValue
	^aValue = 0! !

!EnteroCero class methodsFor: 'as yet unclassified' stamp: 'max 4/30/2023 09:10:28'!
with: aValue
	^self new initializeWith: aValue! !


!classDefinition: #EnteroMayorAUno category: 'Numeros'!
Entero subclass: #EnteroMayorAUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros'!

!EnteroMayorAUno methodsFor: 'extra operations' stamp: 'max 5/1/2023 08:28:06'!
fibonacci
	| one two |
	one := Entero with: 1.
	two := Entero with: 2.
	^ (self - one) fibonacci + (self - two) fibonacci! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroMayorAUno class' category: 'Numeros'!
EnteroMayorAUno class
	instanceVariableNames: ''!

!EnteroMayorAUno class methodsFor: 'as yet unclassified' stamp: 'max 4/30/2023 09:11:42'!
fitsInThisClass: aValue
	^aValue > 1! !

!EnteroMayorAUno class methodsFor: 'as yet unclassified' stamp: 'max 4/30/2023 09:11:30'!
with: aValue
	^self new initializeWith: aValue! !


!classDefinition: #EnteroNegativo category: 'Numeros'!
Entero subclass: #EnteroNegativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros'!

!EnteroNegativo methodsFor: 'extra operations' stamp: 'max 5/1/2023 08:28:53'!
fibonacci
	self error: Entero negativeFibonacciErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroNegativo class' category: 'Numeros'!
EnteroNegativo class
	instanceVariableNames: ''!

!EnteroNegativo class methodsFor: 'as yet unclassified' stamp: 'max 4/30/2023 09:11:57'!
fitsInThisClass: aValue
	^aValue < 0! !

!EnteroNegativo class methodsFor: 'as yet unclassified' stamp: 'max 4/30/2023 09:11:45'!
with: aValue
	^self new initializeWith: aValue! !


!classDefinition: #EnteroUno category: 'Numeros'!
Entero subclass: #EnteroUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros'!

!EnteroUno methodsFor: 'extra operations' stamp: 'max 5/1/2023 08:28:06'!
fibonacci
	^ Entero with: 1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroUno class' category: 'Numeros'!
EnteroUno class
	instanceVariableNames: ''!

!EnteroUno class methodsFor: 'as yet unclassified' stamp: 'max 4/30/2023 09:19:40'!
fitsInThisClass: aValue

	^aValue = 1! !

!EnteroUno class methodsFor: 'as yet unclassified' stamp: 'max 4/30/2023 09:12:02'!
with: aValue
	^self new initializeWith: aValue! !


!classDefinition: #Fraccion category: 'Numeros'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'j 4/28/2023 19:12:49'!
* aMultiplier 

	^aMultiplier multiplicarConFraccion: self.
	"(aMultiplier isKindOf: Entero) ifTrue: [^(numerator * aMultiplier) / denominator].
	^(numerator * aMultiplier numerator) / (denominator * aMultiplier denominator)."
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'j 4/28/2023 18:36:48'!
+ anAdder 
	
	^anAdder sumarConFraccion: self
	"| newNumerator newDenominator |
	
	(anAdder isKindOf: Fraccion) ifTrue:[
	newNumerator := (numerator * anAdder denominator) + (denominator * anAdder numerator).
	newDenominator := denominator * anAdder denominator].

	(anAdder isKindOf: Entero) ifTrue: [newNumerator := (denominator * anAdder) + numerator.
	newDenominator := denominator].

	^newNumerator / newDenominator. "! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'max 4/30/2023 08:32:13'!
- aSubtrahend 
	^ aSubtrahend restarFraccionPorSelf: self.
	"| newNumerator newDenominator |
	
	(aSubtrahend isKindOf: Fraccion) ifTrue:[
	newNumerator := (numerator * aSubtrahend denominator) - (denominator * aSubtrahend numerator).
	newDenominator := denominator * aSubtrahend denominator].

	(aSubtrahend isKindOf: Entero) ifTrue: [newNumerator :=  numerator - (denominator * aSubtrahend).
	newDenominator := denominator].

	^newNumerator / newDenominator. "
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'max 4/30/2023 08:25:56'!
/ aDivisor 
	^ aDivisor dividirFraccionPorSelf: self.
	"(aDivisor isKindOf: Entero) ifTrue: [^numerator / (denominator * aDivisor)].
	
	(aDivisor isKindOf: Fraccion) ifTrue: [^(numerator * aDivisor denominator) / (denominator * aDivisor numerator)]."! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'max 4/30/2023 08:24:35'!
dividirEnteroPorSelf: aDividend
	
	^ (aDividend * self denominator) / self numerator! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'max 4/30/2023 08:25:56'!
dividirFraccionPorSelf: aDividend
	
	^(denominator * aDividend numerator ) / (numerator * aDividend denominator )! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'max 4/30/2023 08:27:09'!
multiplicarConEntero: aMultiplicand

	^(numerator * aMultiplicand) / denominator.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'max 4/30/2023 08:28:23'!
multiplicarConFraccion: aMultiplicand
	
	^(numerator * aMultiplicand numerator) / (denominator * aMultiplicand denominator).! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'max 4/30/2023 08:31:05'!
restarEnteroPorSelf: aMinuend
	
	^((denominator * aMinuend) - numerator ) / denominator.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'max 4/30/2023 08:32:13'!
restarFraccionPorSelf: aMinuend
	
	^((aMinuend numerator * denominator) - (aMinuend denominator * numerator)) / (aMinuend denominator * denominator)! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'j 4/28/2023 18:51:02'!
sumarConEntero: anAdder

	^((denominator * anAdder) + numerator) / denominator! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'j 4/28/2023 18:57:22'!
sumarConFraccion: anAdder

	
	^((numerator * anAdder denominator) + (denominator * anAdder numerator)) / (denominator * anAdder denominator).! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 22:54'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numeros'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'max 5/1/2023 08:40:48'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	(aDivisor isKindOf: EnteroCero) ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	(aDividend isKindOf: EnteroCero) ifTrue:  [ ^aDividend ].
	
	(aDivisor isKindOf: EnteroNegativo ) ifTrue: [ ^aDividend negated / aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	(denominator isKindOf: EnteroUno) ifTrue:  [ ^Entero with: numerator integerValue ].

	(denominator isKindOf: EnteroMayorAUno ) ifTrue: [^self new initializeWith: numerator over: denominator]
	! !


!classDefinition: #NumeroTest category: 'Numeros'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros'!

!NumeroTest methodsFor: 'tests' stamp: 'LL 9/13/2020 16:17:50'!
test01isZeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'LL 9/13/2020 16:17:58'!
test02isZeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'max 4/30/2023 09:17:26'!
test05EnteroAddsWithEnteroCorrectly

	self assert: two equals: one + one.! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:40:10'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: four equals: two * two! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:40:22'!
test07EnteroDividesEnteroCorrectly

	self assert: one equals: two / two! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:40:57'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: sevenTenths equals: oneFifth + oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:41:20'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: twoTwentyfifth equals: oneFifth * twoFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:41:34'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: fiveHalfs equals: oneHalf / oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:41:58'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: (Entero with: 6) / (Entero with: 5) equals: one + oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:42:29'!
test12FraccionAddsEnteroCorrectly

	self assert: (Entero with: 6) / (Entero with: 5) equals: oneFifth + one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:43:16'!
test13EnteroMultipliesFraccionCorrectly

	self assert: twoFifth equals: two * oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:43:27'!
test14FraccionMultipliesEnteroCorrectly

	self assert: twoFifth equals: oneFifth * two! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:43:40'!
test15EnteroDividesFraccionCorrectly

	self assert: fiveHalfs equals: one / twoFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:43:58'!
test16FraccionDividesEnteroCorrectly

	self assert: twoTwentyfifth equals: twoFifth / five! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:44:53'!
test19AddingFraccionesCanReturnAnEntero

	self assert: one equals: oneHalf + oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:45:13'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: one equals: (two/five) * (five/two)! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:45:27'!
test21DividingFraccionesCanReturnAnEntero

	self assert: one equals: oneHalf / oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:45:40'!
test22DividingEnterosCanReturnAFraccion

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:50:17'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: Numero canNotDivideByZeroErrorDescription equals: anError messageText ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:50:32'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: Numero canNotDivideByZeroErrorDescription equals: anError messageText ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:46:21'!
test27EnteroSubstractsEnteroCorrectly

	self assert: two equals: three - one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:46:36'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: oneFifth equals: twoFifth - oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:46:50'!
test29EnteroSubstractsFraccionCorrectly

	self assert: oneHalf equals: one - oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:47:11'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: oneFifth equals: sixFifth - one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:47:25'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: one equals: threeHalfs - oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:47:44'!
test32SubstractingSameEnterosReturnsZero

	self assert: zero equals: one - one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:47:59'!
test33SubstractingSameFraccionesReturnsZero

	self assert: zero equals: oneHalf - oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:48:16'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: negativeThreeHalfs equals: one - fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:48:45'!
test35FibonacciZeroIsOne

	self assert: one equals: zero fibonacci! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:48:58'!
test36FibonacciOneIsOne

	self assert: one equals: one fibonacci! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:52:24'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: five equals: four fibonacci.
	self assert: three equals: three fibonacci. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:52:40'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: Entero negativeFibonacciErrorDescription equals: anError messageText ]! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:52:17'!
test39NegationOfEnteroIsCorrect

	self assert: negativeTwo equals: two negated
		! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:53:27'!
test40NegationOfFraccionIsCorrect

	self assert: negativeOne / two equals: oneHalf negated ! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !
(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 124 112 122 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 124 112 122 99 74 124 112 122 92 117 112 125 108 121 122 112 123 128 52 62 61 59 56 53 112 116 104 110 108 17 94 112 117 58 57 17 61 53 57 17 95 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 100 17 94 112 117 107 118 126 122 17 94 112 117 58 57 39 105 124 112 115 123 39 118 117 39 84 104 121 39 39 56 39 57 55 57 60 39 55 56 65 55 59 65 57 57 39 78 84 91 39 74 118 116 119 112 115 108 121 65 39 59 53 57 53 56 39 74 118 116 119 104 123 112 105 115 108 39 74 115 104 117 110 39 63 53 55 53 56 39 47 123 104 110 122 54 89 76 83 76 72 90 76 102 63 55 56 54 109 112 117 104 115 48 17 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 84 104 121 39 39 56 39 57 55 57 60 17 83 112 125 108 91 128 119 112 117 110 74 118 110 112 123 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 84 104 121 39 39 56 39 57 55 57 60 17 93 84 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 39 75 104 123 108 65 39 84 118 117 39 86 106 123 39 61 39 56 57 65 58 59 65 57 56 39 57 55 57 60 39 74 118 116 116 112 123 79 104 122 111 65 39 108 107 58 60 59 63 61 39 87 115 124 110 112 117 122 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 17 179 38 135 8 17 56 62 57 53 58 56 53 56 57 63 53 56 17 75 76 90 82 91 86 87 52 63 85 61 64 60 76 82 53 116 122 111 118 116 108 53 117 108 123 17 75 76 90 82 91 86 87 52 63 85 61 64 60 76 82 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 57 56 91 57 57 65 59 63 65 58 62 53 59 64 62 60 62 60 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 118 107 112 110 118 52 121 108 119 108 123 112 107 118 52 110 121 124 119 118 52 58 57 99 74 118 107 112 110 118 89 108 119 108 123 112 107 118 52 76 113 108 121 106 112 106 112 118 53 122 123 17 62 63 58 63 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 57 56 91 57 58 65 60 57 65 57 55 53 55 60 55 60 62 60 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 121 108 119 104 122 118 122 99 121 108 119 104 122 118 52 57 55 57 58 52 56 106 52 57 107 118 87 104 121 106 112 104 115 99 72 115 110 118 80 80 80 52 57 55 57 58 52 56 74 52 57 87 104 121 106 112 104 115 52 74 118 116 105 104 123 112 108 117 123 108 122 77 104 117 123 104 122 123 112 106 118 122 52 87 59 53 80 117 112 106 112 104 115 53 122 123 17 59 58 60 64 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 57 58 91 56 64 65 57 56 65 57 61 53 63 59 57 62 64 62 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 121 108 119 104 122 118 122 99 57 55 57 58 52 56 106 52 57 107 118 87 104 121 106 112 104 115 99 72 115 110 118 80 80 80 52 57 55 57 58 52 56 74 52 57 87 104 121 106 112 104 115 52 74 118 116 105 104 123 112 108 117 123 108 122 77 104 117 123 104 122 123 112 106 118 122 52 87 59 53 90 118 115 124 106 112 118 117 53 122 123 17 61 57 64 58 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 57 58 91 56 64 65 57 62 65 55 58 53 55 56 60 62 64 62 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 124 112 122 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 72 115 110 118 80 80 80 52 57 55 57 58 52 56 74 52 57 87 104 121 106 112 104 115 52 74 118 116 105 104 123 112 108 117 123 108 122 77 104 117 123 104 122 123 112 106 118 122 52 87 59 53 58 53 122 123 17 61 60 56 59 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 57 59 65 56 61 53 57 62 56 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 56 106 57 55 57 58 52 52 52 122 108 121 125 112 106 112 118 122 52 109 112 117 104 117 106 112 108 121 118 122 52 57 52 110 121 124 119 118 52 58 57 99 90 108 121 125 112 106 112 118 122 77 112 117 104 117 106 112 108 121 118 122 52 90 118 115 124 106 112 118 117 53 122 123 17 59 63 57 61 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 57 60 65 56 61 53 61 61 64 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 124 112 122 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 90 108 121 125 112 106 112 118 122 77 112 117 104 117 106 112 108 121 118 122 52 90 118 115 124 106 112 118 117 53 56 53 122 123 17 60 60 60 60 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 57 62 65 58 64 53 63 59 60 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 124 112 122 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 93 112 122 112 123 118 121 102 119 104 123 123 108 121 117 52 56 53 122 123 17 56 55 55 61 62 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 59 57 65 60 61 53 58 56 58 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 124 112 122 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 72 115 110 118 80 80 80 52 57 55 57 58 52 56 74 52 57 87 104 121 106 112 104 115 52 74 118 116 105 104 123 112 108 117 123 108 122 77 104 117 123 104 122 123 112 106 118 122 52 87 59 53 58 53 122 123 17 61 60 56 59 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 59 59 65 56 58 53 62 63 59 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 124 112 122 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 72 115 110 118 80 80 80 52 57 55 57 58 52 56 74 52 57 87 104 121 106 112 104 115 52 74 118 116 105 104 123 112 108 117 123 108 122 77 104 117 123 104 122 123 112 106 118 122 52 87 59 53 58 53 122 123 17 61 60 56 59 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 59 61 65 57 57 53 63 55 56 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 110 112 123 102 121 108 119 118 122 99 87 118 121 123 109 118 115 112 118 99 87 121 118 110 121 104 116 104 106 112 118 117 102 118 121 112 108 117 123 104 107 104 102 104 102 118 105 113 108 123 118 122 102 108 117 102 122 116 104 115 115 123 104 115 114 99 74 118 116 105 104 123 112 108 117 123 108 122 77 104 117 123 104 122 123 112 106 118 122 53 122 123 17 61 64 64 57 62 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 60 58 65 57 60 53 62 59 62 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 124 112 122 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 90 108 121 125 112 106 112 118 122 77 112 117 104 117 106 112 108 121 118 122 52 90 118 115 124 106 112 118 117 53 56 53 122 123 17 60 60 60 60 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 60 63 65 55 60 53 60 61 60 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 56 106 57 55 57 58 52 116 104 121 122 52 121 118 125 108 121 52 110 121 124 119 118 52 58 57 99 84 104 121 122 89 118 125 108 121 53 122 123 17 64 57 63 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 60 64 65 60 59 53 56 60 56 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 118 107 112 110 118 52 121 108 119 108 123 112 107 118 52 110 121 124 119 118 52 58 57 99 74 118 107 112 110 118 89 108 119 108 123 112 107 118 52 76 113 108 121 106 112 106 112 118 53 122 123 17 62 63 58 63 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 56 65 55 56 65 57 59 53 62 58 57 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 56 106 57 55 57 58 52 117 124 116 108 121 118 122 52 110 121 124 119 118 52 58 57 99 85 124 116 108 121 118 122 52 87 104 121 123 108 57 52 76 113 108 121 106 112 106 112 118 53 122 123 17 57 59 60 56 55 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 57 58 91 56 64 65 57 55 65 57 62 53 59 56 61 62 64 62 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 124 112 122 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 72 115 110 118 80 80 80 52 57 55 57 58 52 56 74 52 57 87 104 121 106 112 104 115 52 74 118 116 105 104 123 112 108 117 123 108 122 77 104 117 123 104 122 123 112 106 118 122 52 87 59 53 58 53 122 123 17 61 55 57 64 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 59 60 65 60 55 53 58 63 61 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 110 112 123 102 121 108 119 118 122 99 87 118 121 123 109 118 115 112 118 99 87 121 118 110 121 104 116 104 106 112 118 117 102 118 121 112 108 117 123 104 107 104 102 104 102 118 105 113 108 123 118 122 102 108 117 102 122 116 104 115 115 123 104 115 114 99 74 118 116 105 104 123 112 108 117 123 108 122 77 104 117 123 104 122 123 112 106 118 122 53 122 123 17 61 55 57 64 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 59 64 65 57 55 53 58 55 56 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 110 112 123 102 121 108 119 118 122 99 87 118 121 123 109 118 115 112 118 99 87 121 118 110 121 104 116 104 106 112 118 117 102 118 121 112 108 117 123 104 107 104 102 104 102 118 105 113 108 123 118 122 102 108 117 102 122 116 104 115 115 123 104 115 114 99 74 118 116 105 104 123 112 108 117 123 108 122 77 104 117 123 104 122 123 112 106 118 122 102 56 53 122 123 17 60 64 55 64 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 60 60 65 55 62 53 58 55 61 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 110 112 123 102 121 108 119 118 122 99 87 118 121 123 109 118 115 112 118 99 87 121 118 110 121 104 116 104 106 112 118 117 102 118 121 112 108 117 123 104 107 104 102 104 102 118 105 113 108 123 118 122 102 108 117 102 122 116 104 115 115 123 104 115 114 99 90 108 121 125 112 106 112 118 122 77 112 117 104 117 106 112 108 121 118 122 53 122 123 17 59 62 62 58 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 60 64 65 57 60 53 57 63 60 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 110 112 123 102 121 108 119 118 122 99 87 118 121 123 109 118 115 112 118 99 87 121 118 110 121 104 116 104 106 112 118 117 102 118 121 112 108 117 123 104 107 104 102 104 102 118 105 113 108 123 118 122 102 108 117 102 122 116 104 115 115 123 104 115 114 99 84 104 121 122 89 118 125 108 121 53 122 123 17 64 57 62 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 56 65 55 58 65 56 59 53 55 59 55 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 110 112 123 102 121 108 119 118 122 99 87 118 121 123 109 118 115 112 118 99 87 121 118 110 121 104 116 104 106 112 118 117 102 118 121 112 108 117 123 104 107 104 102 104 102 118 105 113 108 123 118 122 102 108 117 102 122 116 104 115 115 123 104 115 114 99 85 124 116 108 121 118 122 53 122 123 17 57 59 56 56 64 17 52 52 52 52 52 52 52 52 52 52 17 17))!