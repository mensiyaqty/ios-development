let set1: Set = [1, 2, 3, 4]
let set2: Set = [3, 4, 5, 6]
let commonElements = set1.intersection(set2)
print(commonElements)

var studentScores = ["Arman": 85, "Aru": 90, "Beka": 78]
studentScores.updateValue(95, forKey: "Beka")
print(studentScores)

let array1 = ["apple", "banana"]
let array2 = ["cherry", "date"]
let mergedArray = array1 + array2
print(mergedArray)