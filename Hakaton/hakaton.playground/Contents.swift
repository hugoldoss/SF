// Абстракция данных пользователя

import Foundation
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
    case checkUserCardBalance // Проверка баланса карты
    case checkUserBankDeposit // Проверка баланса банковского депозита
    case cashWithdrawalFromCard // Снять наличные с карты
    case cashWithdrawalFromBankDeposit // Снять наличные с банковского депозита
    case cashReplenishmentCard // Пополнение карты наличными
    case cashReplenishmentBankDeposit // Пополнение банковского депозита наличными
    case phonePaymentFromCard // Пополнение баланса телефона с карты
    case phonePaymentFromBankDeposit // Пополнение баланса телефона с банковского депозита
}

// Виды операций, выбранных пользователем (подтверждение выбора)
enum DescriptionTypesAvailableOperations: String {
    case checkUserCardBalance = "Проверка баланса карты"
    case checkUserBankDeposit = "Проверка баланса банковского депозита"
    case cashWithdrawalFromCard = "Снять наличные с карты"
    case cashWithdrawalFromBankDeposit = "Снять наличные с банковского депозита"
    case cashReplenishmentCard = "Пополнение карты наличными"
    case cashReplenishmentBankDeposit = "Пополнение банковского депозита наличными"
    case phonePaymentFromCard = "Пополнение баланса телефона с карты"
    case phonePaymentFromBankDeposit = "Пополнение баланса телефона с банковского депозита"
}
 
// Способ оплаты/пополнения наличными, картой или через депозит
enum PaymentMethod {
    case byCash
    case byCard
    case byDeposit
}

// Тексты ошибок
enum TextErrors: String, LocalizedError {
    case noMoneyOnCard = "Не достаточно денег на карте"
    
    var errorDescription: String? {
        self.rawValue
    }
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
    mutating func getCashFromDeposit(cash: Float)
    mutating func getCashFromCard(cash: Float)
    mutating func putCashDeposit(topUp: Float)
    mutating func putCashCard(topUp: Float)
}

// Банкомат, с которым мы работаем, имеет общедоступный интерфейс sendUserDataToBank
class ATM {
    private let userCardId: String
    private let userCardPin: Int
    private var someBank: BankApi
    private let action: UserActions
    private let paymentMethod: PaymentMethod?
 
    init(userCardId: String, userCardPin: Int, someBank: BankApi, action: UserActions, paymentMethod: PaymentMethod? = nil) {
        self.userCardId = userCardId
        self.userCardPin = userCardPin
        self.someBank = someBank
        self.action = action
        self.paymentMethod = paymentMethod
  }
 
 
  public final func sendUserDataToBank(userCardId: String, userCardPin: Int, actions: UserActions, payment: PaymentMethod?) {
 
  }
}
 

