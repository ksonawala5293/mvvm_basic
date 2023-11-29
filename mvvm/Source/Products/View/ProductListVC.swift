//
//  ProductListVC.swift
//  mvvm
//
//  Created by Apple on 29/11/23.
//

import UIKit

class ProductListVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var tblList: UITableView!
    
    //MARK: - Variables
    let vmProducts = ProductVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configuration()
    }
}

extension ProductListVC {
    
    func configuration() {
        initModel()
        eventHandlers()
    }
    
    func initModel() {
        vmProducts.fetchProductList()
    }
    
    func eventHandlers() {
        vmProducts.eventListner = {[weak self] event in
            guard let self else {return}
            
            switch event {
            case .startLoading:
                break
            case .stopLoading:
                break
            case .dataReceived:
                print(vmProducts.arrProductList)
            case .error(_):
                break
            }
        }
    }
    
}

extension ProductListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
