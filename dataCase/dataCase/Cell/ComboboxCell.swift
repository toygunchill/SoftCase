//
//  ComboboxCell.swift
//  dataCase
//
//  Created by Toygun Çil on 31.10.2022.
//

import UIKit

struct PickerModel {
    var pickerCount: Int
}


class ComboboxCell: UITableViewCell {
    
    //MARK: - UIElements
    
    let textField: UITextField = {
        let textField = UITextField()
        return textField
    }()

    let combobox: UIPickerView = {
        let combobox = UIPickerView()
        return combobox
    }()
    
    //MARK: - Properties
    
    var comboData: String?
    var pickerModel = PickerModel(pickerCount: 3) //test
    var PickerData: [String] = ["ilk","ikinci","üçüncü"] //test

    
    //MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        comboboxConfigure()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        textField.inputView = combobox
    }
    
    required init(coder: NSCoder) {
        fatalError("err")
    }
    
    //MARK: - Cell Identifier
    
    enum Identifier: String {
        case custom = "comboboxCell"
    }
}

extension ComboboxCell {
    
    func comboboxConfigure() {
        comboboxSubviews()
        comboboxDrawDesign()
    }
    
    func comboboxDrawDesign() {
        combobox.delegate = self
        combobox.dataSource = self
        textField.placeholder = "combobox"
        textField.backgroundColor = .systemGray5
        
    }
    
    func comboboxSubviews() {
        contentView.addSubview(textField)
        textField.frame = CGRect(x: 8, y: 0, width: bounds.width, height: bounds.height)
    }
}

extension ComboboxCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerModel.pickerCount
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return PickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = PickerData[row]
    }
}
