// характеристики автомобиля

var weight: Double = 2108 // масса в кг
let length = 4976 // длина в мм
let height = 1435 // высота в мм
let width = 1963 // ширина с учетом боковых зеркал в мм
let wheelbase = 2959 // колесная база в мм
let clearance = 154.9 // клиренс в мм
let luggageBootCapacity = 900 // обьем багажника в литрах


// автопилот
// переменная которая хранит в себе режим управления
var isAutopilotON = false

// переключение режима управления
func autopilotSwitch() {
    if isAutopilotON {
        print("Автопилот выключен. Необходимо принять управление автомобилем")
    } else {
        print("Автопилот включен, но Вам все равно необходимо следить за дорогой")
    }
    isAutopilotON = !isAutopilotON
}


// музыка
var isMusicON = false // статус включения музыки
var musicVolume = 0 // громкость музыки

// изменение громкости музыки
func musicVolumeChange (volume: Int) {
    if volume <= 0 {
        musicVolume = 0
    }
    if 0 < volume && volume <= 50 {
        musicVolume = volume
    }
    if volume > 50 {
        musicVolume = 50
    }
    print("Громкость \(musicVolume)")
}

// переключение треков
func nextTrack() {
    if isMusicON {
        print("Следующий трек")
    }
}
func previousTrack() {
    if isMusicON {
    print("Предыдущий трек")
    }
}

// включение/выключение музыки
func musicSwitch() {
    if isMusicON {
        print("Музыка выключена")
    } else {
        print("Музыка включена")
    }
    isMusicON = !isMusicON
}

// управление люком

var sunroffOpeningDegree = 0

func sunroffOpeningDegreeChange (openingDegree: Int) {
    if openingDegree <= 0 {
        sunroffOpeningDegree  = 0
    }
    if 0 < openingDegree && openingDegree <= 100 {
        sunroffOpeningDegree  = openingDegree
    }
    if openingDegree > 100 {
        sunroffOpeningDegree  = 100
    }
    print("Люк открыт на \(sunroffOpeningDegree)%")
}

// вентилятор обдува

var isFanON = false // статус включения вентилятора

// включение/выключение вентилятора
func fanSwitch() {
    if isFanON {
        print("Ветилятор выключен")
    } else {
        print("Вентилятор включен")
    }
    isFanON = !isFanON
}

var fanSpeed = 0 // скорость ветилятора

// изменение скорости вентилятора
func fanSpeedChange(speed: Int) {
    if speed <= 0 {
        fanSpeed = 0
    }
    if speed > 0 && speed <= 5 {
        fanSpeed = speed
    }
    if speed > 5 {
        fanSpeed = 5
    }
    print("Скорость вентилятора \(fanSpeed)")
}

// климатичесие установки

var isAirConditionerON = false // статус включения кондиционера

// включение/выключение кондиционера
func airConditionerSwitch() {
    if isAirConditionerON {
        print("Кондиционер выключен")
    } else {
        print("Кондиционер включен")
    }
    isAirConditionerON = !isAirConditionerON
}


// обработка ошибок
// ошибки

var isBrakePadsWornOut = true // критический износ тормозных колодок
var isBatteryLow = false // разряд батареи
var isHeadlightBroken = true // неисправность освещения
var isLost = false // потеря маршрута

var errors = [isLost, isBrakePadsWornOut, isBatteryLow, isHeadlightBroken]

errors.count



enum AutoError: Error {
    case isBrakePadsWornOut
    case isBatteryLow
    case isHeadlightBroken
    case isLost
}


do {
    if isBrakePadsWornOut {
        throw AutoError.isBrakePadsWornOut
    }
}
catch AutoError.isBrakePadsWornOut {
        print("Критический износ тормозных колодок. Сбавьте скорость и проследуйте на станцию ремонта")
    }

do {
    if isBatteryLow {
        throw AutoError.isBatteryLow
    }
}
catch AutoError.isBatteryLow {
        print("Батарея разряжена. Проследуйте на станцию подзарядки")
    }
        
do {
    if isHeadlightBroken {
        throw AutoError.isHeadlightBroken
    }
}
catch AutoError.isHeadlightBroken {
    print("Неисправность фар ближнего света. Рекомендуем воздержаться от поездок в темное время суток и провести ремонт как можно скорее")
}
do {
    if isLost {
        throw AutoError.isLost
    }
}
catch AutoError.isLost {
    print("Вы ушли с маршрута. Поиск нового маршрута....")
}



// второй способ
func errorTest() throws {
    if isBrakePadsWornOut {
        throw AutoError.isBrakePadsWornOut
    }
    if isBatteryLow {
        throw AutoError.isBatteryLow
    }
    if isHeadlightBroken {
        throw AutoError.isHeadlightBroken
    }
    if isLost {
        throw AutoError.isLost
    }
}


do {
    try errorTest()
} catch AutoError.isBrakePadsWornOut {
    print("Критический износ тормозных колодок. Сбавьте скорость и проследуйте на станцию ремонта")
} catch AutoError.isBatteryLow {
    print("Батарея разряжена. Проследуйте на станцию подзарядки")
} catch AutoError.isHeadlightBroken {
    print("Неисправность фар ближнего света. Рекомендуем воздержаться от поездок в темное время суток и провести ремонт как можно скорее")
} catch AutoError.isLost {
    print("Вы ушли с маршрута. Поиск нового маршрута....")
}







// тест
autopilotSwitch()
musicSwitch()
musicVolumeChange(volume: 45)
nextTrack()
musicSwitch()
previousTrack()
sunroffOpeningDegreeChange(openingDegree: 70)
fanSwitch()
fanSpeedChange(speed: 3)
airConditionerSwitch()
autopilotSwitch()


