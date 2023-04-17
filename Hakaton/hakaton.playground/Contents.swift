

// Абстракция данных пользователя
protocol UserData {
  var userName: String { get }    //Имя пользователя
  var userCardId: String { get }   //Номер карты
  var userCardPin: Int { get }       //Пин-код
  var userPhone: String { get }       //Номер телефона
  var userCash: Float { get set }   //Наличные пользователя
  var userBankDeposit: Float { get set }   //Банковский депозит
  var userPhoneBalance: Float { get set }    //Баланс телефона
  var userCardBalance: Float { get set }    //Баланс карты
}
 
// Действия, которые пользователь может выбирать в банкомате (имитация кнопок)
enum UserActions {
    case showUserCardBalance // Проверка баланса карты
    case showUserDepositBalance // Проверка баланса банковского депозита
    case getCashFromCard (cash: Float) // Снять наличные с карты
    case getCashFromDeposit (cash: Float) // Снять наличные с банковского депозита
    case putCashCard (cash: Float) // Пополнение карты наличными
    case putCashDeposit (cash: Float) // Пополнение банковского депозита наличными
    case topUpMobilePhone (pay: Float, method: PaymentMethod) // пополнение телефона
}

// Виды операций, выбранных пользователем (подтверждение выбора)
enum DescriptionTypesAvailableOperations: String {
    case showUserCardBalance = "Проверка баланса карты"
    case showUserDepositBalance = "Проверка баланса банковского депозита"
    case getCashFromCard = "Снять наличные с карты"
    case getCashFromDeposit = "Снять наличные с банковского депозита"
    case putCashCard = "Пополнение карты наличными"
    case putCashDeposit = "Пополнение банковского депозита наличными"
    case topUpMobilePhoneByCash = "Пополнение баланса телефона наличными"
    case topUpMobilePhoneByCard = "Пополнение баланса телефона с карты"
    case topUpMobilePhoneByDeposit = "Пополнение баланса телефона с банковского депозита"
}
 
// Способ оплаты/пополнения наличными, картой или через депозит
enum PaymentMethod {
    case byCash
    case byCard
    case byDeposit
}

// Тексты ошибок
enum TextErrors: String {
    case notEnoughCash = "Недостаточно наличных денег"
    case notEnoughMoneyOnCard = "Недостаточно денег на карте"
    case notEnoughMoneyOnDeposit = "Недостаточно денег на депозите"
    case userCardIdOrPinError = "Неверный номер карты или пинкод"
    case incorrectAmountOfMoney = "Неверная сумма"
}

// Протокол по работе с банком предоставляет доступ к данным пользователя зарегистрированного в банке
protocol BankApi {
    func showUserCardBalance()
    func showUserDepositBalance()
    func showUserToppedUpMobilePhoneCash(cash: Float)
    func showUserToppedUpMobilePhoneCard(card: Float)
    func showWithdrawalCard(cash: Float)
    func showWithdrawalDeposit(cash: Float)
    func showTopUpCard(cash: Float)
    func showTopUpDeposit(cash: Float)
    func showError(error: TextErrors)
 
    func checkUserPhone(phone: String) -> Bool
    func checkMaxUserCash(cash: Float) -> Bool
    func checkMaxUserCard(withdraw: Float) -> Bool
    func checkCurrentUser(userCardId: String, userCardPin: Int) -> Bool
 
    mutating func topUpPhoneBalanceCash(pay: Float)
    mutating func topUpPhoneBalanceCard(pay: Float)
    mutating func topUpPhoneBalanceDeposit(pay: Float)
    func getCashFromDeposit(cash: Float)
    mutating func getCashFromCard(cash: Float)
    mutating func putCashDeposit(topUp: Float)
    mutating func putCashCard(topUp: Float)
}


// Банкомат, с которым мы работаем, имеет общедоступный интерфейс sendUserDataToBank
class ATM {
    private let userCardId: String
    private let userCardPin: Int
    private var someBank: BankApi
  
 
    init(userCardId: String, userCardPin: Int, someBank: BankApi) {
        self.userCardId = userCardId
        self.userCardPin = userCardPin
        self.someBank = someBank
  }
 
 
    public final func sendUserDataToBank(actions: UserActions, payment: PaymentMethod? = nil) {
        
        if someBank.checkCurrentUser(userCardId: userCardId, userCardPin: userCardPin) {
            switch actions {
                
            case .showUserCardBalance:
                print("Вы выбрали операцию: \(DescriptionTypesAvailableOperations.showUserCardBalance.rawValue).")
                someBank.showUserCardBalance()
                
            case .showUserDepositBalance:
                print("Вы выбрали операцию: \(DescriptionTypesAvailableOperations.showUserDepositBalance.rawValue).")
                someBank.showUserDepositBalance()
                
            case .getCashFromCard(cash: let cash):
                print("Вы выбрали операцию: \(DescriptionTypesAvailableOperations.getCashFromCard.rawValue) в размере \(cash) рублей.")
                someBank.getCashFromCard(cash: cash)
                
            case .getCashFromDeposit(cash: let cash):
                print("Вы выбрали операцию: \(DescriptionTypesAvailableOperations.getCashFromDeposit.rawValue) в размере \(cash) рублей.")
                someBank.getCashFromDeposit(cash: cash)
                
            case .putCashCard(cash: let cash):
                print("Вы выбрали операцию: \(DescriptionTypesAvailableOperations.putCashCard.rawValue) на \(cash) рублей.")
                someBank.putCashCard(topUp: cash)
                
            case .putCashDeposit(cash: let cash):
                print("Вы выбрали операцию: \(DescriptionTypesAvailableOperations.putCashDeposit.rawValue) на \(cash) рублей.")
                someBank.putCashDeposit(topUp: cash)
                
            case .topUpMobilePhone(pay: let pay, method: let method):
                switch method {
                case .byCard:
                    print("Вы выбрали операцию: \(DescriptionTypesAvailableOperations.topUpMobilePhoneByCard.rawValue) на \(pay) рублей.")
                    someBank.topUpPhoneBalanceCard(pay: pay)
                    
                case .byDeposit:
                    print("Вы выбрали операцию: \(DescriptionTypesAvailableOperations.topUpMobilePhoneByDeposit.rawValue) на \(pay) рублей.")
                    someBank.topUpPhoneBalanceDeposit(pay: pay)
                    
                case .byCash:
                    print("Вы выбрали операцию: \(DescriptionTypesAvailableOperations.topUpMobilePhoneByCash.rawValue) на \(pay) рублей.")
                    someBank.topUpPhoneBalanceCash(pay: pay)
                    }
        }
        }}}
 


// Создаем класс Пользователь конформящий протокол UserData

class User: UserData {
    var userName: String
    var userCardId: String
    var userCardPin: Int
    var userPhone: String
    var userCash: Float
    var userBankDeposit: Float
    var userPhoneBalance: Float
    var userCardBalance: Float
    
    init(userName: String, userCardId: String, userCardPin: Int, userPhone: String, userCash: Float, userBankDeposit: Float, userPhoneBalance: Float, userCardBalance: Float){
        self.userName = userName
        self.userCardId = userCardId
        self.userCardPin = userCardPin
        self.userPhone = userPhone
        self.userCash = userCash
        self.userBankDeposit = userBankDeposit
        self.userPhoneBalance = userPhoneBalance
        self.userCardBalance = userCardBalance
    }
}


// Создаем класс Банк конформящий протокол BankAPI
class Bank: BankApi {
 
    var users: [User] = []
    var currentUser: User?
    
    // проверка баланса карты
    func showUserCardBalance() {
            print("Баланс вашей карты \(currentUser!.userCardBalance) рублей.")
    }
    
    // Проверка баланса депозита
    func showUserDepositBalance() {
            print("Баланс вашего депозита \(currentUser!.userBankDeposit) рублей.")
    }
    
    // Информация о пополнении баланса телефона наличными
    func showUserToppedUpMobilePhoneCash(cash: Float) {
        print("Вы пополнили баланс телефона наличными на \(cash) рублей.")
    }
    
    // Информация о пополнении баланса телефона с карты
    func showUserToppedUpMobilePhoneCard(card: Float) {
        print("Вы пополнили баланс телефона с карты на \(card) рублей.")
    }
    
    // Информация о пополнении баланса телефона с депозита
    func showUserToppedUpMobilePhoneDeposit(deposit: Float) {
        print("Вы пополнили баланс телефона с депозита на \(deposit) рублей.")
    }
    
    // Информация о снятии денег с карты
    func showWithdrawalCard(cash: Float) {
        print("Вы сняли \(cash) рублей наличными с карты.")
    }
    
    // Информация о снятии денег с депозита
    func showWithdrawalDeposit(cash: Float) {
        print("Вы сняли \(cash) рублей наличными с депозита.")
    }
    
    // Информация о пополнении карты
    func showTopUpCard(cash: Float) {
        print("Вы пополнили карту наличными на \(cash) рублей.")
    }
    
    // Информация о пополнении депозита
    func showTopUpDeposit(cash: Float) {
        print("Вы пополнили депозит наличными на \(cash) рублей.")
    }
    
    // Отображаем описание ошибки
    func showError(error: TextErrors) {
        print(error.rawValue)
    }
    
    // проверяем телефон пользователя
    func checkUserPhone(phone: String) -> Bool {
        if phone == currentUser!.userPhone {
            return true
        } else {
            return false
        }
    }
    
    // проверяем достаточно ли наличных
    func checkMaxUserCash(cash: Float) -> Bool {
        if cash <= currentUser!.userCash {
            return true
        } else {
            return false
        }
    }
    
    // проверяем достаточно ли денег на карте
    func checkMaxUserCard(withdraw: Float) -> Bool {
        if withdraw <= currentUser!.userCardBalance {
            return true
        } else {
            return false
        }
    }
    // проверяем достаточно ли денег на депозите
    func checkMaxUserDeposit(withdraw: Float) -> Bool {
        if withdraw <= currentUser!.userBankDeposit {
            return true
        } else {
            return false
        }
    }
    
    // проверяем пользователя
    func checkCurrentUser(userCardId: String, userCardPin: Int) -> Bool {
        var statement: Bool = false
        for user in users {
            if (userCardId == user.userCardId) && (userCardPin == user.userCardPin) {
            currentUser = user
            statement = true
            break
            }
        }
        if statement == false {
            showError(error: .userCardIdOrPinError)
        }
        return statement
    }
    
    //пополнение баланса телефона наличными
    func topUpPhoneBalanceCash(pay: Float) {
        if pay > 0 {
            if !checkMaxUserCash(cash: pay) {
            showError(error: .notEnoughCash)
            } else {
            currentUser!.userCash -= pay
            currentUser!.userPhoneBalance += pay
            showUserToppedUpMobilePhoneCash(cash: pay)
            }
        } else {
            showError(error: .incorrectAmountOfMoney)
        }
    }
    
    // пополнение баланса телефона с карты
    func topUpPhoneBalanceCard(pay: Float) {
        if pay > 0 {
            if !checkMaxUserCard(withdraw: pay) {
            showError(error: .notEnoughMoneyOnCard)
            } else {
            currentUser!.userCardBalance -= pay
            currentUser!.userPhoneBalance += pay
            showUserToppedUpMobilePhoneCard(card: pay)
            }
        } else {
            showError(error: .incorrectAmountOfMoney)
        }
    }
    
    // пополнение баланса телефона с депозита
    func topUpPhoneBalanceDeposit(pay: Float) {
        if pay > 0 {
            if !checkMaxUserDeposit(withdraw: pay) {
            showError(error: .notEnoughMoneyOnDeposit)
            } else {
            currentUser!.userBankDeposit -= pay
            currentUser!.userBankDeposit += pay
            showUserToppedUpMobilePhoneDeposit(deposit: pay)
            }
        } else {
            showError(error: .incorrectAmountOfMoney)
        }
    }
    
    // снятие наличных с депозита
    func getCashFromDeposit(cash: Float) {
        if cash > 0 {
            if !checkMaxUserDeposit(withdraw: cash) {
            showError(error: .notEnoughMoneyOnDeposit)
            } else {
            currentUser!.userBankDeposit -= cash
            currentUser!.userCash += cash
            showWithdrawalDeposit(cash: cash)
            }
        } else {
            showError(error: .incorrectAmountOfMoney)
        }
    }
    
    // снятие наличных с карты
    func getCashFromCard(cash: Float) {
        if cash > 0 {
            if !checkMaxUserCard(withdraw: cash) {
            showError(error: .notEnoughMoneyOnCard)
            } else {
            currentUser!.userCardBalance -= cash
            currentUser!.userCash += cash
            showWithdrawalCard(cash: cash)
            }
        } else {
            showError(error: .incorrectAmountOfMoney)
        }
    }
    
    // пополнение депозита наличными
    func putCashDeposit(topUp: Float) {
        if topUp > 0 {
            if !checkMaxUserCash(cash: topUp) {
            showError(error: .notEnoughCash)
            } else {
            currentUser!.userCash -= topUp
            currentUser!.userBankDeposit += topUp
            showTopUpDeposit(cash: topUp)
            }
        } else {
            showError(error: .incorrectAmountOfMoney)
        }
    }
    
    // пополнение карты наличными
    func putCashCard(topUp: Float) {
        if topUp > 0 {
            if !checkMaxUserCash(cash: topUp) {
            showError(error: .notEnoughCash)
            } else {
            currentUser!.userCash -= topUp
            currentUser!.userCardBalance += topUp
            showTopUpCard(cash: topUp)
            }
        } else {
            showError(error: .incorrectAmountOfMoney)
        }
    }
}


//---------------------------------------------------------------
//  Создаем элементы классов и проверяем доступные действия
//---------------------------------------------------------------



// Создаем элементы класса  User
let userOne = User(userName: "Sidorov Petya", userCardId: "4276-1415-2382-7615", userCardPin: 5674, userPhone: "+7(989)-663-63-07", userCash: 3245.98, userBankDeposit: 234.55, userPhoneBalance: 5.89, userCardBalance: 2347.90)

let userTwo = User(userName: "Ivanov Ilya", userCardId: "2387-9045-2458-9479", userCardPin: 3345, userPhone: "+7(987)-334-45-45", userCash: 456.7, userBankDeposit: 333.45, userPhoneBalance: 848, userCardBalance: 5000)


// Создаем элемент класса Bank
let someBank = Bank()

// Добавляем пользователей в элемент класса Bank
someBank.users.append(userOne)
someBank.users.append(userTwo)


// Создаем элемент класса ATM
let someATM = ATM(userCardId: "4276-1415-2382-7615", userCardPin: 5674, someBank: someBank)


// Проверяем доступные действия
someATM.sendUserDataToBank(actions: .showUserCardBalance)
print("------------------------")
someATM.sendUserDataToBank(actions: .showUserDepositBalance)
print("------------------------")
someATM.sendUserDataToBank(actions: .getCashFromCard(cash: 100))
print("------------------------")
someATM.sendUserDataToBank(actions: .getCashFromDeposit(cash: 200))
print("------------------------")
someATM.sendUserDataToBank(actions: .putCashCard(cash: 120))
print("------------------------")
someATM.sendUserDataToBank(actions: .putCashDeposit(cash: 21000))
print("------------------------")
someATM.sendUserDataToBank(actions: .topUpMobilePhone(pay: 12, method: .byDeposit))
print("------------------------")
someATM.sendUserDataToBank(actions: .topUpMobilePhone(pay: 13, method: .byCard))
print("------------------------")
someATM.sendUserDataToBank(actions: .topUpMobilePhone(pay: 14, method: .byCash))
print("------------------------")
someATM.sendUserDataToBank(actions: .showUserCardBalance)
print("------------------------")
someATM.sendUserDataToBank(actions: .showUserDepositBalance)
