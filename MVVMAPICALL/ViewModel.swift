//
//  ViewModel.swift
//  MVVMAPICALL
//
//  Created by D2V iMac on 11/02/20.
//  Copyright © 2020 D2V iMac. All rights reserved.
//

import UIKit
import Foundation

class ListViewModel {
    
    var reloadList = {() -> () in }
    var errorMsg = {(msg: String) -> () in}
    
    var arrayOfList : [User] = []{
        
        didSet{
            reloadList()
        }
        
    }
    
    
    func getListData() {
        
        let str = "https://jsonplaceholder.typicode.com/posts/"
        let urlStr = URL(string: str)!
        
        URLSession.shared.dataTask(with: urlStr) { (data, response, error) in
            
            guard let rData = data else {
                
                return
            }

            do{
                let json = try JSONDecoder().decode([User].self, from: rData)
                print(json)
                self.arrayOfList = json
                
            }catch let error{
                print(error.localizedDescription)
                self.errorMsg(error.localizedDescription)
                
            }
        }.resume()
    }
    
}

