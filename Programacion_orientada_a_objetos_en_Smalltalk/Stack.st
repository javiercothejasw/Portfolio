!classDefinition: #OOStack category: 'Stack'!
Object subclass: #OOStack
	instanceVariableNames: 'collectionOfElements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack'!

!OOStack methodsFor: 'operations' stamp: 'max 5/9/2023 13:56:54'!
isEmpty
	
	^self subclassResponsibility 
	! !

!OOStack methodsFor: 'operations' stamp: 'max 5/9/2023 13:56:58'!
pop

	^self subclassResponsibility ! !

!OOStack methodsFor: 'operations' stamp: 'max 5/9/2023 13:57:06'!
push: aValue

	^self subclassResponsibility 

	! !

!OOStack methodsFor: 'operations' stamp: 'max 5/9/2023 13:57:12'!
size

	^self subclassResponsibility ! !

!OOStack methodsFor: 'operations' stamp: 'max 5/9/2023 13:57:16'!
top
	
	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'as yet unclassified' stamp: 'max 5/9/2023 13:51:27'!
new

	^UnlimitedStack basicNew initialize ! !

!OOStack class methodsFor: 'as yet unclassified' stamp: 'j 5/6/2023 12:33:17'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !

!OOStack class methodsFor: 'as yet unclassified' stamp: 'max 5/9/2023 13:52:34'!
withSize: aSize

	^LimitedStack basicNew initializeWithSize: aSize.! !


!classDefinition: #LimitedStack category: 'Stack'!
OOStack subclass: #LimitedStack
	instanceVariableNames: 'index'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack'!

!LimitedStack methodsFor: 'private' stamp: 'j 5/8/2023 17:00:22'!
currentElement

	^collectionOfElements at: index.! !

!LimitedStack methodsFor: 'private' stamp: 'j 5/8/2023 17:11:06'!
nextElement

	^collectionOfElements at: (index+1).! !


!LimitedStack methodsFor: 'operations' stamp: 'j 5/8/2023 17:35:21'!
isEmpty

	^self currentElement isEmpty.! !

!LimitedStack methodsFor: 'operations' stamp: 'j 5/8/2023 18:35:05'!
pop
	
	| currentElementValue |
	
	currentElementValue := self currentElement elementValue.
	
	index := (index -1).
	
	^currentElementValue.! !

!LimitedStack methodsFor: 'operations' stamp: 'max 5/9/2023 00:15:32'!
push: aValue

	self nextElement setValue: aValue.
	
	index := (index + 1).! !

!LimitedStack methodsFor: 'operations' stamp: 'max 5/9/2023 00:38:48'!
size
	"size - the 2 null ends"
	^(collectionOfElements size -2).! !

!LimitedStack methodsFor: 'operations' stamp: 'j 5/8/2023 17:29:16'!
top

	^self currentElement elementValue.! !


!LimitedStack methodsFor: 'initialization' stamp: 'max 5/9/2023 00:10:50'!
initializeWithSize: aSize

	collectionOfElements := OrderedCollection new.
	collectionOfElements add: NullElement new.
	aSize timesRepeat: [collectionOfElements add: (ActiveElement with: nil)].
	collectionOfElements add: NullElement new.
	index := 1.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LimitedStack class' category: 'Stack'!
LimitedStack class
	instanceVariableNames: ''!

!LimitedStack class methodsFor: 'as yet unclassified' stamp: 'j 5/8/2023 17:19:25'!
stackIsFullErrorDescription

	^'Stack is full'.! !


!classDefinition: #UnlimitedStack category: 'Stack'!
OOStack subclass: #UnlimitedStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack'!

!UnlimitedStack methodsFor: 'operations' stamp: 'max 5/9/2023 13:54:30'!
isEmpty
	
	^self lastElement isEmpty.
	! !

!UnlimitedStack methodsFor: 'operations' stamp: 'max 5/9/2023 13:54:18'!
pop

	^self lastElement removeFromStack: self.! !

!UnlimitedStack methodsFor: 'operations' stamp: 'max 5/9/2023 13:54:07'!
push: aValue

	collectionOfElements add: (ActiveElement with: aValue).

	! !

!UnlimitedStack methodsFor: 'operations' stamp: 'max 5/9/2023 13:53:58'!
size

	^(collectionOfElements size - 1).! !

!UnlimitedStack methodsFor: 'operations' stamp: 'max 5/9/2023 13:53:45'!
top
	
	^self lastElement elementValue.! !


!UnlimitedStack methodsFor: 'initialization' stamp: 'max 5/9/2023 13:55:16'!
initialize


	collectionOfElements := OrderedCollection new.
	
	collectionOfElements add: (NullElement new).! !


!UnlimitedStack methodsFor: 'private' stamp: 'max 5/9/2023 13:56:09'!
lastElement

	^collectionOfElements at: collectionOfElements size.! !


!UnlimitedStack methodsFor: 'node only operations' stamp: 'max 5/9/2023 14:45:37'!
removeElement

	collectionOfElements removeLast.! !


!classDefinition: #OOStackElement category: 'Stack'!
Object subclass: #OOStackElement
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack'!

!OOStackElement methodsFor: 'init' stamp: 'max 5/8/2023 23:57:01'!
initializeWith: aValue
	value := aValue ! !


!OOStackElement methodsFor: 'actions' stamp: 'max 5/8/2023 23:57:38'!
elementValue

	^self subclassResponsibility ! !

!OOStackElement methodsFor: 'actions' stamp: 'max 5/8/2023 23:57:45'!
isEmpty

	^self subclassResponsibility ! !

!OOStackElement methodsFor: 'actions' stamp: 'max 5/8/2023 23:57:48'!
removeFromStack: aStack

	^self subclassResponsibility ! !

!OOStackElement methodsFor: 'actions' stamp: 'max 5/9/2023 00:15:31'!
setValue: aValue

	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackElement class' category: 'Stack'!
OOStackElement class
	instanceVariableNames: ''!

!OOStackElement class methodsFor: 'as yet unclassified' stamp: 'max 5/9/2023 00:13:20'!
with: aValue
	^self subclassResponsibility ! !


!classDefinition: #ActiveElement category: 'Stack'!
OOStackElement subclass: #ActiveElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack'!

!ActiveElement methodsFor: 'actions' stamp: 'j 5/8/2023 18:18:46'!
elementValue

	^value.! !

!ActiveElement methodsFor: 'actions' stamp: 'j 5/6/2023 12:12:07'!
isEmpty

	^false.! !

!ActiveElement methodsFor: 'actions' stamp: 'j 5/7/2023 14:24:23'!
removeFromStack: aStack

	aStack removeElement.
	^value.! !

!ActiveElement methodsFor: 'actions' stamp: 'max 5/9/2023 00:15:32'!
setValue: aValue

	value := aValue.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ActiveElement class' category: 'Stack'!
ActiveElement class
	instanceVariableNames: ''!

!ActiveElement class methodsFor: 'as yet unclassified' stamp: 'max 5/9/2023 00:18:44'!
with: aValue
	^self new initializeWith: aValue ! !


!classDefinition: #NullElement category: 'Stack'!
OOStackElement subclass: #NullElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack'!

!NullElement methodsFor: 'actions' stamp: 'j 5/8/2023 17:31:19'!
elementValue

	self error: OOStack stackEmptyErrorDescription.! !

!NullElement methodsFor: 'actions' stamp: 'j 5/8/2023 17:36:08'!
isEmpty

	^true.! !

!NullElement methodsFor: 'actions' stamp: 'max 5/9/2023 14:44:57'!
removeFromStack: aStack

	self error: OOStack stackEmptyErrorDescription ! !

!NullElement methodsFor: 'actions' stamp: 'max 5/9/2023 00:15:32'!
setValue: aValue

	^self error: LimitedStack stackIsFullErrorDescription.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NullElement class' category: 'Stack'!
NullElement class
	instanceVariableNames: ''!

!NullElement class methodsFor: 'error' stamp: 'max 5/9/2023 00:09:13'!
nullElementCantHaveValueError
	^'NullElement cant be asigned a value'! !


!NullElement class methodsFor: 'as yet unclassified' stamp: 'max 5/9/2023 00:12:34'!
with: aValue
	self error: self nullElementCantHaveValueError ! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack'!

!SentenceFinderByPrefix methodsFor: 'actions' stamp: 'j 5/8/2023 00:02:33'!
find: aPrefix
	
	|allMatches auxStack element|
	
	self checkValidPrefix: aPrefix.
	
	allMatches := OrderedCollection new.
	auxStack := OOStack new.
	
	"loop through stack and add matches to collection"
	[stack isEmpty not] whileTrue: [ 
		element := stack pop.
		auxStack push: element.
		(self string: element matchesPrefix: aPrefix) ifTrue: [allMatches add: element].		
		].
	
	"return stack to original state"
	[auxStack isEmpty not] whileTrue: [stack push: auxStack pop].
	
	^allMatches.! !


!SentenceFinderByPrefix methodsFor: 'init' stamp: 'j 5/7/2023 14:45:01'!
initializeWithStack: aStack

	stack := aStack. 
	! !


!SentenceFinderByPrefix methodsFor: 'private' stamp: 'j 5/7/2023 16:21:34'!
checkValidPrefix: aPrefix

	((aPrefix isEmpty) or: ((aPrefix findString: ' ' startingAt: 1) > 0)) ifTrue: [self error: self class invalidPrefixErrorDescription].! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'j 5/7/2023 17:09:47'!
string: aString matchesPrefix: aPrefix

	^ (aString findString: aPrefix startingAt: 1) = 1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'j 5/7/2023 15:25:31'!
invalidPrefixErrorDescription

	^'Invalid Prefix'.! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'j 5/7/2023 14:47:29'!
withStack: aStack

	^self new initializeWithStack: aStack.! !


!classDefinition: #OOStackTest category: 'Stack'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack'!

!OOStackTest methodsFor: 'stack test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'stack test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'stack test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'stack test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'stack test' stamp: 'NR 5/13/2020 13:30:48'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'stack test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'stack test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'stack test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'stack test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'stack test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!OOStackTest methodsFor: 'limited stack test' stamp: 'j 5/8/2023 17:38:07'!
test11LimitedStackShouldBeEmptyWhenCreated

	| limitedStack |
	
	limitedStack := OOStack withSize: 10.
	
	self assert: limitedStack isEmpty.! !

!OOStackTest methodsFor: 'limited stack test' stamp: 'j 5/8/2023 22:05:47'!
test12PushAddElementsToTheLimitedStack

	| limitedStack |
	
	limitedStack := OOStack withSize: 10.
	limitedStack push: 'something'.
	
	self deny: limitedStack isEmpty.! !

!OOStackTest methodsFor: 'limited stack test' stamp: 'j 5/8/2023 17:52:28'!
test13PopRemovesElementsFromTheLimitedStack

	| limitedStack |
	
	limitedStack := OOStack withSize: 10.
	limitedStack push: 'something'.
	limitedStack pop.
	
	self assert: limitedStack isEmpty.! !

!OOStackTest methodsFor: 'limited stack test' stamp: 'j 5/8/2023 22:07:54'!
test14PopReturnsLastPushedObjectInLimitedStack

	| limitedStack pushedObject |
	
	limitedStack := OOStack withSize: 10.
	pushedObject := 'something'.
	limitedStack push: pushedObject.
	
	self assert: limitedStack pop = pushedObject.! !

!OOStackTest methodsFor: 'limited stack test' stamp: 'j 5/8/2023 22:11:39'!
test15LimitedStackBehavesLIFO

	| limitedStack firstPushedObject secondPushedObject |
	
	limitedStack := OOStack withSize: 10.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	limitedStack push: firstPushedObject.
	limitedStack push: secondPushedObject.
	
	self assert: limitedStack pop = secondPushedObject.
	self assert: limitedStack pop = firstPushedObject.
	self assert: limitedStack isEmpty. 
	! !

!OOStackTest methodsFor: 'limited stack test' stamp: 'j 5/8/2023 22:15:00'!
test16TopReturnsLastPushedObjectInLimitedStack

	| limitedStack pushedObject |
	
	limitedStack := OOStack withSize: 10.
	pushedObject := 'something'.
	
	limitedStack push: pushedObject.
	
	self assert: limitedStack top = pushedObject.
	! !

!OOStackTest methodsFor: 'limited stack test' stamp: 'j 5/8/2023 22:21:20'!
test17TopDoesNotRemoveObjectFromLimitedStack

	| limitedStack pushedObject |
	
	limitedStack := OOStack withSize: 1.
	pushedObject := 'something'.
	
	limitedStack push: pushedObject.
	limitedStack top.
	
	self
		should: [ limitedStack push: 'element' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = LimitedStack stackIsFullErrorDescription]
	! !

!OOStackTest methodsFor: 'limited stack test' stamp: 'j 5/8/2023 22:23:33'!
test18CanNotPopWhenThereAreNoObjectsInTheLimitedStack

	| limitedStack  |
	
	limitedStack := OOStack withSize: 10.
	self
		should: [ limitedStack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		! !

!OOStackTest methodsFor: 'limited stack test' stamp: 'j 5/8/2023 22:25:46'!
test19CanNotPopWhenThereAreNoObjectsInTheLimitedStackAndTheLimitedStackHadObjects

	| limitedStack  |
	
	limitedStack := OOStack withSize: 10.
	limitedStack push: 'something'.
	limitedStack pop.
	
	self
		should: [ limitedStack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		! !

!OOStackTest methodsFor: 'limited stack test' stamp: 'j 5/8/2023 22:26:53'!
test20CanNotTopWhenThereAreNoObjectsInTheLimitedStack

	| limitedStack  |
	
	limitedStack := OOStack  withSize: 10.
	self
		should: [ limitedStack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		! !

!OOStackTest methodsFor: 'limited stack test' stamp: 'j 5/8/2023 22:40:55'!
test21TheLimitedStackIsCreatedWithTheSpecifiedSize

	|limitedStack stackSize|
	
	stackSize := 10.
	limitedStack := OOStack withSize: stackSize.
	
	self assert: limitedStack size = stackSize.
	
! !

!OOStackTest methodsFor: 'limited stack test' stamp: 'j 5/8/2023 22:54:52'!
test22TheLimitedStackSizeAlwaysReturnsTheSameValue

	| limitedStack |
	
	limitedStack := OOStack withSize: 10.
	
	self assert: limitedStack size = 10.
	limitedStack push: 'something'.
	self assert: limitedStack size = 10.! !

!OOStackTest methodsFor: 'limited stack test' stamp: 'j 5/8/2023 22:55:02'!
test23CanNotPushWhenTheLimitedStackIsFull

	|limitedStack|
	
	limitedStack := OOStack withSize: 1.
	limitedStack push: 'something'.
	
	self
		should: [ limitedStack push: 'element' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = LimitedStack stackIsFullErrorDescription]
! !

!OOStackTest methodsFor: 'limited stack test' stamp: 'j 5/8/2023 22:55:09'!
test24CanNotPushWhenTheLimitedStackIsCreatedWithZeroSize

	| limitedStack|
	
	limitedStack := OOStack withSize: 0.
	
	self
		should: [ limitedStack push: 'element' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = LimitedStack stackIsFullErrorDescription]! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'emptyStack finderWithEmptyStack notEmptyStack finderWithNotEmptyStack emptyPrefix spacePrefix prefixWithMatchInNotEmptyStack prefixWithNoMatchInNotEmptyStack collectionWithMatch collectionWithNoMatches prefixWithWrongCaseHasNoMatches prefixWithMultipleMatchesInNotEmptyStack collectionWithMultipleMatches nonPrefixWordInNotEmptyStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack'!

!SentenceFinderByPrefixTest methodsFor: 'sentence finder tests' stamp: 'j 5/7/2023 16:44:22'!
assertsBlockRaisesInvalidPrefixError: aBlock

	self
		should: [aBlock value]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix invalidPrefixErrorDescription]! !

!SentenceFinderByPrefixTest methodsFor: 'sentence finder tests' stamp: 'j 5/7/2023 20:49:49'!
assertsNotEmptyStackWithPrefix: aPrefix result: aCollection

	self assert: ((finderWithNotEmptyStack find: aPrefix) = aCollection).! !

!SentenceFinderByPrefixTest methodsFor: 'sentence finder tests' stamp: 'max 5/9/2023 00:34:07'!
setUp

	"Stacks & Finders Initialization"
	emptyStack := OOStack new.
	finderWithEmptyStack := SentenceFinderByPrefix withStack: emptyStack.
	
	notEmptyStack := OOStack new.
	notEmptyStack push: 'winter is coming'.
	notEmptyStack push: 'winning is everything'.
	notEmptyStack push: 'The winds of Winter'.
	notEmptyStack push: 'Winter is here'.
	finderWithNotEmptyStack := SentenceFinderByPrefix withStack: notEmptyStack.
	
	"Prefixes to be used"
	emptyPrefix := ''.
	spacePrefix := ' '.
	
	prefixWithMatchInNotEmptyStack := 'Wint'.
	prefixWithMultipleMatchesInNotEmptyStack := 'win'.
	
	prefixWithNoMatchInNotEmptyStack := 'NoMatch'.
	prefixWithWrongCaseHasNoMatches := 'the'.
	
	nonPrefixWordInNotEmptyStack := 'is'.
	
	"Expected output collections"
	collectionWithMatch := OrderedCollection new.
	collectionWithMatch add: 'Winter is here'.
	
	collectionWithNoMatches := OrderedCollection new.
	
	collectionWithMultipleMatches := OrderedCollection new.
	collectionWithMultipleMatches add: 'winning is everything'.
	collectionWithMultipleMatches add: 'winter is coming'.
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'sentence finder tests' stamp: 'j 5/7/2023 23:55:59'!
test01EmptyPrefixAndEmptyStackIsError

	self assertsBlockRaisesInvalidPrefixError: [finderWithEmptyStack find: emptyPrefix ].
	
		! !

!SentenceFinderByPrefixTest methodsFor: 'sentence finder tests' stamp: 'j 5/7/2023 16:50:38'!
test02EmptyPrefixAndNotEmptyStackIsError

	self assertsBlockRaisesInvalidPrefixError: [finderWithNotEmptyStack find: emptyPrefix ].! !

!SentenceFinderByPrefixTest methodsFor: 'sentence finder tests' stamp: 'j 5/7/2023 16:50:48'!
test03SpacePrefixAndNotEmptyStackIsError

	self assertsBlockRaisesInvalidPrefixError: [finderWithNotEmptyStack find: spacePrefix ].! !

!SentenceFinderByPrefixTest methodsFor: 'sentence finder tests' stamp: 'j 5/7/2023 16:50:57'!
test04SpacePrefixAndEmptyStackIsError

	self assertsBlockRaisesInvalidPrefixError: [finderWithEmptyStack find: spacePrefix ].! !

!SentenceFinderByPrefixTest methodsFor: 'sentence finder tests' stamp: 'max 5/9/2023 00:21:35'!
test05ValidPrefixWithCaseSensitiveMatch

	self assertsNotEmptyStackWithPrefix: prefixWithMatchInNotEmptyStack result: collectionWithMatch.
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'sentence finder tests' stamp: 'max 5/9/2023 00:35:08'!
test06ValidPrefixWithNoMatch
	
	self assertsNotEmptyStackWithPrefix:  prefixWithNoMatchInNotEmptyStack result: collectionWithNoMatches.

	! !

!SentenceFinderByPrefixTest methodsFor: 'sentence finder tests' stamp: 'max 5/9/2023 00:35:03'!
test07ValidPrefixWithWrongCaseHasNoMatches

	self assertsNotEmptyStackWithPrefix: prefixWithWrongCaseHasNoMatches result: collectionWithNoMatches.
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'sentence finder tests' stamp: 'ma 5/7/2023 17:59:27'!
test08ValidPrefixAndEmptyStackHasNoMatches

	self assert: ((finderWithEmptyStack find: prefixWithMatchInNotEmptyStack) = collectionWithNoMatches).
	! !

!SentenceFinderByPrefixTest methodsFor: 'sentence finder tests' stamp: 'max 5/9/2023 00:34:57'!
test09ValidPrefixHasMultipleMatches

	self assertsNotEmptyStackWithPrefix: prefixWithMultipleMatchesInNotEmptyStack result: collectionWithMultipleMatches.
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'sentence finder tests' stamp: 'max 5/9/2023 00:34:53'!
test10WordIsInStackButNotAtTheBeginning

	self assertsNotEmptyStackWithPrefix: nonPrefixWordInNotEmptyStack result: collectionWithNoMatches.
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'sentence finder tests' stamp: 'max 5/9/2023 00:22:05'!
test11StackStaysTheSameAfterMatch
	
	| finder stack elements |

	elements := OrderedCollection new.
	elements add: 'one'. elements add: 'two'. elements add: 'three'.

	stack := OOStack new.
	stack push: (elements at: 3).
	stack push: (elements at: 2).
	stack push: (elements at: 1).

	finder := SentenceFinderByPrefix withStack: stack.
	finder find: (elements at: 2).

	elements do: [:element | self assert: stack pop = element]
	
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'sentence finder tests' stamp: 'max 5/9/2023 00:22:14'!
test12StackStaysTheSameAfterNoMatches
	
	| finder stack elements |

	elements := OrderedCollection new.
	elements add: 'one'. elements add: 'two'. elements add: 'three'.

	stack := OOStack new.
	stack push: (elements at: 3).
	stack push: (elements at: 2).
	stack push: (elements at: 1).

	finder := SentenceFinderByPrefix withStack: stack.
	finder find: 'NoMatches'.

	elements do: [:element | self assert: stack pop = element]
	
	
	! !
(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 124 112 122 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 124 112 122 99 74 124 112 122 92 117 112 125 108 121 122 112 123 128 52 62 61 59 56 53 112 116 104 110 108 17 94 112 117 58 57 17 61 53 57 17 95 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 100 17 94 112 117 107 118 126 122 17 94 112 117 58 57 39 105 124 112 115 123 39 118 117 39 84 104 121 39 39 56 39 57 55 57 60 39 55 56 65 55 59 65 57 57 39 78 84 91 39 74 118 116 119 112 115 108 121 65 39 59 53 57 53 56 39 74 118 116 119 104 123 112 105 115 108 39 74 115 104 117 110 39 63 53 55 53 56 39 47 123 104 110 122 54 89 76 83 76 72 90 76 102 63 55 56 54 109 112 117 104 115 48 17 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 84 104 121 39 39 56 39 57 55 57 60 17 83 112 125 108 91 128 119 112 117 110 74 118 110 112 123 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 84 104 121 39 39 56 39 57 55 57 60 17 93 84 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 39 75 104 123 108 65 39 84 118 117 39 86 106 123 39 61 39 56 57 65 58 59 65 57 56 39 57 55 57 60 39 74 118 116 116 112 123 79 104 122 111 65 39 108 107 58 60 59 63 61 39 87 115 124 110 112 117 122 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 17 179 38 135 8 17 56 62 57 53 58 56 53 56 57 63 53 56 17 75 76 90 82 91 86 87 52 63 85 61 64 60 76 82 53 116 122 111 118 116 108 53 117 108 123 17 75 76 90 82 91 86 87 52 63 85 61 64 60 76 82 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 57 56 91 57 57 65 59 63 65 58 62 53 59 64 62 60 62 60 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 118 107 112 110 118 52 121 108 119 108 123 112 107 118 52 110 121 124 119 118 52 58 57 99 74 118 107 112 110 118 89 108 119 108 123 112 107 118 52 76 113 108 121 106 112 106 112 118 53 122 123 17 62 63 58 63 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 57 56 91 57 58 65 60 57 65 57 55 53 55 60 55 60 62 60 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 121 108 119 104 122 118 122 99 121 108 119 104 122 118 52 57 55 57 58 52 56 106 52 57 107 118 87 104 121 106 112 104 115 99 72 115 110 118 80 80 80 52 57 55 57 58 52 56 74 52 57 87 104 121 106 112 104 115 52 74 118 116 105 104 123 112 108 117 123 108 122 77 104 117 123 104 122 123 112 106 118 122 52 87 59 53 80 117 112 106 112 104 115 53 122 123 17 59 58 60 64 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 57 58 91 56 64 65 57 56 65 57 61 53 63 59 57 62 64 62 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 121 108 119 104 122 118 122 99 57 55 57 58 52 56 106 52 57 107 118 87 104 121 106 112 104 115 99 72 115 110 118 80 80 80 52 57 55 57 58 52 56 74 52 57 87 104 121 106 112 104 115 52 74 118 116 105 104 123 112 108 117 123 108 122 77 104 117 123 104 122 123 112 106 118 122 52 87 59 53 90 118 115 124 106 112 118 117 53 122 123 17 61 57 64 58 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 57 58 91 56 64 65 57 62 65 55 58 53 55 56 60 62 64 62 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 124 112 122 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 72 115 110 118 80 80 80 52 57 55 57 58 52 56 74 52 57 87 104 121 106 112 104 115 52 74 118 116 105 104 123 112 108 117 123 108 122 77 104 117 123 104 122 123 112 106 118 122 52 87 59 53 58 53 122 123 17 61 60 56 59 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 57 59 65 56 61 53 57 62 56 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 56 106 57 55 57 58 52 52 52 122 108 121 125 112 106 112 118 122 52 109 112 117 104 117 106 112 108 121 118 122 52 57 52 110 121 124 119 118 52 58 57 99 90 108 121 125 112 106 112 118 122 77 112 117 104 117 106 112 108 121 118 122 52 90 118 115 124 106 112 118 117 53 122 123 17 59 63 57 61 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 57 60 65 56 61 53 61 61 64 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 124 112 122 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 90 108 121 125 112 106 112 118 122 77 112 117 104 117 106 112 108 121 118 122 52 90 118 115 124 106 112 118 117 53 56 53 122 123 17 60 60 60 60 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 57 62 65 58 64 53 63 59 60 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 124 112 122 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 93 112 122 112 123 118 121 102 119 104 123 123 108 121 117 52 56 53 122 123 17 56 55 55 61 62 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 59 57 65 60 61 53 58 56 58 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 124 112 122 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 72 115 110 118 80 80 80 52 57 55 57 58 52 56 74 52 57 87 104 121 106 112 104 115 52 74 118 116 105 104 123 112 108 117 123 108 122 77 104 117 123 104 122 123 112 106 118 122 52 87 59 53 58 53 122 123 17 61 60 56 59 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 59 59 65 56 58 53 62 63 59 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 124 112 122 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 72 115 110 118 80 80 80 52 57 55 57 58 52 56 74 52 57 87 104 121 106 112 104 115 52 74 118 116 105 104 123 112 108 117 123 108 122 77 104 117 123 104 122 123 112 106 118 122 52 87 59 53 58 53 122 123 17 61 60 56 59 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 59 61 65 57 57 53 63 55 56 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 110 112 123 102 121 108 119 118 122 99 87 118 121 123 109 118 115 112 118 99 87 121 118 110 121 104 116 104 106 112 118 117 102 118 121 112 108 117 123 104 107 104 102 104 102 118 105 113 108 123 118 122 102 108 117 102 122 116 104 115 115 123 104 115 114 99 74 118 116 105 104 123 112 108 117 123 108 122 77 104 117 123 104 122 123 112 106 118 122 53 122 123 17 61 64 64 57 62 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 60 58 65 57 60 53 62 59 62 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 124 112 122 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 90 108 121 125 112 106 112 118 122 77 112 117 104 117 106 112 108 121 118 122 52 90 118 115 124 106 112 118 117 53 56 53 122 123 17 60 60 60 60 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 60 63 65 55 60 53 60 61 60 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 56 106 57 55 57 58 52 116 104 121 122 52 121 118 125 108 121 52 110 121 124 119 118 52 58 57 99 84 104 121 122 89 118 125 108 121 53 122 123 17 64 57 63 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 60 64 65 60 59 53 56 60 56 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 118 107 112 110 118 52 121 108 119 108 123 112 107 118 52 110 121 124 119 118 52 58 57 99 74 118 107 112 110 118 89 108 119 108 123 112 107 118 52 76 113 108 121 106 112 106 112 118 53 122 123 17 62 63 58 63 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 56 65 55 56 65 57 59 53 62 58 57 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 56 106 57 55 57 58 52 117 124 116 108 121 118 122 52 110 121 124 119 118 52 58 57 99 85 124 116 108 121 118 122 52 87 104 121 123 108 57 52 76 113 108 121 106 112 106 112 118 53 122 123 17 57 59 60 56 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 56 65 55 58 65 59 60 53 59 58 63 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 56 106 57 55 57 58 52 122 123 104 106 114 52 110 121 124 119 118 52 58 57 99 90 123 104 106 114 52 76 127 108 121 106 112 122 108 53 122 123 17 57 58 58 62 58 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 57 58 91 56 64 65 57 55 65 57 62 53 59 56 61 62 64 62 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 124 112 122 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 72 115 110 118 80 80 80 52 57 55 57 58 52 56 74 52 57 87 104 121 106 112 104 115 52 74 118 116 105 104 123 112 108 117 123 108 122 77 104 117 123 104 122 123 112 106 118 122 52 87 59 53 58 53 122 123 17 61 55 57 64 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 59 60 65 60 55 53 58 63 61 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 110 112 123 102 121 108 119 118 122 99 87 118 121 123 109 118 115 112 118 99 87 121 118 110 121 104 116 104 106 112 118 117 102 118 121 112 108 117 123 104 107 104 102 104 102 118 105 113 108 123 118 122 102 108 117 102 122 116 104 115 115 123 104 115 114 99 74 118 116 105 104 123 112 108 117 123 108 122 77 104 117 123 104 122 123 112 106 118 122 53 122 123 17 61 55 57 64 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 59 64 65 57 55 53 58 55 56 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 110 112 123 102 121 108 119 118 122 99 87 118 121 123 109 118 115 112 118 99 87 121 118 110 121 104 116 104 106 112 118 117 102 118 121 112 108 117 123 104 107 104 102 104 102 118 105 113 108 123 118 122 102 108 117 102 122 116 104 115 115 123 104 115 114 99 74 118 116 105 104 123 112 108 117 123 108 122 77 104 117 123 104 122 123 112 106 118 122 102 56 53 122 123 17 60 64 55 64 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 60 60 65 55 62 53 58 55 61 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 110 112 123 102 121 108 119 118 122 99 87 118 121 123 109 118 115 112 118 99 87 121 118 110 121 104 116 104 106 112 118 117 102 118 121 112 108 117 123 104 107 104 102 104 102 118 105 113 108 123 118 122 102 108 117 102 122 116 104 115 115 123 104 115 114 99 90 108 121 125 112 106 112 118 122 77 112 117 104 117 106 112 108 121 118 122 53 122 123 17 59 62 62 58 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 60 64 65 57 60 53 57 63 60 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 110 112 123 102 121 108 119 118 122 99 87 118 121 123 109 118 115 112 118 99 87 121 118 110 121 104 116 104 106 112 118 117 102 118 121 112 108 117 123 104 107 104 102 104 102 118 105 113 108 123 118 122 102 108 117 102 122 116 104 115 115 123 104 115 114 99 84 104 121 122 89 118 125 108 121 53 122 123 17 64 57 62 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 56 65 55 58 65 56 59 53 55 59 55 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 110 112 123 102 121 108 119 118 122 99 87 118 121 123 109 118 115 112 118 99 87 121 118 110 121 104 116 104 106 112 118 117 102 118 121 112 108 117 123 104 107 104 102 104 102 118 105 113 108 123 118 122 102 108 117 102 122 116 104 115 115 123 104 115 114 99 85 124 116 108 121 118 122 53 122 123 17 57 59 56 56 64 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 56 65 55 59 65 60 57 53 62 55 61 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 110 112 123 102 121 108 119 118 122 99 87 118 121 123 109 118 115 112 118 99 87 121 118 110 121 104 116 104 106 112 118 117 102 118 121 112 108 117 123 104 107 104 102 104 102 118 105 113 108 123 118 122 102 108 117 102 122 116 104 115 115 123 104 115 114 99 90 123 104 106 114 53 122 123 17 57 58 56 60 62 17 52 52 52 52 52 52 52 52 52 52 17 17))!