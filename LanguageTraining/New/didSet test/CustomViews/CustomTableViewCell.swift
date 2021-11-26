//
//  CustomTableViewCell.swift
//  didSet test
//
//  Created by Andrey Alymov on 02.11.2021.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: CustomTableViewCell.self)
    
    @IBOutlet weak var label: UILabel!
    
    public func configure(with viewModel: CustomCellViewModel) {
        label.text = "\(viewModel.firstName!) \(viewModel.lastName) - \(viewModel.age) yo."
    }
    
}
