// Задание 1

// Перечисление с ошибками
enum MyError: Int, Error {
    case notFound = 404
    case badRequest = 400
    case internalServerError = 500
}

// Переменные с ошибками
var notFound = true
var badRequest = false
var internalServerError = false

// Обработка ошибок при помощи do-catch
do {
    if notFound {
        throw MyError.notFound
    }
}
catch MyError.notFound {
    print("Not Found")
}

do {
    if badRequest {
        throw MyError.badRequest
    }
}
catch MyError.badRequest {
    print("Bad Request")
}

do {
    if internalServerError {
        throw MyError.internalServerError
    }
}
catch MyError.internalServerError {
    print("Internal Server Error")
}


// Задание 2

// Генерирующая функция
func errorTest() throws {
    if notFound {
        throw MyError.notFound
    }
    if badRequest {
        throw MyError.badRequest
    }
    if internalServerError {
        throw MyError.internalServerError
    }
}

// Обработка ошибок при помощи генерирующей функции
do {
    try errorTest()
} catch MyError.notFound {
    print("Not Found")
} catch MyError.badRequest {
    print("Bad Request")
} catch MyError.internalServerError {
    print("Internal Server Error")
}


// Задание 3
func typeCompare<T,E>(_ a: T, _ b: E) {
    type(of: a) == type(of: b) ? print("Yes") : print("No")
}

typeCompare("W", 7)
typeCompare(5, 123)


// Задание 4
enum ErrorOfType: Error {
    case differentType
    case identicalType
}

func typeCompareTwo<T,E>(_ a: T, _ b: E) throws {
    if type(of: a) == type(of: b) {
        throw ErrorOfType.identicalType
    } else {
        throw ErrorOfType.differentType
}}

do {
    try typeCompareTwo(1, 2)
} catch ErrorOfType.differentType {
    print("No")
} catch ErrorOfType.identicalType {
    print("Yes")
}

// Задание 5
func compare<T: Equatable>(_ a: T, _ b: T) {
    a == b ? print("Yes") : print("No")
}

compare(4, 10)

