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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with presentable: EmployeePresentable) {
        nameLabel.text = presentable.name
        ageLabel.text = presentable.age
        salaryLabel.text = presentable.salary
    }
}
