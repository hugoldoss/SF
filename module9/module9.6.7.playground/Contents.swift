enum AutoError: Error {
    case isLost // заблудился
    case lowBattery // низкая батарея
    case brokeAutoDrive // проблемы с управлением машины
}
 
var isLost: Bool = true
var lowBattery: Bool = false
var brokeAutoDrive: Bool = true
 
do {
    if isLost {
        throw AutoError.isLost
    }
 
    if lowBattery {
        throw AutoError.lowBattery
    }
 
    if brokeAutoDrive {
        throw AutoError.brokeAutoDrive
    }
} catch AutoError.isLost {
    print("Вы заблудились! Включаю GPS")
} catch AutoError.lowBattery {
    print("Батарея садится! Ближайшая станция подзарядки через 1 км 300 м")
} catch AutoError.brokeAutoDrive {
    print("Режим автопилота поврежден. Переходим в режим ручного управления!")
}
 
// 2 вариант - сразу создать функцию, явно указав, что она может выдавать ошибки (при помощи throws)! А далее - просто ловить эти ошибки при помощи catch.
func autoDrive() throws {
    if isLost {
        throw AutoError.isLost
    }
 
    if lowBattery {
        throw AutoError.lowBattery
    }
 
    if brokeAutoDrive {
        throw AutoError.brokeAutoDrive
    }
}
 
do {
    try autoDrive()
} catch AutoError.isLost {
    print("Вы заблудились! Включаю GPS")
} catch AutoError.lowBattery {
    print("Батарея садится! Ближайшая станция подзарядки через 1 км 300 м")
} catch AutoError.brokeAutoDrive {
    print("Режим автопилота поврежден. Переходим в режим ручного управления!")
}
