import Foundation

//enum Seasons: CaseIterable {
//    case summer
//    case spring
//    case autumn
//    case winter
//}
//
//let currentSeason: Seasons = .autumn
//
////switch currentSeason {
////case .summer:
////    print("Summer")
////case .spring:
////    print("Spring")
////case .autumn:
////    print("Autumn")
////case .winter:
////    print("Winter")
////}
//
////let allSeasons = Seasons.allCases
////for season in allSeasons {
////    print("-\(season)")
////}
//
//enum Barcode {
//    case ups(Int, Int, Int, Int)
//    case qrCode(String)
//}
//
//let someCode: Barcode = .ups(1, 2, 3, 4)
//let anotherCode = Barcode.qrCode("asdkjalsjd123a")
//
//switch anotherCode {
//case .qrCode(let code):
//    print("This is QR code value: \(code)")
//case let .ups(a, b, c, d):
//    let result = a + b + c + d
//    print("Result: \(result)")
//}
//
//enum Gender: String {
//    case male
//    case female
//}
//
//let userGender: Gender = .female
//print(userGender.rawValue)
//
//let createdGender = Gender(rawValue: "male")
//print(createdGender)

//class SuperHuman {
//    func greeting() {
//        print("Hello World!")
//    }
//}
//
//class Human: SuperHuman {
//    let name: String
//    let age: Int
//
//    init(name: String, age: Int) {
//        self.name = name
//        self.age = age
//    }
//
//    deinit {
//        print("Human was dead!")
//    }
//}
//
//let someHuman = Human(name: "Sam", age: 20)
//
//
//struct Person {
//    let name: String
//    let age: Int
//    var isOld: Bool = false
//
//    func greeting() {
//        print("Welcome, my name is \(name)")
//    }
//}
//
//let person = Person(name: "Samantha", age: 18)
//person.greeting()
//print(person.isOld)
//
//struct Celcius {
//    let celciusValue: Double
//
//    init(fromFarenheit farenheit: Double) {
//        celciusValue = (farenheit - 32.0) / 1.8
//    }
//
//    init(fromKelvin kelvin: Double) {
//        celciusValue = kelvin - 273.15
//    }
//}
//
//let celcius = Celcius(fromKelvin: 300)
//let celciusAnother = Celcius(fromFarenheit: 120)
//
//print(celcius.celciusValue)
//print(celciusAnother.celciusValue)
//
///// Classes - Heap (Reference Type)
///// Structs - Stack (Value Type)
//
//class Hero {
//    var name: String
//
//    init(name: String) {
//        self.name = name
//    }
//}
//
//var hero = Hero(name: "Spider-Man")
//var copyHero = hero //
//copyHero.name = "Iron-Man"
//
//print(hero.name) // Spider-Man
//print(copyHero.name) // Iron-Man
//
//


//struct Rectangle {
//    let x: Int
//    let y: Int
//
//    var square: Int {
//        return x * y
//    }
//}
//let rect = Rectangle(x: 2, y: 6)
//print(rect.square)
//
//struct Cube {
//    var x: Double
//
//    var square: Double {
//        get {
//            return x * x
//        }
//        set {
//            self.x = sqrt(newValue)
//        }
//    }
//}
//
//var cube = Cube(x: 4)
//print(cube.square)
//cube.square = 25
//print(cube.x)
//

enum Weather: String {
    case hot = "😎"
    case cold = "☃️"
    case good = "🌊"
}

struct WeatherApp {
    fileprivate var message: String = ""
    var currentWeather: Weather {
        willSet {
            switch newValue {
            case .cold:
                message = "Kinda super cold"
            case .good:
                message = "Just chill"
            case .hot:
                message = "Dead inside"
            }
        }
        didSet {
            print("The new value is \(currentWeather.rawValue), old one is \(oldValue.rawValue)")
        }
    }

    func getMessage() -> String {
        // Pre condition, to check can u get message or not?
        return message
    }
}

var app = WeatherApp(currentWeather: .hot)
print(app.currentWeather.rawValue)
app.currentWeather = .hot
print(app.currentWeather.rawValue)
print(app.message)


struct Increment {
    var value: Int = 1

    mutating func increment() {
        value += 1
    }
}

var inc = Increment()
inc.increment()
print(inc.value)
