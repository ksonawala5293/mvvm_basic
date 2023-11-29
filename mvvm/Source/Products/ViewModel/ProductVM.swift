//
//  ProductVM.swift
//  mvvm
//
//  Created by Apple on 29/11/23.
//

import Foundation



class ProductVM {
    
    var arrProductList = [ProductBaseModel]()
    var eventListner: ((_ event: Listeners) -> ())?
    
    func fetchProductList() {
        eventListner?(.startLoading)
        APIManager.shared.fetchAPI { response in
            switch response {
            case .success(let data):
                self.arrProductList = data
                self.eventListner?(.dataReceived)
            case .failure(_):
                self.eventListner?(.stopLoading)
                break
            }
        }
    }
}

extension ProductVM {
    enum Listeners {
        case startLoading
        case stopLoading
        case dataReceived
        case error(Error?)
    }
}
