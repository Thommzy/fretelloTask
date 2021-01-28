//
//  HomeViewPresenter.swift
//  TimFretello
//
//  Created by Tim on 28/01/2021.
//

import Foundation

protocol GetDataPresentationLogic {
    func displayResponse(alert: [SessionsResponse])
    func displayError(alert: String)
}

class GetDataPresenter: GetDataPresentationLogic {
    
    var view : GetDataDisplayLogic?
    
    func displayResponse(alert: [SessionsResponse]) {
        view?.displayDataAlert(alert: alert)
    }
    
    func displayError(alert: String) {
        view?.displayErrorAlert(alert: alert)
    }
    
}
