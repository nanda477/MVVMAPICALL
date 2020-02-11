//
//  ViewController.swift
//  MVVMAPICALL
//
//  Created by D2V iMac on 11/02/20.
//  Copyright © 2020 D2V iMac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var listView: UITableView!
    var modelData = ListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        modelData.getListData()

        
        modelData.reloadList = { [weak self] in

            DispatchQueue.main.async {
                self?.listView.reloadData()
            }

        }
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return modelData.arrayOfList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ViewCell_ID") as! ViewCell
        cell.textLabel?.text = "\(modelData.arrayOfList[indexPath.row].id)"
        return cell
    }
    
    
}

