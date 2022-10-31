//
//  HeaderCell.swift
//  dataCase
//
//  Created by Toygun Çil on 29.10.2022.
//

import UIKit
import SnapKit

class HeaderCell: UITableViewCell {
    
    //MARK: - UIElements
    
    let headerLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    //MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        headerConfigure()
    }
    
    required init(coder: NSCoder) {
        fatalError("err")
    }
    
    //MARK: - Cell Identifier
    
    enum Identifier: String {
        case custom = "headerCell"
    }
}

extension HeaderCell {
    
    func headerConfigure() {
        headerSubviews()
    }
    
    func headerSubviews() {
        self.addSubview(headerLabel)
        headerLabel.frame = CGRect(x: 8, y: 8, width: bounds.width, height: bounds.height)
    }
}
