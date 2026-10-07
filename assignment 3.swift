// =============================================================
//  Station ALMA-7: Rescue Protocol
//  iOS Mobile Development · Module 3 · Lab Assignment
//
//  How to use:
//   • Xcode: File → New → Playground → Blank, replace everything
//     with this file's contents.
//   • Terminal: swift ALMA7_Starter.swift
//
//  Rules:
//   • Do NOT modify the STARTER CODE section.
//   • `!` (force unwrap) is forbidden: −0.5 points each.
//   • No map / filter / reduce / compactMap.
//   • Use the exact function names from the assignment PDF.
// =============================================================


// MARK: - =================== STARTER CODE ===================
// MARK: - Do not modify anything in this section

typealias Reading = (sensor: String, value: Int)

/// Splits a string at the first occurrence of the separator.
/// splitOnce("O2:87", by: ":") -> ("O2", "87")
/// splitOnce("hello", by: ":") -> nil
func splitOnce(_ line: String, by separator: Character) -> (String, String)? {
    guard let index = line.firstIndex(of: separator) else { return nil }
    let left = String(line[..<index])
    let right = String(line[line.index(after: index)...])
    return (left, right)
}

let rawLog = [
    "O2:87", "TEMP:-12", "O2:9x", "PRESS:101", "TEMP:abc", "O2:",
    "RAD:3", "O2:64", ":55", "TEMP:31", "PRESS:98", "O2:71",
    "RAD:-1", "TEMP:4", "PRESS:1o2", "O2:90"
]

class Tank {
    var level: Int
    init(level: Int) { self.level = level }
}

class Module {
    let name: String
    var oxygenTank: Tank?
    init(name: String, oxygenTank: Tank?) {
        self.name = name
        self.oxygenTank = oxygenTank
    }
}

class CrewMember {
    let name: String
    let role: String
    let priority: Int      // 1 = evacuated first
    var module: Module?    // nil = in open space
    init(name: String, role: String, priority: Int, module: Module?) {
        self.name = name
        self.role = role
        self.priority = priority
        self.module = module
    }
}

let lab  = Module(name: "Lab",  oxygenTank: Tank(level: 40))
let hab  = Module(name: "Hab",  oxygenTank: Tank(level: 12))
let dock = Module(name: "Dock", oxygenTank: nil)

let crew = [
    CrewMember(name: "Timur",   role: "Engineer",  priority: 3, module: lab),
    CrewMember(name: "Dana",    role: "Scientist", priority: 4, module: dock),
    CrewMember(name: "Aigerim", role: "Commander", priority: 1, module: hab),
    CrewMember(name: "Nurlan",  role: "Pilot",     priority: 2, module: nil)
]

var roster: [String: CrewMember] = [:]
for member in crew { roster[member.name] = member }

print("ALMA-7 systems online: \(rawLog.count) log lines, \(crew.count) crew members.")

// MARK: - ================= END OF STARTER CODE =================


// MARK: - =================== YOUR SOLUTION ===================

// MARK: Level 1 · Decoding Telemetry

// 1.1
func parseReading(_ raw: String) -> Reading? {
    guard let (sensor, valueStr) = splitOnce(raw, by: ":"),
          !sensor.isEmpty,
          let value = Int(valueStr),
          sensor == "TEMP" || value >= 0 else {
        return nil
    }
    return (sensor: sensor, value: value)
}

print("\n--- Task 1.1 Tests ---")
print(parseReading("O2:87") as Any)     // Optional((sensor: "O2", value: 87))
print(parseReading("TEMP:-12") as Any)  // Optional((sensor: "TEMP", value: -12))
print(parseReading("RAD:-1") as Any)    // nil
print(parseReading(":55") as Any)       // nil

// 1.2
func parseLog(_ lines: [String]) -> (valid: [Reading], invalidCount: Int) {
    var validReadings: [Reading] = []
    var invalidCount = 0
    
    for line in lines {
        if let reading = parseReading(line) {
            validReadings.append(reading)
        } else {
            invalidCount += 1
        }
    }
    return (valid: validReadings, invalidCount: invalidCount)
}

print("\n--- Task 1.2 Tests ---")
let logAnalysis = parseLog(rawLog)
print("Valid readings count: \(logAnalysis.valid.count)")
print("Invalid lines count: \(logAnalysis.invalidCount)")

let A = logAnalysis.invalidCount


// MARK: Level 2 · Analysis

// 2.1
func select(_ readings: [Reading], where isIncluded: (Reading) -> Bool) -> [Reading] {
    var result: [Reading] = []
    for reading in readings {
        if isIncluded(reading) {
            result.append(reading)
        }
    }
    return result
}

func values(of readings: [Reading]) -> [Int] {
    var result: [Int] = []
    for reading in readings {
        result.append(reading.value)
    }
    return result
}

print("\n--- Task 2.1 Tests ---")
let o2Readings = select(logAnalysis.valid) { $0.sensor == "O2" }
let o2Values = values(of: o2Readings)
print("O2 Readings: \(o2Readings)")
print("O2 Values: \(o2Values)")

// 2.2
func stats(of values: [Int]) -> (min: Int, max: Int, average: Double)? {
    guard !values.isEmpty else { return nil }
    
    var minVal = values[0]
    var maxVal = values[0]
    var sum = 0
    
    for val in values {
        if val < minVal { minVal = val }
        if val > maxVal { maxVal = val }
        sum += val
    }
    
    let avg = Double(sum) / Double(values.count)
    return (min: minVal, max: maxVal, average: avg)
}

func stats(_ values: Int...) -> (min: Int, max: Int, average: Double)? {
    stats(of: values)
}

print("\n--- Task 2.2 Tests ---")
print(stats(3, 8, 1) as Any) // Optional((min: 1, max: 8, average: 4.0))
print(stats() as Any)        // nil

let o2Stats = stats(of: o2Values)
let B = Int(o2Stats?.average ?? 0)
print("B (Average O2 as Int): \(B)")

// 2.3 · The Closure Ladder
print("\n--- Task 2.3 Tests ---")
let validReadings = logAnalysis.valid

// 1. Полный синтаксис замыкания с явными типами и return
let sort1 = validReadings.sorted(by: { (r1: Reading, r2: Reading) -> Bool in
    return r1.value > r2.value
})

// 2. Типы выводятся из контекста
let sort2 = validReadings.sorted(by: { r1, r2 in
    return r1.value > r2.value
})

// 3. Неявный return (однострочное выражение)
let sort3 = validReadings.sorted(by: { r1, r2 in
    r1.value > r2.value
})

// 4. Сокращенные имена аргументов ($0, $1)
let sort4 = validReadings.sorted(by: { $0.value > $1.value })

// 5. Замыкание за скобками (Trailing closure)
let sort5 = validReadings.sorted { $0.value > $1.value }

// Проверка совпадения результатов в коде
let resultsMatch = sort1.elementsEqual(sort2, by: { $0 == $1 }) &&
                   sort2.elementsEqual(sort3, by: { $0 == $1 }) &&
                   sort3.elementsEqual(sort4, by: { $0 == $1 }) &&
                   sort4.elementsEqual(sort5, by: { $0 == $1 })

print("All 5 sort ladder results match: \(resultsMatch)")


// MARK: Level 3 · Temperature Stabilization

// 3.1
func heatUp(_ t: Int) -> Int { t + 5 }
func coolDown(_ t: Int) -> Int { t - 3 }
func hold(_ t: Int) -> Int { t }

func chooseProtocol(for temp: Int) -> (Int) -> Int {
    if temp < 18 {
        return heatUp
    } else if temp > 24 {
        return coolDown
    } else {
        return hold
    }
}

// 3.2
func runUntilStable(from start: Int, maxSteps: Int = 10) -> (finalTemp: Int, steps: Int, isStable: Bool) {
    var currentTemp = start
    var steps = 0
    
    while (currentTemp < 18 || currentTemp > 24) && steps < maxSteps {
        let proto = chooseProtocol(for: currentTemp)
        currentTemp = proto(currentTemp)
        steps += 1
    }
    
    let isStable = (currentTemp >= 18 && currentTemp <= 24)
    return (finalTemp: currentTemp, steps: steps, isStable: isStable)
}

print("\n--- Level 3 Tests ---")
print(runUntilStable(from: 31))                // (finalTemp: 22, steps: 3, isStable: true)
print(runUntilStable(from: -100, maxSteps: 5)) // (finalTemp: -75, steps: 5, isStable: false)

// Нахождение наименьшей валидной температуры с помощью select + stats
let tempReadings = select(logAnalysis.valid) { $0.sensor == "TEMP" }
let tempValues = values(of: tempReadings)
let minTemp = stats(of: tempValues)?.min ?? 0

let tempStabilization = runUntilStable(from: minTemp)
let C = tempStabilization.steps
print("Lowest TEMP: \(minTemp), Steps to stabilize (C): \(C)")


// MARK: Level 4 · The Crew

// 4.1
func oxygenLevel(of member: CrewMember) -> Int? {
    member.module?.oxygenTank?.level
}

// 4.2
func status(of member: CrewMember) -> String {
    guard let module = member.module else {
        return "\(member.name): no data (open space)"
    }
    
    guard let level = oxygenLevel(of: member) else {
        return "\(member.name): no data (\(module.name))"
    }
    
    let state = (level < 20) ? "CRITICAL" : "OK"
    return "\(member.name): \(level)% \(state)"
}

print("\n--- Task 4.1 & 4.2 Tests ---")
for member in crew {
    print(status(of: member))
}

// 4.3
@discardableResult
func transferOxygen(from source: inout Int, to target: inout Int, amount: Int) -> Int {
    guard amount > 0 else { return 0 }
    
    let maxTransfersFromSource = source
    let maxCapacityInTarget = 100 - target
    
    let actualTransfer = min(amount, maxTransfersFromSource, maxCapacityInTarget)
    if actualTransfer <= 0 { return 0 }
    
    source -= actualTransfer
    target += actualTransfer
    return actualTransfer
}

print("\n--- Task 4.3 Tests ---")
if let labTank = lab.oxygenTank, let habTank = hab.oxygenTank {
    let transferred = transferOxygen(from: &labTank.level, to: &habTank.level, amount: 30)
    print("Transferred oxygen amount: \(transferred)")
}

let D = hab.oxygenTank?.level ?? 0
print("Hab oxygen level after transfer (D): \(D)")

// 4.4
func evacuationOrder(_ names: String..., roster: [String: CrewMember]) -> [String] {
    var foundMembers: [CrewMember] = []
    
    for name in names {
        guard let member = roster[name] else {
            print("Unknown crew member: \(name)")
            continue
        }
        foundMembers.append(member)
    }
    
    // Сортировка по приоритету (эвакуация по возрастанию priority: 1, 2, 3...)
    let sortedMembers = foundMembers.sorted { $0.priority < $1.priority }
    
    var resultNames: [String] = []
    for member in sortedMembers {
        resultNames.append(member.name)
    }
    return resultNames
}

print("\n--- Task 4.4 Tests ---")
let evacList = evacuationOrder("Dana", "Ghost", "Aigerim", "Timur", roster: roster)
print("Evacuation order: \(evacList)")


// MARK: Level 5 · The Saboteur's Logbook

/*
 АНАЛИЗ ОШИБОК И БАГОВ В КОДЕ САБОТАЖНИКА:
 1. member.module!.oxygenTank!
    - Использование Force Unwrap (!).
    - Какими данными ломается: Если у члeна экипажа нет модуля (module == nil, как у Nurlan) или в модуле нет бака (oxygenTank == nil, как у Dana в Dock).
    - Что происходит: Рантайм-краш приложения (Fatal error: Unexpectedly found nil while unwrapping an Optional value).

 2. let tank = ... объявлен ПОСЛЕ инструкции return.
    - Ошибка компиляции: Код недостижим (Unreachable code), синтаксически невалиден.

 3. \(tank.level)
    - Вызов переменной `tank`, которая ещё не существует в области видимости до её объявления.

 4. oxygenLevel(of: member)! < 20
    - Использование Force Unwrap (!) на возвращаемом извлечении Optional Int.
    - Какими данными ломается: Любой член экипажа без бака с кислородом (например, Dana или Nurlan).
    - Что происходит: Рантайм-краш при попытке развернуть nil.

 5. ЛОГИЧЕСКИЙ БАГ в firstCritical:
    - Внутри цикла `for member in crew`, если условия выполняются, происходит присвоение `result = member.name`.
    - Результат: Переменная перезаписывается при каждом найденном критическом пользователе, в итоге функция возвращает ПОСЛЕДНЕГО критического члена экипажа вместо ПЕРВОГО!

 6. return result!
    - Какими данными ломается: Если в списке экипажа нет ни одного члена с критическим уровнем кислорода (result остаётся nil).
    - Что происходит: Рантайм-краш при попытке вызова result!.
*/

// Исправленная версия reportOxygen (без force-unwrap)
func reportOxygen(for member: CrewMember) -> String {
    guard let level = oxygenLevel(of: member) else {
        return "\(member.name): no oxygen tank"
    }
    return "\(member.name): \(level)%"
}

// Исправленная версия firstCritical (возвращает String?, возвращает именно первого найденного)
func firstCritical(in crew: [CrewMember]) -> String? {
    for member in crew {
        if let level = oxygenLevel(of: member), level < 20 {
            return member.name // Сразу возвращаем первого найденного
        }
    }
    return nil
}

// Тест, доказывающий исправление логического бага (раньше возвращал последнего критического)
print("\n--- Level 5 Tests ---")
let testLab1 = Module(name: "TestLab1", oxygenTank: Tank(level: 10)) // Critical #1
let testLab2 = Module(name: "TestLab2", oxygenTank: Tank(level: 5))  // Critical #2
let testCrew = [
    CrewMember(name: "FirstCriticalMember", role: "Doc", priority: 1, module: testLab1),
    CrewMember(name: "SecondCriticalMember", role: "Tech", priority: 2, module: testLab2)
]

let firstFound = firstCritical(in: testCrew)
print("First critical found: \(firstFound ?? "None")") 
// Выведет "FirstCriticalMember". Старый код саботажника вывел бы "SecondCriticalMember".


// MARK: Finale · Launch Code

let launchCode = "\(A)-\(B)-\(C)-\(D)"
print("\n==========================================")
print("LAUNCH CODE: \(launchCode)")
print("==========================================")


// MARK: Bonus

func makeAlarm(threshold: Int) -> (Int) -> Bool {
    var count = 0
    return { level in
        if level < threshold {
            count += 1
            print("Alarm #\(count)")
            return true
        }
        return false
    }
}

print("\n--- Bonus Test ---")
let alarm = makeAlarm(threshold: 20)
print(alarm(12)) // Alarm #1 -> true
print(alarm(40)) // false
print(alarm(5))  // Alarm #2 -> true


// MARK: - ================= DEFENSE QUESTIONS =================
/*
 1. guard let vs if let beyond syntax:
    `guard let` требует обязательного выхода из текущей области видимости (exit via return, break, continue, throw) в блоке `else`. 
    Это гарантирует ранний выход (Early Exit) из функции и "распаковывает" константу в основную область видимости ниже по коду.
    
    `if let` создает локальную область видимости только внутри блока `{}`. 
    Пример, где `if let` делает код значительно хуже ("пирамида погибели / Pyramid of Doom"):

    // Плохо с if let:
    func checkTank(member: CrewMember) {
        if let module = member.module {
            if let tank = module.oxygenTank {
                if tank.level < 20 {
                    print("Critical")
                }
            }
        }
    }

    // Чисто с guard let:
    func checkTankG(member: CrewMember) {
        guard let module = member.module,
              let tank = module.oxygenTank else { return }
        if tank.level < 20 { print("Critical") }
    }

 2. Why can't you pass [Int] to stats(_ values: Int...)?
    Вариативный параметр `Int...` внутри тела функции действительно представлен как массив `[Int]`. 
    Однако при ВЫЗОВЕ функции Swift ожидает список разделенных запятыми значений (`Int, Int, Int`), а не сам объект типа Array (`[Int]`). 
    Поскольку в Swift нет встроенной авто-распаковки массива в variadic-аргументы, передача `[Int]` вызывает ошибку несоответствия типов.

 3. Why doesn't transferOxygen(from: &x, to: &x, amount: 5) compile?
    Это запрещено правилом эксклюзивности доступа к памяти в Swift (Law of Exclusivity / Exclusive Access to Memory). 
    Передача одной и той же переменной в два разыменование `inout`-параметров одновременно приводит к одновременному чтению и записи в одну область памяти. 
    Правило предотвращает баги несогласованности данных, некорректных вычислений и гонки состояний (Race Conditions).

 4. Why doesn't oxygenLevel(of: dana) ?? "no data" compile?
    Оператор `??` (Nil-Coalescing Operator) требует, чтобы правая и левая части имели совместимые типы. 
    Функция `oxygenLevel(of:)` возвращает `Int?`. Если левая часть относится к типу `Int`, то правая часть обязана быть значением типа `Int` (например, `0`), а не строкой `String` (`"no data"`).

 5. Full type of chooseProtocol and how to read it:
    Полный тип функции: `(Int) -> ((Int) -> Int)` (или `(Int) -> (Int) -> Int`).
    Как читать: `chooseProtocol` — это функция, которая принимает аргумент типа `Int` и возвращает ДРУГУЮ функцию. Возвращаемая функция, в свою очередь, принимает `Int` и возвращает `Int`.

 Bonus. Where does the alarm counter live after makeAlarm returns?
    Счетчик `count` захватывается замыканием (Closure Capture). 
    Обычно локальные переменные функции выделяются в стеке (stack) и уничтожаются при выходе из функции. 
    Однако, когда замыкание захватывает переменную `count` и "покидает" контекст функции, Swift автоматически перемещает (promotes) эту переменную из стека в кучу (heap). 
    Переменная `count` будет жить в куче до тех пор, пока существует экземпляр самого замыкания `alarm` (пока удерживается ссылка на замыкание).
*/