//
//  SessionsModel.swift
//  TimFretello
//
//  Created by Tim on 28/01/2021.
//

import Foundation

struct SessionsResponse: Codable {
    var name, practicedOnDate: String?
    var exercises: [SessionExercisesResponse?]
}

struct SessionExercisesResponse: Codable {
    var exerciseId: String?
    var name: String?
    var practicedAtBpm: Int?
}
