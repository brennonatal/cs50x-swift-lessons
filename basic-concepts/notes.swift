//
//  lesson-1.swift
//  Introduction-to-Swift
//
//  Created by Brenno Natal on 09/12/20.
//

import Foundation

print("Hello, World!")

//  VARIABLES
let name: String = "Alice"
var age: Int = 21
//  ARRAYS
let values: [Int] = [1, 2, 3, 4, 5]

for v in values {
    print("\(v)")
}
//  DICTIONARIES
let airports: [String : String] = [
    "BOS": "Boston",
    "SFO": "Sao Franscisco",
    "YYZ": "Toronto Pearson",
    "DUB": "Dublin"
]
for (code, name) in airports {
    print("\(code): \(name)")
}
print("The airports dictionary contains \(airports.count) items.")

if let airportName = airports["DUB"] {
    print("The name of the airport is \(airportName).")
} else {
    print("That airport is not in the airports dictionary.")
}

//  FUNCTIONS
func sayHello(name: String) -> String {
    let message = "Hello, \(name)"
    print(message)
    return message
}
let myName = sayHello(name: "Brenno")

//  STRUCTS
struct Course {
    let name: String
    let instructor: String
}

//  CLASSES
class Person {
    private var name: String
    init(name: String) { //  constructor
         self.name = name
    }
    func sayHello() {
        print("Hello, I'm \(name)!")
    }
    func getName() -> String {
        return name
    }
}
let person: Person = Person(name: "Gu")
person.sayHello()
print(person.getName())

//  INHERITANCE (HERANÇA)
class Vehicle {
    func wheels() -> Int {
        return 4
    }
    func go() {
        print("Zoom!")
    }
}
class Motorcycle: Vehicle {
    override func wheels() -> Int {
        return 2
    }
    override func go() {
        print("Vraaau!")
    }
}
let car: Vehicle = Vehicle()
print(car.wheels())
car.go()

let moto: Motorcycle = Motorcycle()
print(moto.wheels())
moto.go()

//  PROTOCOLS (INTERFACES)
protocol Teacher {
    func teach();
}

class CS50Teacher: Teacher {
    func teach() {
        print("Teaching...")
    }
}

//  OPTIONALS
var color: String?
if let c = color {  //  if color != nil {
    print(c)
} else {
    print("No color")
}

//  same as above
func printColorName() {
    guard let c = color else {
        print("No color")
        return
    }
    print(c)
}

//  TRY, CATCH
do {
    let results = try something()
}
catch let error {
   print(error)
}

//  CLOSURES
let reversed = names.sorted(by: {(
    s1: String,
    s2: String
) -> Bool in 
    return s1 > s2
})

