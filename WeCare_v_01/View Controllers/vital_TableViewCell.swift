//
//  vital_TableViewCell.swift
//  WeCare_v_01
//
//  Created by Mikail Masood on 2020-05-13.
//  Copyright © 2020 Mikail Masood. All rights reserved.
//

import UIKit

class vital_TableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        addSubview(cellView)
        cellView.addSubview(cellLabel)
        self.selectionStyle = .none
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        cellLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        cellLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        cellLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        cellLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 20).isActive = true
        
    }
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red:0.12, green:0.66, blue: 0.62, alpha: 1)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let cellLabel: UILabel = {
        let label = UILabel()
        label.text = "Vitals"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
}
