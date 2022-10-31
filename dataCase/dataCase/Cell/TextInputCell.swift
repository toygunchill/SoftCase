//
//  TextInputCell.swift
//  dataCase
//
//  Created by Toygun Çil on 31.10.2022.
//

import UIKit

class TextInputCell: UITableViewCell {
    
    //MARK: - UIElements
    
    let textField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    //MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textInputConfigure()
    }
    
    required init(coder: NSCoder) {
        fatalError("err")
    }
    
    //MARK: - Cell Identifier
    
    enum Identifier: String {
        case custom = "textInputCell"
    }
}

extension TextInputCell {
    
    func textInputConfigure() {
        textInputSubviews()
        textInputDrawDesign()
    }
    
    func textInputDrawDesign() {
        textField.placeholder = "textInput"
        textField.backgroundColor = .systemGray6
    }
    
    func textInputSubviews() {
        contentView.addSubview(textField)
        textField.frame = CGRect(x: 8, y: 8, width: bounds.width, height: bounds.height)
    }
}
