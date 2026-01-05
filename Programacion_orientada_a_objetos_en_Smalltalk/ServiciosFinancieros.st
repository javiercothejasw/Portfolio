!classDefinition: #Account category: 'ServiciosFinancieros'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:45:50'!
addedTo: aPortfolio

	self subclassResponsibility! !

!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:46:48'!
isComposedBy: anAccount

	self subclassResponsibility! !


!Account methodsFor: 'private' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !


!Account methodsFor: 'visitor' stamp: 'j 6/13/2023 14:49:31'!
acceptVisitor: aVisitor with: anIndentation

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: 'ServiciosFinancieros'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'as yet unclassified' stamp: 'max 6/12/2023 15:00:41'!
named: aName 
	^self new initializeNamed: aName ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!Portfolio methodsFor: 'initialization' stamp: 'max 6/12/2023 14:50:53'!
initialize

	name := 'Default Portfolio'.
	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'max 6/12/2023 14:42:34'!
initializeNamed: aName 
	name := aName.! !


!Portfolio methodsFor: 'main protocol' stamp: 'j 6/13/2023 13:09:03'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0*peso ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'max 6/12/2023 14:45:20'!
name
	^name! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !


!Portfolio methodsFor: 'private' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !


!Portfolio methodsFor: 'iterator' stamp: 'max 6/12/2023 15:23:49'!
iterate: aBlock
	accounts do: [:anAccount | aBlock value: anAccount. ].! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'visitor' stamp: 'j 6/13/2023 12:12:51'!
acceptVisitor: aVisitor with: anIndentation

	^(aVisitor visitPortfolio: self with: anIndentation).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'max 6/12/2023 14:59:54'!
initializeNamed: aName 
	name := aName.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'max 6/12/2023 13:55:37'!
balance

	^transactions 
		inject: 0*peso
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'max 6/12/2023 15:28:51'!
name
	^name! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'private' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'visitor' stamp: 'j 6/13/2023 12:13:41'!
acceptVisitor: aVisitor with: anIndentation

	^(aVisitor visitReceptiveAccount: self with: anIndentation).! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'visitor' stamp: 'max 6/12/2023 14:14:41'!
acceptVisitor: aVisitor
	^self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!classDefinition: #Deposit category: 'ServiciosFinancieros'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'visitor' stamp: 'max 6/12/2023 14:02:46'!
acceptVisitor: aVisitor
	^aVisitor visitDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!Deposit class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferLeg category: 'ServiciosFinancieros'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!TransferLeg methodsFor: 'value' stamp: 'LL 9/20/2020 22:27:32'!
value

	^transfer value! !


!TransferLeg methodsFor: 'initialization' stamp: 'LL 9/20/2020 22:28:14'!
initializeWith: aTransfer

	transfer := aTransfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'ServiciosFinancieros'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 22:45:01'!
of: aTransfer on: anAccount

	| transaction |
	
	transaction := self new initializeWith: 	aTransfer.
	anAccount register: transaction.	
	
	^transaction! !


!classDefinition: #TransferDepositLeg category: 'ServiciosFinancieros'!
TransferLeg subclass: #TransferDepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!TransferDepositLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:26:10'!
withdrawLeg

	^transfer withdrawLeg! !


!TransferDepositLeg methodsFor: 'visitor' stamp: 'max 6/12/2023 14:03:25'!
acceptVisitor: aVisitor
	^aVisitor visitDepositLeg: self.! !


!TransferDepositLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:49'!
affectBalance: aBalance

	^aBalance + self value! !


!classDefinition: #TransferWithdrawLeg category: 'ServiciosFinancieros'!
TransferLeg subclass: #TransferWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:25:47'!
depositLeg

	^transfer depositLeg! !


!TransferWithdrawLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:55'!
affectBalance: aBalance

	^aBalance - self value! !


!TransferWithdrawLeg methodsFor: 'visitor' stamp: 'max 6/12/2023 14:03:38'!
acceptVisitor: aVisitor
	^aVisitor visitWithdrawLeg: self.! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'visitor' stamp: 'max 6/12/2023 14:03:08'!
acceptVisitor: aVisitor
	^aVisitor visitWithdraw: self.! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!Withdraw class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:05'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #AccountTransactionVisitor category: 'ServiciosFinancieros'!
Object subclass: #AccountTransactionVisitor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!AccountTransactionVisitor methodsFor: 'public' stamp: 'max 6/12/2023 14:13:58'!
visitDeposit: aDeposit
	^self subclassResponsibility ! !

!AccountTransactionVisitor methodsFor: 'public' stamp: 'max 6/12/2023 14:13:54'!
visitDepositLeg: aDepositLeg
	^self subclassResponsibility 
	! !

!AccountTransactionVisitor methodsFor: 'public' stamp: 'max 6/12/2023 14:13:50'!
visitWithdraw: aWithdraw
	^self subclassResponsibility ! !

!AccountTransactionVisitor methodsFor: 'public' stamp: 'max 6/12/2023 14:13:47'!
visitWithdrawLeg: aWithdrawLeg
	^self subclassResponsibility ! !


!classDefinition: #DescriptionVisitor category: 'ServiciosFinancieros'!
AccountTransactionVisitor subclass: #DescriptionVisitor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!DescriptionVisitor methodsFor: 'public' stamp: 'max 6/12/2023 14:00:55'!
visitDeposit: aDeposit
	^'Deposit for ', aDeposit value asString ! !

!DescriptionVisitor methodsFor: 'public' stamp: 'max 6/12/2023 14:09:09'!
visitDepositLeg: aDepositLeg
	^'Entry for transference of ', aDepositLeg value asString
	! !

!DescriptionVisitor methodsFor: 'public' stamp: 'max 6/12/2023 14:01:04'!
visitWithdraw: aWithdraw
	^'Withdraw for ', aWithdraw value asString! !

!DescriptionVisitor methodsFor: 'public' stamp: 'max 6/12/2023 14:09:19'!
visitWithdrawLeg: aWithdrawLeg
	^'Departure for transference of ', aWithdrawLeg value asString! !


!classDefinition: #TransferBalanceVisitor category: 'ServiciosFinancieros'!
AccountTransactionVisitor subclass: #TransferBalanceVisitor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!TransferBalanceVisitor methodsFor: 'public' stamp: 'max 6/12/2023 14:17:47'!
visitDeposit: aDeposit
	^0*peso! !

!TransferBalanceVisitor methodsFor: 'public' stamp: 'max 6/12/2023 14:17:13'!
visitDepositLeg: aDepositLeg
	^aDepositLeg value 
	! !

!TransferBalanceVisitor methodsFor: 'public' stamp: 'max 6/12/2023 14:17:51'!
visitWithdraw: aWithdraw
	^0*peso! !

!TransferBalanceVisitor methodsFor: 'public' stamp: 'max 6/12/2023 14:16:43'!
visitWithdrawLeg: aWithdrawLeg
	^aWithdrawLeg value negated ! !


!classDefinition: #AccountVisitor category: 'ServiciosFinancieros'!
Object subclass: #AccountVisitor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!AccountVisitor methodsFor: 'public' stamp: 'j 6/13/2023 14:50:10'!
visitPortfolio: aPortfolio with: anIndentation

	self subclassResponsibility ! !

!AccountVisitor methodsFor: 'public' stamp: 'j 6/13/2023 14:50:34'!
visitReceptiveAccount: anAccount with: anIndentation

	self subclassResponsibility! !


!classDefinition: #DetailedTreePrinterVisitor category: 'ServiciosFinancieros'!
AccountVisitor subclass: #DetailedTreePrinterVisitor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!DetailedTreePrinterVisitor methodsFor: 'public' stamp: 'j 6/13/2023 14:18:36'!
visitPortfolio: aPortfolio with: anIndentation

	^(String newLineString, anIndentation, ((PortfolioDetailedTreePrinter for: aPortfolio ) printSubTree: (anIndentation, (Character tab asString))))! !

!DetailedTreePrinterVisitor methodsFor: 'public' stamp: 'j 6/13/2023 14:17:14'!
visitReceptiveAccount: anAccount with: anIndentation

	^(String newLineString, anIndentation, anAccount name, (self formatTransactionsOfAccounts: anAccount withIndentatio: (anIndentation, (Character tab asString))))! !


!DetailedTreePrinterVisitor methodsFor: 'private' stamp: 'j 6/13/2023 14:17:48'!
formatTransactionsOfAccounts: anAccount withIndentatio: anIndentation

	| string |
	string := ''.
	
	((AccountSummary for: anAccount) description) do: [:aLine |
		string := (string, String newLineString, anIndentation, aLine).
		].
	
	^string! !


!classDefinition: #TreePrinterVisitor category: 'ServiciosFinancieros'!
AccountVisitor subclass: #TreePrinterVisitor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!TreePrinterVisitor methodsFor: 'public' stamp: 'j 6/13/2023 12:15:42'!
visitPortfolio: aPortfolio with: anIndentation

	^ ((PortfolioTreePrinter for: aPortfolio) printSubTree: (anIndentation, Character tab asString)).! !

!TreePrinterVisitor methodsFor: 'public' stamp: 'j 6/13/2023 12:14:45'!
visitReceptiveAccount: anAccount with: anIndentation

	^(anAccount name)! !


!classDefinition: #Report category: 'ServiciosFinancieros'!
Object subclass: #Report
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: 'ServiciosFinancieros'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'as yet unclassified' stamp: 'j 6/13/2023 14:27:57'!
for: anAccount 
	^self new initializeFor: anAccount ! !


!classDefinition: #AccountSummary category: 'ServiciosFinancieros'!
Report subclass: #AccountSummary
	instanceVariableNames: 'account descriptionVisitor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!AccountSummary methodsFor: 'initialization' stamp: 'max 6/12/2023 14:06:00'!
initializeFor: anAccount 
	account := anAccount.
	descriptionVisitor := DescriptionVisitor new.! !


!AccountSummary methodsFor: 'comparing' stamp: 'max 6/12/2023 14:06:49'!
description

	| descriptionCollection |
	
	descriptionCollection := (account transactions collect: [:aTransaction |
			aTransaction acceptVisitor: descriptionVisitor.
		]) asOrderedCollection.
	descriptionCollection add: 'Balance = ', account balance asString.
	^descriptionCollection 
	! !


!classDefinition: #PortfolioDetailedTreePrinter category: 'ServiciosFinancieros'!
Report subclass: #PortfolioDetailedTreePrinter
	instanceVariableNames: 'portfolio detailedTreePrinterVisitor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!PortfolioDetailedTreePrinter methodsFor: 'initialization' stamp: 'j 6/13/2023 14:19:53'!
initializeFor: aPortfolio 
	
	detailedTreePrinterVisitor := DetailedTreePrinterVisitor new.
	portfolio := aPortfolio.! !


!PortfolioDetailedTreePrinter methodsFor: 'comparing' stamp: 'j 6/13/2023 14:20:50'!
printSubTree: anIndentation
	
	| subTree |
	
	subTree := (portfolio name).

	portfolio iterate: [:anAccount | 
		subTree := (subTree, (anAccount acceptVisitor: detailedTreePrinterVisitor with: anIndentation))
	].
	
	subTree := subTree, String newLineString, anIndentation, 'Balance = ', portfolio balance asString.
	
	^subTree.! !

!PortfolioDetailedTreePrinter methodsFor: 'comparing' stamp: 'j 6/13/2023 12:47:42'!
printTree

	^self printSubTree: Character tab asString.! !


!classDefinition: #PortfolioTreePrinter category: 'ServiciosFinancieros'!
Report subclass: #PortfolioTreePrinter
	instanceVariableNames: 'portfolio treePrinterVisitor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!PortfolioTreePrinter methodsFor: 'initialization' stamp: 'j 6/13/2023 12:37:51'!
initializeFor: aPortfolio 
	
	treePrinterVisitor := TreePrinterVisitor new.
	portfolio := aPortfolio.! !


!PortfolioTreePrinter methodsFor: 'comparing' stamp: 'j 6/13/2023 12:15:42'!
printSubTree: anIndentation
	
	| subTree |
	
	subTree := (portfolio name).

	portfolio iterate: [:anAccount | 
		subTree := (subTree, String newLineString, anIndentation, (anAccount acceptVisitor: treePrinterVisitor with: anIndentation))
	].

	^subTree.! !

!PortfolioTreePrinter methodsFor: 'comparing' stamp: 'j 6/13/2023 12:15:42'!
printTree

	^self printSubTree: Character tab asString.! !


!classDefinition: #TransferNet category: 'ServiciosFinancieros'!
Report subclass: #TransferNet
	instanceVariableNames: 'account transferBalanceVisitor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!TransferNet methodsFor: 'initialization' stamp: 'max 6/12/2023 14:20:53'!
initializeFor: anAccount 
	account := anAccount.
	transferBalanceVisitor := TransferBalanceVisitor new.! !


!TransferNet methodsFor: 'comparing' stamp: 'max 6/12/2023 14:23:23'!
value
	
	| transferBalance |
	transferBalance := 0.
	account transactions do: [:aTransaction |
		transferBalance  := transferBalance + (aTransaction acceptVisitor: transferBalanceVisitor).
		 ].
	^transferBalance! !


!classDefinition: #Transfer category: 'ServiciosFinancieros'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!Transfer methodsFor: 'value' stamp: 'LL 9/20/2020 21:13:00'!
value

	^value! !


!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:39:46'!
depositLeg

	^depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 21:25:56'!
withdrawLeg
	
	^withdrawLeg! !


!Transfer methodsFor: 'initialization' stamp: 'LL 9/20/2020 21:25:21'!
initializeWith: aValue withdrawLeg: aWithdraw depositLeg: aDeposit

	value := aValue.
	withdrawLeg := aWithdraw.
	depositLeg := aDeposit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:57:30'!
cannotTransferToOriginErrorDescription
	
	^'Transfer destionation cannot be the origin account'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:00:53'!
cannotTransferZeroErrorDescription

	^'Transfer amount should be positive'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:56:35'!
signalCannotTransferToOrigin
	
	self error: self cannotTransferToOriginErrorDescription! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:06:17'!
signalCannotTransferZero

	self error: self cannotTransferZeroErrorDescription! !


!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:05:22'!
assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount

	self assertCanTransferTo: destinationAccount from: originAccount.
	self assertCanTransfer: anAmountOfMoney! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:11:50'!
assertCanTransfer: anAmountOfMoney

	^ anAmountOfMoney isZero ifTrue: [ self signalCannotTransferZero ]! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:04:58'!
assertCanTransferTo: destinationAccount from: originAccount

	^ originAccount = destinationAccount ifTrue: [ self signalCannotTransferToOrigin ]! !


!Transfer class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 23:11:34'!
amount: anAmountOfMoney from: originAccount to: destinationAccount 
	
	| transfer depositLeg withdrawLeg |
	
	self assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount.
	
	transfer := self new.
	
	withdrawLeg := TransferWithdrawLeg of: transfer on: originAccount.
	depositLeg := TransferDepositLeg of: transfer on: destinationAccount.
	
	^transfer initializeWith: anAmountOfMoney withdrawLeg: withdrawLeg depositLeg: depositLeg
	
	
	! !


!classDefinition: #PortfolioTest category: 'ServiciosFinancieros'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:00'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:06'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:12'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100 * peso))! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:18'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:26'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:08'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 * peso on: account.
	anotherAccountWithdraw := Withdraw register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:43'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:20'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:24'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:22'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:14'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:23'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #ReportTest category: 'ServiciosFinancieros'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!ReportTest methodsFor: 'transfer net' stamp: 'max 6/11/2023 12:39:39'!
test06TransferNetForAccountWithNoTransfersIsZero
	
	| account transferNet |
	account := ReceptiveAccount new.
	transferNet := TransferNet for: account.
	self assert: transferNet value equals: 0*peso.! !

!ReportTest methodsFor: 'transfer net' stamp: 'max 6/11/2023 12:41:24'!
test07TransferNetForAccountWithDepositLeg
	
	| account transferNet account2 |
	account := ReceptiveAccount new.
	account2 := (ReceptiveAccount new) register: (Deposit for: 100*peso).
	Transfer amount: 100*peso from: account2 to: account.
	transferNet := TransferNet for: account.
	self assert: transferNet value equals: 100*peso.! !

!ReportTest methodsFor: 'transfer net' stamp: 'max 6/11/2023 12:55:44'!
test08TransferNetForAccountWithWithdrawLeg
	
	| account transferNet account2 |
	account := ReceptiveAccount new.
	account2 := (ReceptiveAccount new) register: (Deposit for: 100*peso).
	Transfer amount: 100*peso from: account2 to: account.
	transferNet := TransferNet for: account2.
	self assert: transferNet value equals: -100*peso.! !


!ReportTest methodsFor: 'portfolio tree printer' stamp: 'j 6/13/2023 14:32:37'!
test09TreePrinterWithEmptyPortfolioOnlyShowsItsName
	
	| portfolio portfolioTreePrinter |
	portfolio := Portfolio named: 'Portfolio del cringe'.
	portfolioTreePrinter := PortfolioTreePrinter for: portfolio.
	self assert: 'Portfolio del cringe' equals: (portfolioTreePrinter printTree).! !

!ReportTest methodsFor: 'portfolio tree printer' stamp: 'j 6/13/2023 14:32:54'!
test10TreePrinterWithPortfolioWithAnAccount
	
	| portfolio portfolioTreePrinter account expected actual |
	
	portfolio := Portfolio named: 'Portfolio del cringe'.
	account := ReceptiveAccount named: 'Cuenta del cringe'.
	portfolio add: account.
	portfolioTreePrinter := PortfolioTreePrinter for: portfolio.
	
	expected := 
'Portfolio del cringe
	Cuenta del cringe'.
	
	actual := portfolioTreePrinter printTree.
		
	self assert: expected equals: actual.! !

!ReportTest methodsFor: 'portfolio tree printer' stamp: 'j 6/13/2023 14:33:00'!
test11TreePrinterWithPortfolioWithNestedPortfolioWithAnAccount
	
	| portfolioTreePrinter expected actual childPortfolio parentPortfolio account |
	
	parentPortfolio := Portfolio named: 'Portfolio padre'.
	childPortfolio := Portfolio named: 'Portfolio hijos'.
	
	account := ReceptiveAccount named: 'Cuenta Tomas'.
	
	childPortfolio  add: account.
	parentPortfolio add: childPortfolio.
	
	expected := 
'Portfolio padre
	Portfolio hijos
		Cuenta Tomas'.
			
	portfolioTreePrinter := PortfolioTreePrinter for: parentPortfolio.
			
	actual := portfolioTreePrinter printTree.
	
	self assert: expected equals: actual.! !

!ReportTest methodsFor: 'portfolio tree printer' stamp: 'j 6/13/2023 14:33:09'!
test12TreePrinterWithMultipleNestedPortfoliosAndAccounts
	
	| portfolioTreePrinter expected actual javierAccount tomasPortfolio childrenPortfolios parentPortfolio tomasAccount javierAccount2 |
	
	parentPortfolio := Portfolio named: 'Portfolio padre'.
	childrenPortfolios := Portfolio named: 'Portfolio hijos'.
	tomasPortfolio := Portfolio named: 'Portfolio hijo tomas'.
	
	javierAccount := ReceptiveAccount named: 'Cuenta Javier'.
	javierAccount2 := ReceptiveAccount named: 'Cuenta Javier2'.
	tomasAccount := ReceptiveAccount named: 'Cuenta Tomas'.
	
	tomasPortfolio add: tomasAccount.
	childrenPortfolios  add: tomasPortfolio.
	parentPortfolio add: childrenPortfolios.
	parentPortfolio add: javierAccount.
	parentPortfolio add: javierAccount2.
	
	expected := 
'Portfolio padre
	Portfolio hijos
		Portfolio hijo tomas
			Cuenta Tomas
	Cuenta Javier
	Cuenta Javier2'.
			
	portfolioTreePrinter := PortfolioTreePrinter for: parentPortfolio.
			
	actual := portfolioTreePrinter printTree.
	
	self assert: expected equals: actual.! !


!ReportTest methodsFor: 'account summary' stamp: 'j 12/23/2025 19:43:26'!
test01SummaryOfEmptyAccountHasBalanceZero
	
	| account summary |
	account := ReceptiveAccount new.
	summary := AccountSummary for: account.
	self assert: (summary description) equals: ({'Balance = 0 * peso'} asOrderedCollection).! !

!ReportTest methodsFor: 'account summary' stamp: 'j 12/23/2025 19:44:01'!
test02SummaryOfAccountWithOneDeposit
	
	| account summary str |
	account := ReceptiveAccount new.
	Deposit register: 100*peso on: account.
	summary := AccountSummary for: account.
	str := summary description .
	self assert: (summary description) equals: ({'Deposit for 100 * peso'. 'Balance = 100 * peso'} asOrderedCollection).! !

!ReportTest methodsFor: 'account summary' stamp: 'j 12/23/2025 19:44:19'!
test03SummaryOfAccountWithOneWithdraw
	"
	Cuando el balance es negativo y se le pide asString da algo asi: ( '-100*pesos+0' )
	como agrega +0 al final por alguna razon, tuvimos que agregarlo en el string esperado.
	"
	| account summary |
	account := ReceptiveAccount new.
	Withdraw register: 100*peso on: account.
	summary := AccountSummary for: account.
	self assert: (summary description) equals: ({'Withdraw for 100 * peso'. 'Balance = -100 * peso'} asOrderedCollection).! !

!ReportTest methodsFor: 'account summary' stamp: 'j 12/23/2025 19:44:29'!
test04SummaryOfAccountWithOneDepositLeg

	| account summary account2 |
	
	account := ReceptiveAccount new.
	account2 := (ReceptiveAccount new) register: (Deposit for: 100*peso).
	Transfer amount: 100*peso from: account2 to: account.
	summary := AccountSummary for: account.
	self assert: (summary description) equals: ({'Entry for transference of 100 * peso'. 'Balance = 100 * peso'} asOrderedCollection).! !

!ReportTest methodsFor: 'account summary' stamp: 'j 12/23/2025 19:44:47'!
test05SummaryOfAccountWithOneWithdrawLeg

	| account summary account2 |
	
	account := ReceptiveAccount new.
	account2 := (ReceptiveAccount new) register: (Deposit for: 100*peso).
	Transfer amount: 100*peso from: account2 to: account.
	summary := AccountSummary for: account2.
	self assert: (summary description) equals: ({'Deposit for 100 * peso'. 'Departure for transference of 100 * peso'. 'Balance = 0 * peso'} asOrderedCollection).! !


!ReportTest methodsFor: 'portfolio detail tree printer' stamp: 'j 12/23/2025 19:44:57'!
test13DetailedTreePrinterWithEmptyPortfolioOnlyShowsItsNameAndBalance

	| actual detailedTreePrinter expected portfolio |
	
	portfolio := Portfolio named: 'Portfolio del cringe'.
	
	detailedTreePrinter := PortfolioDetailedTreePrinter for: portfolio.
	
	expected := 
'Portfolio del cringe
	Balance = 0 * peso'.
	
	actual := detailedTreePrinter printTree.
	
	self assert: expected equals: actual.



	! !

!ReportTest methodsFor: 'portfolio detail tree printer' stamp: 'j 12/23/2025 19:45:09'!
test14DetailedTreePrinterWithPortfolioWithAnAccount
	
	| portfolio detailTreePrinter account expected actual |
	
	portfolio := Portfolio named: 'Portfolio del cringe'.
	account := ReceptiveAccount named: 'Cuenta del cringe'.
	portfolio add: account.
	detailTreePrinter := PortfolioDetailedTreePrinter for: portfolio.
	
	expected := 
'Portfolio del cringe
	Cuenta del cringe
		Balance = 0 * peso
	Balance = 0 * peso'.
	
	actual := detailTreePrinter printTree.
		
	self assert: expected equals: actual.! !

!ReportTest methodsFor: 'portfolio detail tree printer' stamp: 'j 12/23/2025 19:45:22'!
test15DetailedTreePrinterWithPortfolioWithAnAccountWithTransactions
	
	| portfolio detailTreePrinter account expected actual |
	
	portfolio := Portfolio named: 'Portfolio del cringe'.
	account := ((ReceptiveAccount named: 'Cuenta del cringe') register: (Deposit for: (100*peso))).
	portfolio add: account.
	detailTreePrinter := PortfolioDetailedTreePrinter for: portfolio.
	
	expected := 
'Portfolio del cringe
	Cuenta del cringe
		Deposit for 100 * peso
		Balance = 100 * peso
	Balance = 100 * peso'.
	
	actual := detailTreePrinter printTree.
		
	self assert: expected equals: actual.! !

!ReportTest methodsFor: 'portfolio detail tree printer' stamp: 'j 12/23/2025 19:45:49'!
test16DetailedTreePrinterWithMultipleNestedPortfoliosAndAccounts
	
	| detailedTreePrinter expected actual javierAccount childrenPortfolios parentPortfolio tomasAccount |
	
	parentPortfolio := Portfolio named: 'Portfolio padre'.
	childrenPortfolios := Portfolio named: 'Portfolio hijos'.
	
	javierAccount := ReceptiveAccount named: 'Cuenta Javier'.
	tomasAccount := (((ReceptiveAccount named: 'Cuenta Tomas') register: (Deposit for: 100*peso)) register: (Withdraw for: 50*peso)).
	
	childrenPortfolios  add: tomasAccount.
	parentPortfolio add: childrenPortfolios.
	parentPortfolio add: javierAccount.
	
	expected := 
'Portfolio padre
	Portfolio hijos
		Cuenta Tomas
			Deposit for 100 * peso
			Withdraw for 50 * peso
			Balance = 50 * peso
		Balance = 50 * peso
	Cuenta Javier
		Balance = 0 * peso
	Balance = 50 * peso'.
			
	detailedTreePrinter := PortfolioDetailedTreePrinter for: parentPortfolio.
			
	actual := detailedTreePrinter printTree.
	
	self assert: expected equals: actual.! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 21:07:03'!
test01ATransferDecreasesBalanceFromOriginAccountAndIncreasesItForDestinationAccount

	| destinationAccount originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 8 * peso equals: originAccount balance.
	self assert: 12 * peso equals: destinationAccount balance.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 21:12:28'!
test02ATransferKnowsItsValue

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 2 * peso equals: transfer value.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:01:44'!
test03DepositLegKnowsItsWithdrawCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer withdrawLeg equals: transfer depositLeg withdrawLeg! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:01:51'!
test04WithdrawLegKnowsItsDepositCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer depositLeg equals: transfer withdrawLeg depositLeg! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:02:36'!
test05OriginAndDestinationAccountsCannotBeTheSame

	| originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	self should: [ Transfer amount: 2 * peso from: originAccount to: originAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferToOriginErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:02:44'!
test06CannotTransferAZeroAmount

	| originAccount destinationAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 5 * peso on: destinationAccount.
	
	self should: [ Transfer amount: 0 from: originAccount to: destinationAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferZeroErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !
(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 124 112 122 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 124 112 122 99 74 124 112 122 92 117 112 125 108 121 122 112 123 128 52 62 61 59 56 53 112 116 104 110 108 17 94 112 117 58 57 17 61 53 57 17 95 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 100 17 94 112 117 107 118 126 122 17 94 112 117 58 57 39 105 124 112 115 123 39 118 117 39 84 104 121 39 39 56 39 57 55 57 60 39 55 56 65 55 59 65 57 57 39 78 84 91 39 74 118 116 119 112 115 108 121 65 39 59 53 57 53 56 39 74 118 116 119 104 123 112 105 115 108 39 74 115 104 117 110 39 63 53 55 53 56 39 47 123 104 110 122 54 89 76 83 76 72 90 76 102 63 55 56 54 109 112 117 104 115 48 17 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 84 104 121 39 39 56 39 57 55 57 60 17 83 112 125 108 91 128 119 112 117 110 74 118 110 112 123 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 84 104 121 39 39 56 39 57 55 57 60 17 93 84 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 39 75 104 123 108 65 39 84 118 117 39 86 106 123 39 61 39 56 57 65 58 59 65 57 56 39 57 55 57 60 39 74 118 116 116 112 123 79 104 122 111 65 39 108 107 58 60 59 63 61 39 87 115 124 110 112 117 122 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 17 179 38 135 8 17 56 62 57 53 58 56 53 56 57 63 53 56 17 75 76 90 82 91 86 87 52 63 85 61 64 60 76 82 53 116 122 111 118 116 108 53 117 108 123 17 75 76 90 82 91 86 87 52 63 85 61 64 60 76 82 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 57 56 91 57 57 65 59 63 65 58 62 53 59 64 62 60 62 60 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 118 107 112 110 118 52 121 108 119 108 123 112 107 118 52 110 121 124 119 118 52 58 57 99 74 118 107 112 110 118 89 108 119 108 123 112 107 118 52 76 113 108 121 106 112 106 112 118 53 122 123 17 62 63 58 63 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 57 56 91 57 58 65 60 57 65 57 55 53 55 60 55 60 62 60 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 121 108 119 104 122 118 122 99 121 108 119 104 122 118 52 57 55 57 58 52 56 106 52 57 107 118 87 104 121 106 112 104 115 99 72 115 110 118 80 80 80 52 57 55 57 58 52 56 74 52 57 87 104 121 106 112 104 115 52 74 118 116 105 104 123 112 108 117 123 108 122 77 104 117 123 104 122 123 112 106 118 122 52 87 59 53 80 117 112 106 112 104 115 53 122 123 17 59 58 60 64 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 57 58 91 56 64 65 57 56 65 57 61 53 63 59 57 62 64 62 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 121 108 119 104 122 118 122 99 57 55 57 58 52 56 106 52 57 107 118 87 104 121 106 112 104 115 99 72 115 110 118 80 80 80 52 57 55 57 58 52 56 74 52 57 87 104 121 106 112 104 115 52 74 118 116 105 104 123 112 108 117 123 108 122 77 104 117 123 104 122 123 112 106 118 122 52 87 59 53 90 118 115 124 106 112 118 117 53 122 123 17 61 57 64 58 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 57 58 91 56 64 65 57 62 65 55 58 53 55 56 60 62 64 62 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 124 112 122 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 72 115 110 118 80 80 80 52 57 55 57 58 52 56 74 52 57 87 104 121 106 112 104 115 52 74 118 116 105 104 123 112 108 117 123 108 122 77 104 117 123 104 122 123 112 106 118 122 52 87 59 53 58 53 122 123 17 61 60 56 59 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 57 59 65 56 61 53 57 62 56 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 56 106 57 55 57 58 52 52 52 122 108 121 125 112 106 112 118 122 52 109 112 117 104 117 106 112 108 121 118 122 52 57 52 110 121 124 119 118 52 58 57 99 90 108 121 125 112 106 112 118 122 77 112 117 104 117 106 112 108 121 118 122 52 90 118 115 124 106 112 118 117 53 122 123 17 59 63 57 61 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 57 60 65 56 61 53 61 61 64 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 124 112 122 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 90 108 121 125 112 106 112 118 122 77 112 117 104 117 106 112 108 121 118 122 52 90 118 115 124 106 112 118 117 53 56 53 122 123 17 60 60 60 60 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 57 62 65 58 64 53 63 59 60 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 124 112 122 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 93 112 122 112 123 118 121 102 119 104 123 123 108 121 117 52 56 53 122 123 17 56 55 55 61 62 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 59 57 65 60 61 53 58 56 58 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 124 112 122 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 72 115 110 118 80 80 80 52 57 55 57 58 52 56 74 52 57 87 104 121 106 112 104 115 52 74 118 116 105 104 123 112 108 117 123 108 122 77 104 117 123 104 122 123 112 106 118 122 52 87 59 53 58 53 122 123 17 61 60 56 59 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 59 59 65 56 58 53 62 63 59 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 124 112 122 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 72 115 110 118 80 80 80 52 57 55 57 58 52 56 74 52 57 87 104 121 106 112 104 115 52 74 118 116 105 104 123 112 108 117 123 108 122 77 104 117 123 104 122 123 112 106 118 122 52 87 59 53 58 53 122 123 17 61 60 56 59 55 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 59 61 65 57 57 53 63 55 56 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 110 112 123 102 121 108 119 118 122 99 87 118 121 123 109 118 115 112 118 99 87 121 118 110 121 104 116 104 106 112 118 117 102 118 121 112 108 117 123 104 107 104 102 104 102 118 105 113 108 123 118 122 102 108 117 102 122 116 104 115 115 123 104 115 114 99 74 118 116 105 104 123 112 108 117 123 108 122 77 104 117 123 104 122 123 112 106 118 122 53 122 123 17 61 64 64 57 62 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 60 58 65 57 60 53 62 59 62 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 124 112 122 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 90 108 121 125 112 106 112 118 122 77 112 117 104 117 106 112 108 121 118 122 52 90 118 115 124 106 112 118 117 53 56 53 122 123 17 60 60 60 60 56 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 57 58 91 56 64 65 57 55 65 57 62 53 59 56 61 62 64 62 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 119 118 121 123 109 118 115 112 118 99 72 115 110 118 39 58 99 106 124 112 122 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 72 115 110 118 80 80 80 52 57 55 57 58 52 56 74 52 57 87 104 121 106 112 104 115 52 74 118 116 105 104 123 112 108 117 123 108 122 77 104 117 123 104 122 123 112 106 118 122 52 87 59 53 58 53 122 123 17 61 55 57 64 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 59 60 65 60 55 53 58 63 61 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 110 112 123 102 121 108 119 118 122 99 87 118 121 123 109 118 115 112 118 99 87 121 118 110 121 104 116 104 106 112 118 117 102 118 121 112 108 117 123 104 107 104 102 104 102 118 105 113 108 123 118 122 102 108 117 102 122 116 104 115 115 123 104 115 114 99 74 118 116 105 104 123 112 108 117 123 108 122 77 104 117 123 104 122 123 112 106 118 122 53 122 123 17 61 55 57 64 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 59 64 65 57 55 53 58 55 56 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 110 112 123 102 121 108 119 118 122 99 87 118 121 123 109 118 115 112 118 99 87 121 118 110 121 104 116 104 106 112 118 117 102 118 121 112 108 117 123 104 107 104 102 104 102 118 105 113 108 123 118 122 102 108 117 102 122 116 104 115 115 123 104 115 114 99 74 118 116 105 104 123 112 108 117 123 108 122 77 104 117 123 104 122 123 112 106 118 122 102 56 53 122 123 17 60 64 55 64 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 56 52 55 59 91 57 55 65 60 60 65 55 62 53 58 55 61 63 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 104 125 112 106 99 75 108 122 114 123 118 119 99 91 121 104 105 104 113 118 99 110 112 123 102 121 108 119 118 122 99 87 118 121 123 109 118 115 112 118 99 87 121 118 110 121 104 116 104 106 112 118 117 102 118 121 112 108 117 123 104 107 104 102 104 102 118 105 113 108 123 118 122 102 108 117 102 122 116 104 115 115 123 104 115 114 99 90 108 121 125 112 106 112 118 122 77 112 117 104 117 106 112 108 121 118 122 53 122 123 17 59 62 62 58 55 17 52 52 52 52 52 52 52 52 52 52 17 17))!