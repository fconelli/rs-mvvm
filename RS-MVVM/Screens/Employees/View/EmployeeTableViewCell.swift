//
//  EmployeeTableViewCell.swift
//  RS-MVVM
//
//  Created by Francisco Conelli on 07/03/2022.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    
    func configure(with presentable: EmployeePresentable) {
        nameLabel.text = presentable.name
        ageLabel.text = presentable.age
        salaryLabel.text = presentable.salary
    }
}
