//
//  HomeWorker.swift
//  TimFretello
//
//  Created by Tim on 28/01/2021.
//

import Foundation

protocol GetDataProtocol {
    func getData(success: @escaping ([SessionsResponse]) -> (), failure: @escaping (String) -> ())
}

class GetDataWorker: GetDataProtocol {
    var networkClient: FreTelloApiClient?
    
    func getData(success: @escaping ([SessionsResponse]) -> (), failure: @escaping (String) -> ()) {
        networkClient?.execute(url: "\(FreTello.baseURL)data/sessions.json", success: { (response) in
            success(response)
        }, failure: { (error) in
            failure(error)
        })
    }
    
}
