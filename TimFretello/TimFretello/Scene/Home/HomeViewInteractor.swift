//
//  HomeViewInteractor.swift
//  TimFretello
//
//  Created by Tim on 28/01/2021.
//

import Foundation

protocol GetDataBusinessLogic {
    func getData()
}

class GetDataInteractor: GetDataBusinessLogic {
    
    var worker: GetDataProtocol?
    var presenter: GetDataPresentationLogic?
    
    func getData() {
        worker?.getData(success: { [unowned self] feedback in
            presenter?.displayResponse(alert: feedback)
        }, failure: { [unowned self] error in
            presenter?.displayError(alert: error)
        })
    }
    
}
