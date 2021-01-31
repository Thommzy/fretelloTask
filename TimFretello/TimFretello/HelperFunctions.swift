//
//  HelperFunctions.swift
//  TimFretello
//
//  Created by Tim on 29/01/2021.
//

import Foundation


//MARK:- This Function get the maximum Percent.
func getMax(_ arrArr: [[Int]]) -> Int {
    
    var tuples = [(Double, Int)]()
    var i = 0
    var j = 1
    
    while i < arrArr.count {
        let average = getAverage(arr: arrArr[i])
        let highest = getHighest(arr: arrArr[j])
        tuples.append((average, highest))
        if j == arrArr.count - 1 {
            break
        }
        j += 1
        i += 1
    }
    
    var k = 0
    var percentArray : [Int] = []
    while k < tuples.count {
        let perAv = getPercentagePerAverage(highest: tuples[k].1, average: tuples[k].0)
        percentArray.append(perAv)
        k += 1
    }
    
    let highestPercentage = percentArray.max()
    let final = highestPercentage ?? Int()
    
    return final
}

//MARK:-This Function Gets the Average of each Array
func getAverage(arr: [Int]) -> Double {
    let total = arr.reduce(0, +)
    let count = arr.count
    let average = Double(total)/Double(count)
    return average
}

//MARK:-This Function gets The highest of Each arrays
func getHighest(arr: [Int]) -> Int {
    let highest = arr.max()
    return highest ?? Int()
}

//MARK:- This Function gets percentage of each.
func getPercentagePerAverage(highest: Int, average: Double) -> Int {
    let percent = highest * 100
    let final = Double(percent) / average
    let convertFinalToInt = Int(final)
    return convertFinalToInt
}
