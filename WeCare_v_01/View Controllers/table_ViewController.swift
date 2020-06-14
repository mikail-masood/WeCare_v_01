//
//  table_ViewController.swift
//  WeCare_v_01
//
//  Created by Mikail Masood on 2020-05-13.
//  Copyright © 2020 Mikail Masood. All rights reserved.
//

import UIKit

class table_ViewController: UIViewController {
    
    var tableView = UITableView()
    var vital_list = ["Vitals", "Medication", "Intake", "Output", "Hygiene", "Positioning",
                        "Bed Sore Degree", "Dressing", "Activity"]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        setDelegates()
        tableView.rowHeight = 90
        tableView.register(vital_TableViewCell.self, forCellReuseIdentifier: "cellID")
        tableView.pin(to: view)
        tableView.separatorColor = UIColor.white
        
    }
    
    func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    

}


extension table_ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vital_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! vital_TableViewCell
        cell.backgroundColor = UIColor.white
        let vitals = vital_list[indexPath.row]
        cell.cellLabel.text = vitals
        return cell
    }
    
}
