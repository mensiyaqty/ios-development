var populations = ["Kazakhstan": 20000000, "France": 67000000]
populations["Japan"] = 125000000
print(populations)

let setA: Set = ["cat", "dog"]
let setB: Set = ["dog", "mouse"]
let unionSet = setA.union(setB)
let finalSet = unionSet.subtracting(setB)
print(finalSet)

let studentGrades: [String: [Int]] = [
    "Roma": [85, 92, 78],
    "Aya": [90, 88, 95]
]
print(studentGrades["Roma"]![1])