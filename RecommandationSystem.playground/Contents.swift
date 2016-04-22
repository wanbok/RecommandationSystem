//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

let critics = [
    "Lisa Rose": [
        "Lady in the Water": 2.5,
        "Snakes on a Plane": 3.5,
        "Just My Luck": 3.0,
        "Superman Returns": 3.5,
        "You, Me and Dupree": 2.5,
        "The Night Listener": 3.0,
    ],
    "Gene Seymour": [
        "Lady in the Water": 3.0,
        "Snakes on a Plane": 3.5,
        "Just My Luck": 1.5,
        "Superman Returns": 5.0,
        "The Night Listener": 3.0,
        "You, Me and Dupree": 3.5,
    ],
    "Michael Phillips": [
        "Lady in the Water": 2.5,
        "Snakes on a Plane": 3.0,
        "Superman Returns": 3.5,
        "The Night Listener": 4.0,
    ],
    "Claudia Puig": [
        "Snakes on a Plane": 3.5,
        "Just My Luck": 3.0,
        "The Night Listener": 4.5,
        "Superman Returns": 4.0,
        "You, Me and Dupree": 2.5,
    ],
    "Mick LaSalle": [
        "Lady in the Water": 3.0,
        "Snakes on a Plane": 4.0,
        "Just My Luck": 2.0,
        "Superman Returns": 3.0,
        "The Night Listener": 3.0,
        "You, Me and Dupree": 2.0,
    ],
    "Jack Matthews": [
        "Lady in the Water": 3.0,
        "Snakes on a Plane": 4.0,
        "The Night Listener": 3.0,
        "Superman Returns": 5.0,
        "You, Me and Dupree": 3.5,
    ],
    "Toby": [
        "Snakes on a Plane": 4.5,
        "You, Me and Dupree": 1.0,
        "Superman Returns": 4.0,
    ],
]
let keys = Array(critics.keys)

func person(index: Int) -> [String: Double]? {
    if !(keys.count > index) { return nil }
    let personName = keys[index]
    return critics[personName]
}

func euclideanDistance(firstIndex: Int, _ secondIndex: Int) -> Double? {
    guard let firstPerson = person(firstIndex),
        secondPerson = person(secondIndex) else { return nil }
    let listOfMovies = firstPerson.keys.filter { secondPerson.keys.contains($0) }
    
    let distances = listOfMovies
        .map { movie -> Double in
            let firstScore = firstPerson[movie] ?? 0
            let secondScore = secondPerson[movie] ?? 0
            return pow(firstScore - secondScore, 2)
        }
        .reduce(0.0) { $0 + $1 }
    
    return 1/(1+sqrt(distances))
}

var euclideanResult = [(String, String, Double)]()
for (index1, key1) in keys.enumerate() {
    for (index2, key2) in keys.enumerate() {
        if index1 >= index2 { continue }
//        XCPlaygroundPage.currentPage.captureValue(euclideanDistance(index1, index2) ?? 0, withIdentifier: key1 + ", " + key2)
//        euclideanResult += [(key1, key2, euclideanDistance(index1, index2) ?? 0)]
        print("\(key1), \(key2): \(euclideanDistance(index1, index2) ?? 0)")
    }
}

func pearsonCorrelationCoefficient(firstIndex: Int, _ secondIndex: Int) -> Double? {
    guard let firstPerson = person(firstIndex),
        secondPerson = person(secondIndex) else { return nil }
    let listOfMovies = firstPerson.keys.filter { secondPerson.keys.contains($0) }
    let count = Double(listOfMovies.count)
    
    // 선호도 합산
    let firstSum = listOfMovies
        .map { firstPerson[$0] ?? 0 }
        .reduce(0.0) { $0 + $1 }
    
    let secondSum = listOfMovies
        .map { secondPerson[$0] ?? 0 }
        .reduce(0.0) { $0 + $1 }
    
    // 제곱의 합을 계산
    let firstSqrt = listOfMovies
        .map { pow(firstPerson[$0] ?? 0, 2) }
        .reduce(0.0) { $0 + $1 }
    
    let secondSqrt = listOfMovies
        .map { pow(secondPerson[$0] ?? 0, 2) }
        .reduce(0.0) { $0 + $1 }
    
    // 곱의 합을 계산
    let multipleSum = listOfMovies
        .map { (firstPerson[$0] ?? 0) * (secondPerson[$0] ?? 0) }
        .reduce(0.0) { $0 + $1 }
    
    // 피어슨 점수 계산
    let num = multipleSum - firstSum * secondSum / count
    let den = sqrt( (firstSqrt - pow(firstSum, 2) / count) * (secondSqrt - pow(secondSum, 2) / count) )

    return num / den
}

//pearsonCorrelationCoefficient(0, 1)

var pearsonResult = [(String, String, Double)]()
for (index1, key1) in keys.enumerate() {
    for (index2, key2) in keys.enumerate() {
        if index1 >= index2 { continue }
//        XCPlaygroundPage.currentPage.captureValue(pearsonCorrelationCoefficient(index1, index2) ?? 0, withIdentifier: key1 + ", " + key2)
//        pearsonResult += [(key1, key2, pearsonCorrelationCoefficient(index1, index2) ?? 0)]
        print("\(key1), \(key2): \(pearsonCorrelationCoefficient(index1, index2) ?? 0)")
    }
}