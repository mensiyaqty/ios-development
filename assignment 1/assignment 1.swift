let name = "Temirlan"
let surname = "Nussipkozha"
let birthYear = 2006
let height: Double = 1.79
let currentYear = 2026 
let isStudent: Bool = true
let age = currentYear - birthYear

let hobby = "playing cs"
let numberOfHobbies = 4
let favoriteNumber = 22
let isHobbyCreative: Bool = false

let lifestory = """
My name is \(name) \(surname). I am \(age) years old, born in \(birthYear). 
I am currently \(isStudent ? "a student" : "not a student"). 
I enjoy \(hobby), which is a \(isHobbyCreative ? "a creative" : "not a creative") hobby.
I have \(numberOfHobbies) hobbies in total, and my favorite number is \(favoriteNumber)
"""

print (lifestory)
