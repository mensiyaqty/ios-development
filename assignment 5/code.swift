import Foundation

// =============================================================
//  Station ALMA-7, Part III: The Repair Fleet
// =============================================================

// MARK: - =================== STARTER DATA ===================

let fleetData: [(kind: String, id: String, charge: Int)] = [
    (kind: "welder",  id: "W-1", charge: 80),
    (kind: "scanner", id: "S-1", charge: 45),
    (kind: "cargo",   id: "C-1", charge: 100),
    (kind: "welder",  id: "W-2", charge: 15),
    (kind: "scanner", id: "S-2", charge: 60),
    (kind: "tug",     id: "T-1", charge: 50)
]

let sensorData: [(id: String, charge: Int)] = [
    (id: "hull-cam", charge: 12),
    (id: "thermal",  charge: 77)
]

struct LegacyBeacon {
    let name: String
    let signalStrength: Int
}

let beacon = LegacyBeacon(name: "ALMA-BEACON", signalStrength: 8)

print("Fleet registry online: \(fleetData.count) drone records, \(sensorData.count) sensors, beacon \(beacon.name).")

// MARK: - =================== YOUR SOLUTION ===================

// MARK: Level 1 · The Power Cell

// Why a class and not a struct here? -> PowerCell represents shared mutable state that multiple objects need to reference and mutate directly.
final class PowerCell {
    private var charge: Int
    
    init(charge: Int) {
        if charge < 0 {
            self.charge = 0
        } else if charge > 100 {
            self.charge = 100
        } else {
            self.charge = charge
        }
    }
    
    func level() -> Int {
        return charge
    }
    
    func spend(amount: Int) -> Bool {
        if amount <= 0 || charge < amount {
            return false
        }
        charge -= amount
        return true
    }
    
    func recharge(by amount: Int) {
        if amount <= 0 { return }
        charge += amount
        if charge > 100 {
            charge = 100
        }
    }
}

// Encapsulation proof (commented out):
// let testCell = PowerCell(charge: 100)
// testCell.charge = 100
// error: 'charge' is inaccessible due to 'private' protection level


// MARK: Level 2 · The Fleet

// 2.1 What does `final` on runOnce() buy you? -> Prevents subclasses from altering the energy consumption check before execution.
class Drone {
    let id: String
    let cell: PowerCell
    
    init(id: String, cell: PowerCell) {
        self.id = id
        self.cell = cell
    }
    
    var powerCost: Int { 10 }
    
    var statusLine: String {
        return "\(id): \(cell.level().powerBar)"
    }
    
    func performTask() -> Int {
        return 0
    }
    
    final func runOnce() -> Int {
        if !cell.spend(amount: powerCost) {
            return 0
        }
        return performTask()
    }
}

// 2.2
final class WelderDrone: Drone {
    override var powerCost: Int { 25 }
    
    override func performTask() -> Int {
        return 40
    }
    
    func weldSeam() -> String {
        return "Seam welded"
    }
}

class ScannerDrone: Drone {
    override var powerCost: Int { 10 }
    
    override func performTask() -> Int {
        return 15
    }
    
    override var statusLine: String {
        return super.statusLine + " [scanner]"
    }
}

final class CargoDrone: Drone {
    override var powerCost: Int { 20 }
    
    override func performTask() -> Int {
        return 25
    }
}

// 2.3
func makeDrone(kind: String, id: String, charge: Int) -> Drone? {
    let cell = PowerCell(charge: charge)
    if kind == "welder" {
        return WelderDrone(id: id, cell: cell)
    } else if kind == "scanner" {
        return ScannerDrone(id: id, cell: cell)
    } else if kind == "cargo" {
        return CargoDrone(id: id, cell: cell)
    } else {
        print("Warning: Unknown drone kind '\(kind)' for ID '\(id)'. Skipping.")
        return nil
    }
}

var fleet: [Drone] = []
for record in fleetData {
    if let drone = makeDrone(kind: record.kind, id: record.id, charge: record.charge) {
        fleet.append(drone)
    }
}


// MARK: Level 3 · The Shift

func runShift(_ fleet: [Drone], rounds: Int) -> Int {
    var totalWork = 0
    for _ in 1...rounds {
        for drone in fleet {
            totalWork += drone.runOnce()
        }
    }
    return totalWork
}

let A = runShift(fleet, rounds: 3)

print("\n--- Drone status after shift ---")
var totalRemainingCharge = 0
var readyDroneCount = 0

for drone in fleet {
    print(drone.statusLine)
    let currentCharge = drone.cell.level()
    totalRemainingCharge += currentCharge
    if currentCharge >= drone.powerCost {
        readyDroneCount += 1
    }
}

let B = totalRemainingCharge
let C = readyDroneCount


// MARK: Level 4 · Diagnostics

// 4.1
protocol Diagnosable {
    var componentID: String { get }
    var statusCode: Int { get }
    func diagnose() -> String
}

// 4.2
protocol Rechargeable {
    mutating func recharge(by amount: Int)
}

// Why Drone implements recharge(by:) without mutating:
// Classes are reference types, modifying properties doesn't mutate the instance reference itself.
extension Drone: Diagnosable, Rechargeable {
    var componentID: String {
        return id
    }
    
    var statusCode: Int {
        return statusCode(forCharge: cell.level())
    }
    
    func recharge(by amount: Int) {
        cell.recharge(by: amount)
    }
}

struct SensorModule: Diagnosable, Rechargeable {
    let id: String
    var chargeLevel: Int
    
    var componentID: String {
        return id
    }
    
    var statusCode: Int {
        return statusCode(forCharge: chargeLevel)
    }
    
    mutating func recharge(by amount: Int) {
        if amount <= 0 { return }
        chargeLevel += amount
        if chargeLevel > 100 {
            chargeLevel = 100
        }
    }
}

// 4.3
// Why [Drone] couldn't hold sensors:
// SensorModule is a struct, not a subclass of Drone.
func diagnosticsReport(_ components: [Diagnosable]) -> String {
    var reportLines: [String] = []
    for component in components {
        reportLines.append(component.diagnose())
    }
    
    var result = ""
    for i in 0..<reportLines.count {
        result += reportLines[i]
        if i < reportLines.count - 1 {
            result += "\n"
        }
    }
    return result
}


// MARK: Level 5 · Shared Behaviour

// 5.1 · Single home of the Health Rule
extension Diagnosable {
    func diagnose() -> String {
        return "\(componentID): code \(statusCode)"
    }
    
    func statusCode(forCharge charge: Int) -> Int {
        if charge < 20 {
            return 2
        } else if charge <= 49 {
            return 1
        } else {
            return 0
        }
    }
}

// 5.2 · Legacy Beacon extension
extension LegacyBeacon: Diagnosable {
    var componentID: String {
        return name
    }
    
    var statusCode: Int {
        return statusCode(forCharge: signalStrength)
    }
    
    func diagnose() -> String {
        return "[LEGACY BEACON] \(componentID): code \(statusCode)"
    }
}

var sensors: [SensorModule] = []
for data in sensorData {
    sensors.append(SensorModule(id: data.id, chargeLevel: data.charge))
}

var allComponents: [Diagnosable] = []
for drone in fleet {
    allComponents.append(drone)
}
for sensor in sensors {
    allComponents.append(sensor)
}
allComponents.append(beacon)

print("\n--- Diagnostics Report ---")
print(diagnosticsReport(allComponents))

var totalStatusCode = 0
for component in allComponents {
    totalStatusCode += component.statusCode
}

let D = totalStatusCode

// 5.3
extension Int {
    var powerBar: String {
        var clamped = self
        if clamped < 0 { clamped = 0 }
        if clamped > 100 { clamped = 100 }
        
        let hashes = clamped / 10
        let dots = 10 - hashes
        
        var bar = ""
        if hashes > 0 {
            for _ in 1...hashes { bar += "#" }
        }
        if dots > 0 {
            for _ in 1...dots { bar += "." }
        }
        return bar
    }
}


// MARK: Finale · Mission Code

let missionCode = "\(A)-\(B)-\(C)-\(D)"
print("\nMISSION CODE: \(missionCode)")


// MARK: - ================= DEFENSE QUESTIONS =================
/*
 1. Why does a class satisfy a `mutating` protocol requirement without the
    keyword, while a struct must write it?
    Class instances are reference types stored on the heap; modifying their properties
    mutates the underlying instance data without changing the memory reference.
    Structs are value types, so modifying properties mutates the actual value instance.

 2. One thing inheritance does that protocols cannot, and one thing
    protocols do that inheritance cannot:
    Inheritance allows sharing stored properties and default execution in a class hierarchy.
    Protocols allow uniting completely unrelated types (classes, structs) under one interface.

 3. What does `final` prevent, and what did it protect in runOnce()?
    `final` prevents overriding or subclassing. In `runOnce()`, it ensured subclasses
    cannot bypass the battery deduction step.

 4. In Report 4, why did the protocol extension's method win?
    Because `label()` was not listed in the protocol declaration itself, causing calls through
    a protocol-typed variable to use static dispatch.
*/