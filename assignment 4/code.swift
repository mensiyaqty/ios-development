// =============================================================
//  Station ALMA-7, Part II: The Teleporter Incident
//  iOS Mobile Development · Module 4 · Lab Assignment
//
//  How to use:
//   • Xcode: File → New → Playground → Blank, replace everything
//     with this file's contents.
//   • Terminal: swift ALMA7_Part2_Starter.swift
//
//  Rules:
//   • Do NOT modify the STARTER DATA section.
//   • `!` (force unwrap) is forbidden: −0.5 points each.
//   • No map / filter / reduce / compactMap.
//   • Default to struct. Use class only where the task says so.
// =============================================================


// MARK: - =================== STARTER DATA ===================
// MARK: - Do not modify anything in this section

/// Splits a line into fields.
/// fields("crate:101:120")            -> ["crate", "101", "120"]
/// fields("livestock:lab mice:12:2")  -> ["livestock", "lab mice", "12", "2"]
/// fields("junk")                     -> ["junk"]
func fields(_ line: String, separatedBy separator: Character = ":") -> [String] {
    var result: [String] = []
    var current = ""
    for character in line {
        if character == separator {
            result.append(current)
            current = ""
        } else {
            current.append(character)
        }
    }
    result.append(current)
    return result
}

/// Cargo manifest as recovered from the damaged recorder.
let rawManifest = [
    "crate:101:120",
    "container:KZ-ALM-7:340",
    "livestock:lab mice:12:2",
    "???-corrupted-line",
    "crate:102:75",
    "container:KZ-ALM-9:410",
    "livestock:ficus:3:5",
    "crate:103:260",
    "crate:104:abc",
    ""
]

/// Oxygen readings. One of these deck names is not a real deck.
let deckReadings: [(deck: String, oxygen: Int)] = [
    (deck: "bridge",     oxygen: 78),
    (deck: "lab",        oxygen: 64),
    (deck: "greenhouse", oxygen: 55),
    (deck: "cargo",      oxygen: 12),
    (deck: "medbay",     oxygen: 90),
    (deck: "engine",     oxygen: 41)
]

/// Crew records, straight from the personnel file.
let crewData: [(name: String, deck: String, oxygen: Int)] = [
    (name: "Timur",   deck: "engine", oxygen: 62),
    (name: "Dana",    deck: "lab",    oxygen: 48),
    (name: "Aigerim", deck: "bridge", oxygen: 91),
    (name: "Nurlan",  deck: "cargo",  oxygen: 17)
]

print("ALMA-7 recorder online: \(rawManifest.count) manifest lines, \(deckReadings.count) readings, \(crewData.count) crew records.")

// MARK: - ================= END OF STARTER DATA =================


// MARK: - =================== YOUR SOLUTION ===================
// Uncomment each declaration when you start working on it.


// MARK: Level 1 · The Deck Register

// 1.1
// enum Deck: String, CaseIterable { }

// 1.2
// enum AlarmLevel: Int { }


// MARK: Level 2 · The Manifest

// 2.1
// enum ManifestEntry { }

// 2.2
// func parseEntry(_ line: String) -> ManifestEntry { }

// 2.3
// func mass(of entry: ManifestEntry) -> Int { }

// let A = ...


// MARK: Level 3 · Crew Snapshots

// 3.1
// struct CrewSnapshot { }

// 3.2
// let crewRoster: [CrewSnapshot] = ...

// 3.3 · Value-semantics demonstration (copy / plain parameter / inout)


// MARK: Level 4 · The Teleport Pod

// 4.1
// final class TeleportPod { }

// 4.2 · Charge ledger: load+fire three times, then fire an empty pod
// let C = ...

// 4.3 · Reference-semantics demonstration


// MARK: Level 5 · Station Systems

// 5.1
// final class Station { }

// let B = ...

// 5.2 · The clamp trap: 130, then -40, then 55


// MARK: Level 6 · Incident Reports
// Three of these compile and are wrong. One does not compile.
// For each: expectation, actual behaviour, the language rule, the fix.

/*
// Report 1
var roster = crewRoster
for var member in roster {
    member.oxygen -= 10
}
print(roster[0].oxygen)   // author expected the crew to have lost oxygen

// Report 2
let podA = TeleportPod(id: "A", chargeLevel: 100)
let podB = podA
podB.chargeLevel = 0
print(podA.chargeLevel)   // author expected 100

// Report 3
struct Logbook {
    var entries: [String] = []
    func add(_ entry: String) {
        entries.append(entry)
    }
}

// Report 4
let snapshot = CrewSnapshot.rookie(named: "Dana")
snapshot.oxygen = 40

let pod = TeleportPod(id: "B", chargeLevel: 50)
pod.chargeLevel = 10
*/


// MARK: Level 7 · Sealing the Black Box

// The leaky original:
//
// class FlightRecorder {
//     var entries: [String] = []
//     var isSealed = false
// }
//
// Your sealed version below. One comment per access keyword.

// final class FlightRecorder { }

// A free function elsewhere in the file that uses your fileprivate helper:
// func auditTranscript(of recorder: FlightRecorder) -> String { }


// MARK: Finale · Integrity Code

// let D = ...
// let integrityCode = "\(A)-\(B)-\(C)-\(D)"
// print("INTEGRITY CODE: \(integrityCode)")


// MARK: Bonus

// deinit in TeleportPod, a do-block lifetime experiment, and === identity


// MARK: - ================= DEFENSE QUESTIONS =================
/*
 1. Why did CrewSnapshot get an initializer for free and TeleportPod did not?

 2. What does `mutating` do to self, and why do classes never need it?

 3. In Report 4 both values are `let`. What exactly does `let` freeze for a
    struct, and what does it freeze for a class?

 4. Why must a lazy property be var? When does lazy change behaviour, not
    just performance?

 5. private vs fileprivate: where in your FlightRecorder would private be
    too strict?

 Bonus. On which line does deinit fire, and why can't === be used on
 CrewSnapshot?

*/

// MARK: - =================== YOUR SOLUTION ===================

// MARK: Level 1 · The Deck Register

// 1.1
// Internal is explicit: this type is available throughout this file/module.
enum Deck: String, CaseIterable {
    case bridge
    case lab
    case cargo
    case medbay
    case engine

    var evacuationPriority: Int {
        switch self {
        case .bridge: return 1
        case .medbay: return 2
        case .lab: return 3
        case .engine: return 4
        case .cargo: return 5
        }
    }
}

for deck in Deck.allCases {
    print("Deck: \(deck.rawValue), priority: \(deck.evacuationPriority)")
}
print("Deck count: \(Deck.allCases.count)")

// 1.2
enum AlarmLevel: Int {
    case green = 0
    case yellow
    case orange
    case red

    static func level(forTotalMass mass: Int) -> AlarmLevel {
        let steps = mass / 500
        let capped = steps > AlarmLevel.red.rawValue ? AlarmLevel.red.rawValue : steps
        return AlarmLevel(rawValue: capped) ?? .red
    }
}

print("Alarm 0 kg: \(AlarmLevel.level(forTotalMass: 0))")
print("Alarm 940 kg: \(AlarmLevel.level(forTotalMass: 940))")
print("Alarm 4000 kg: \(AlarmLevel.level(forTotalMass: 4000))")

// MARK: Level 2 · The Manifest

// 2.1
enum ManifestEntry {
    case crate(id: Int, massKg: Int)
    case container(code: String, massKg: Int)
    case livestock(species: String, count: Int, massPerUnitKg: Int)
    case unknown(raw: String)
}

// 2.2
func parseEntry(_ line: String) -> ManifestEntry {
    let parts = fields(line)

    guard let tag = parts.first else {
        return .unknown(raw: line)
    }

    switch tag {
    case "crate":
        guard parts.count == 3,
              let id = Int(parts[1]),
              let massKg = Int(parts[2]) else {
            return .unknown(raw: line)
        }
        return .crate(id: id, massKg: massKg)

    case "container":
        guard parts.count == 3,
              let massKg = Int(parts[2]) else {
            return .unknown(raw: line)
        }
        return .container(code: parts[1], massKg: massKg)

    case "livestock":
        guard parts.count == 4,
              let count = Int(parts[2]),
              let massPerUnitKg = Int(parts[3]) else {
            return .unknown(raw: line)
        }
        return .livestock(species: parts[1], count: count, massPerUnitKg: massPerUnitKg)

    default:
        return .unknown(raw: line)
    }
}

// 2.3
func mass(of entry: ManifestEntry) -> Int {
    switch entry {
    case let .crate(_, massKg):
        return massKg
    case let .container(_, massKg):
        return massKg
    case let .livestock(_, count, massPerUnitKg):
        return count * massPerUnitKg
    case .unknown:
        return 0
    }
}

var manifestMass = 0
var unknownCount = 0

for line in rawManifest {
    let entry = parseEntry(line)
    manifestMass += mass(of: entry)

    if case .unknown = entry {
        unknownCount += 1
    }
}

let A = manifestMass

func manifestDescription(_ entry: ManifestEntry) -> String {
    switch entry {
    case let .crate(id, massKg):
        return "crate id=\(id), mass=\(massKg) kg"
    case let .container(code, massKg):
        return "container code=\(code), mass=\(massKg) kg"
    case let .livestock(species, count, massPerUnitKg):
        return "livestock species=\(species), count=\(count), unit mass=\(massPerUnitKg) kg"
    case let .unknown(raw):
        return "unknown raw=\(raw)"
    }
}

print("First parsed manifest entry: \(manifestDescription(parseEntry(rawManifest[0])))")
print("Corrupted parsed entry: \(manifestDescription(parseEntry(rawManifest[3])))")
print("Unknown manifest lines: \(unknownCount)")
print("Total manifest mass A: \(A) kg")

// MARK: Level 3 · Crew Snapshots

// 3.1
struct CrewSnapshot {
    let name: String
    var deck: Deck
    var oxygen: Int

    mutating func breathe(_ amount: Int) {
        oxygen = max(0, oxygen - amount)
    }

    mutating func move(to deck: Deck) {
        self.deck = deck
    }

    mutating func reviveInMedbay() {
        self = CrewSnapshot(name: name, deck: .medbay, oxygen: 100)
    }

    static func rookie(named name: String) -> CrewSnapshot {
        CrewSnapshot(name: name, deck: .bridge, oxygen: 100)
    }
}

// 3.2
var crewRoster: [CrewSnapshot] = []

for record in crewData {
    if let deck = Deck(rawValue: record.deck) {
        crewRoster.append(
            CrewSnapshot(name: record.name, deck: deck, oxygen: record.oxygen)
        )
    } else {
        print("Warning: skipped crew member \(record.name), unknown deck \(record.deck)")
    }
}

print("Crew roster count: \(crewRoster.count)")
print("First crew member: \(crewRoster[0].name)")

// 3.3 · Value-semantics demonstration

func changeWithoutInout(_ snapshot: CrewSnapshot) -> CrewSnapshot {
    var changed = snapshot
    changed.breathe(10)
    return changed
}

func changeWithInout(_ snapshot: inout CrewSnapshot) {
    snapshot.breathe(10)
}

var original = crewRoster[0]
print("Copy demo before: original oxygen = \(original.oxygen)")
var copy = original
copy.breathe(20)
print("Copy demo after: original oxygen = \(original.oxygen), copy oxygen = \(copy.oxygen)")

print("Plain parameter before: original oxygen = \(original.oxygen)")
let plainChanged = changeWithoutInout(original)
print("Plain parameter after: original oxygen = \(original.oxygen), returned copy oxygen = \(plainChanged.oxygen)")

print("inout before: original oxygen = \(original.oxygen)")
changeWithInout(&original)
print("inout after: original oxygen = \(original.oxygen)")

// Exercise additional struct methods.
var demoCrew = CrewSnapshot.rookie(named: "Demo")
print("Rookie: \(demoCrew.name), deck: \(demoCrew.deck.rawValue), oxygen: \(demoCrew.oxygen)")
demoCrew.move(to: .lab)
demoCrew.reviveInMedbay()
print("After move + revive: \(demoCrew.deck.rawValue), oxygen: \(demoCrew.oxygen)")

// MARK: Level 4 · The Teleport Pod

// A struct receives a memberwise initializer automatically; this class defines
// its own stored-property initialization, so its initializer must be written.
final class TeleportPod {
    let id: String
    var chargeLevel: Int
    var occupant: CrewSnapshot?

    init(id: String, chargeLevel: Int) {
        self.id = id
        self.chargeLevel = chargeLevel
        self.occupant = nil
    }

    func load(_ crew: CrewSnapshot) -> Bool {
        guard occupant == nil, chargeLevel >= 20 else {
            return false
        }
        occupant = crew
        return true
    }

    func fire() -> CrewSnapshot? {
        guard let crew = occupant else {
            return nil
        }

        chargeLevel -= 20
        occupant = nil
        return crew
    }
}

// 4.2
let pod = TeleportPod(id: "P-1", chargeLevel: 100)

let loadedTimur = pod.load(crewRoster[0])
print("Step 1: loaded Timur = \(loadedTimur), charge = \(pod.chargeLevel)")
let firedTimur = pod.fire()
print("Step 1 fire: returned = \(firedTimur?.name ?? "nil"), charge = \(pod.chargeLevel)")

let loadedDana = pod.load(crewRoster[1])
print("Step 2: loaded Dana = \(loadedDana), charge = \(pod.chargeLevel)")
let firedDana = pod.fire()
print("Step 2 fire: returned = \(firedDana?.name ?? "nil"), charge = \(pod.chargeLevel)")

let loadedNurlan = pod.load(crewRoster[3])
print("Step 3: loaded Nurlan = \(loadedNurlan), charge = \(pod.chargeLevel)")
let firedNurlan = pod.fire()
print("Step 3 fire: returned = \(firedNurlan?.name ?? "nil"), charge = \(pod.chargeLevel)")

let emptyFire = pod.fire()
print("Step 4 empty fire: returned = \(emptyFire?.name ?? "nil"), charge = \(pod.chargeLevel)")

let C = pod.chargeLevel
print("Final pod charge C: \(C)")

// 4.3 · Reference-semantics demonstration
let secondPodReference = pod
pod.chargeLevel = 15
print("Reference demo: pod charge = \(pod.chargeLevel)")
print("Reference demo: second reference charge = \(secondPodReference.chargeLevel)")

var snapshotA = crewRoster[0]
var snapshotB = snapshotA
snapshotA.breathe(10)
print("Struct demo: snapshotA oxygen = \(snapshotA.oxygen)")
print("Struct demo: snapshotB oxygen = \(snapshotB.oxygen)")
// Classes use reference semantics: two variables can refer to the same object.
// Structs use value semantics: assigning a struct creates an independent value.

// MARK: Level 5 · Station Systems

final class Station {
    // Explicit internal access: the call sign can be read inside the module but cannot be changed.
    internal let callSign: String

    // Explicit internal access: the live hull value is visible and writable inside the module.
    internal var hullIntegrity: Int {
        willSet {
            print("Hull transition: \(hullIntegrity) -> \(newValue)")
        }
        didSet {
            if hullIntegrity < 0 {
                hullIntegrity = 0
            } else if hullIntegrity > 100 {
                hullIntegrity = 100
            }
        }
    }

    // Explicit internal access: diagnostics are created only when first accessed.
    internal lazy var fullDiagnostics: String = {
        print("Running full scan...")
        var result = "Diagnostics for \(callSign):"
        result += " hull=\(hullIntegrity)"
        result += " oxygen=\(totalOxygen)"
        result += " decks=\(oxygenByDeck.count)"
        return result
    }()

    // Explicit internal access: read-only computed property.
    internal var totalOxygen: Int {
        var total = 0
        for oxygen in oxygenByDeck.values {
            total += oxygen
        }
        return total
    }

    // Explicit internal access: computed property with a setter that updates every deck.
    internal var averageOxygen: Int {
        get {
            guard !oxygenByDeck.isEmpty else {
                return 0
            }
            return totalOxygen / oxygenByDeck.count
        }
        set {
            for deck in oxygenByDeck.keys {
                oxygenByDeck[deck] = newValue
            }
        }
    }

    // Explicit internal access: stored dictionary of valid deck readings.
    internal var oxygenByDeck: [Deck: Int]

    init(callSign: String, hullIntegrity: Int, readings: [(deck: String, oxygen: Int)]) {
        self.callSign = callSign
        self.hullIntegrity = hullIntegrity
        self.oxygenByDeck = [:]

        for reading in readings {
            if let deck = Deck(rawValue: reading.deck) {
                oxygenByDeck[deck] = reading.oxygen
            }
        }
    }
}

let station = Station(callSign: "ALMA-7", hullIntegrity: 85, readings: deckReadings)

// Prove lazy property is not touched here: no scan message appears yet.
print("Station call sign: \(station.callSign)")
print("Starting total oxygen: \(station.totalOxygen)")
print("Starting average oxygen B: \(station.averageOxygen)")

let B = station.averageOxygen

print("First diagnostics access: \(station.fullDiagnostics)")
print("Second diagnostics access: \(station.fullDiagnostics)")

// 5.2 · The clamp trap
station.hullIntegrity = 130
print("Hull after 130: \(station.hullIntegrity)")
station.hullIntegrity = -40
print("Hull after -40: \(station.hullIntegrity)")
station.hullIntegrity = 55
print("Hull after 55: \(station.hullIntegrity)")
// didSet assignments to the observed property do not recursively trigger the
// observer again, so the clamp does not loop forever.

// Exercise computed setter and read-only computed property.
station.averageOxygen = 50
print("Average after setter: \(station.averageOxygen)")
print("Total after setter: \(station.totalOxygen)")

// MARK: Level 6 · Incident Reports

/*
Report 1
Expectation: the crew roster should lose 10 oxygen.
Actual: `member` is a local copy of each CrewSnapshot, so the array is unchanged.
Rule: CrewSnapshot is a struct (value type), and a for-in loop variable is a copy.
Fix: mutate the array element by index.
*/
for index in crewRoster.indices {
    crewRoster[index].oxygen = max(0, crewRoster[index].oxygen - 10)
}
print("Report 1 fixed: first crew oxygen = \(crewRoster[0].oxygen)")

/*
Report 2
Expectation: podA should remain at 100.
Actual: podA and podB refer to the same TeleportPod object, so podA becomes 0.
Rule: TeleportPod is a class (reference type).
Fix: create a separate TeleportPod object when an independent pod is required.
*/
let fixedPodA = TeleportPod(id: "A-fixed", chargeLevel: 100)
let fixedPodB = TeleportPod(id: "B-fixed", chargeLevel: 100)
fixedPodB.chargeLevel = 0
print("Report 2 fixed: podA = \(fixedPodA.chargeLevel), podB = \(fixedPodB.chargeLevel)")

/*
Report 3
Expectation: add() should append an entry.
Actual: it does not compile because a struct instance method cannot mutate a stored property without `mutating`.
Rule: value types need `mutating` for methods that change self or its stored properties.
Fix: mark add as mutating.
*/
struct Logbook {
    var entries: [String] = []

    mutating func add(_ entry: String) {
        entries.append(entry)
    }
}

var logbook = Logbook()
logbook.add("fixed report")
print("Report 3 fixed count: \(logbook.entries.count)")
print("Report 3 fixed entry: \(logbook.entries[0])")

/*
Report 4
Expectation: both assignments should work because both variables use `let`.
Actual: snapshot.oxygen is an error, while pod.chargeLevel is allowed.
Rule: `let` freezes a struct value, but for a class it freezes the reference, not the object's mutable properties.
Fix: make snapshot `var` if its properties must change; pod can stay `let` when only its mutable properties change.
*/
var fixedSnapshot = CrewSnapshot.rookie(named: "Dana")
fixedSnapshot.oxygen = 40
let fixedPod = TeleportPod(id: "B", chargeLevel: 50)
fixedPod.chargeLevel = 10
print("Report 4 fixed snapshot oxygen: \(fixedSnapshot.oxygen)")
print("Report 4 fixed pod charge: \(fixedPod.chargeLevel)")

// MARK: Level 7 · Sealing the Black Box

final class FlightRecorder {
    // `private` blocks direct access to the stored entry list outside this type.
    private var entries: [String] = []

    // `private(set)` blocks outside code from changing the seal state while allowing it to read it.
    private(set) var isSealed = false

    // `internal` allows normal use from elsewhere in this module.
    internal var entryCount: Int {
        entries.count
    }

    // `internal` allows outside code to add entries only through the guarded method.
    internal func add(_ entry: String) {
        guard !isSealed else {
            return
        }
        entries.append(entry)
    }

    // `internal` allows outside code to seal the recorder but not reopen it.
    internal func seal() {
        isSealed = true
    }

    // `internal` allows outside code to read the formatted transcript.
    internal var transcript: String {
        entries.joined(separator: "\n")
    }

    // `fileprivate` allows the free audit function in this file to inspect entries,
    // while code in other files cannot use this helper.
    fileprivate func auditEntries() -> [String] {
        entries
    }
}

// `internal` free function can call the recorder's fileprivate helper because it is in this file.
func auditTranscript(of recorder: FlightRecorder) -> String {
    let entries = recorder.auditEntries()
    return "AUDIT: \(entries.count) entries"
}

let recorder = FlightRecorder()
recorder.add("Crew transfer verified")
recorder.add("Manifest verified")
print("Recorder count: \(recorder.entryCount)")
print("Recorder transcript:\n\(recorder.transcript)")
recorder.seal()
recorder.add("This entry must be rejected")
print("Recorder sealed: \(recorder.isSealed)")
print(auditTranscript(of: recorder))

/*
Failed attempts that must remain comments:

recorder.entries.removeAll()
// error: 'entries' is inaccessible due to 'private' protection level

recorder.isSealed = false
// error: cannot assign to property: 'isSealed' setter is inaccessible
*/

// MARK: Finale · Integrity Code

let D = AlarmLevel.level(forTotalMass: A).rawValue
let integrityCode = "\(A)-\(B)-\(C)-\(D)"
print("INTEGRITY CODE: \(integrityCode)")

// MARK: Bonus

/*
Bonus is intentionally left out of the required 10-point solution.
*/

// MARK: - ================= DEFENSE QUESTIONS =================
/*
1. Why did CrewSnapshot get an initializer for free and TeleportPod did not?

CrewSnapshot is a struct with stored properties and no custom initializer, so Swift
provides a memberwise initializer. TeleportPod is a class, and Swift does not give
it the same memberwise initializer, so we write init(id:chargeLevel:) ourselves.

2. What does `mutating` do to self, and why do classes never need it?

For a struct, `mutating` tells Swift that the method is allowed to change the value
of self or its stored properties. Classes use reference semantics, so their methods
can change the referenced object's properties without the `mutating` keyword.

3. In Report 4 both values are `let`. What exactly does `let` freeze for a struct,
and what does it freeze for a class?

For a struct, `let` makes the whole value immutable, so snapshot.oxygen cannot change.
For a class, `let` makes the reference itself constant. The referenced object can still
change its var properties, so pod.chargeLevel is allowed to change.

4. Why must a lazy property be var? When does lazy change behaviour, not just performance?

A lazy property is initialized after the instance has already been created, so Swift
needs to store the initialized value later; therefore it must be var. Lazy changes
behaviour when initialization has side effects or depends on state: the code is not
executed at initialization time and is only executed when the property is first read.

5. private vs fileprivate: where in your FlightRecorder would private be too strict?

The entries array itself should stay private. The auditEntries() helper uses fileprivate
because the free auditTranscript function elsewhere in the same file needs controlled
access to those entries. Plain private would be too strict for that separate function.

Bonus. On which line does deinit fire, and why can't === be used on CrewSnapshot?

If the bonus pod has another strong reference, deinit does not fire when the do block
ends; it fires when the last strong reference is released. `===` is an identity operator
for class instances. CrewSnapshot is a struct, so it has value semantics and no object
identity, therefore `===` cannot be used with it.
*/
