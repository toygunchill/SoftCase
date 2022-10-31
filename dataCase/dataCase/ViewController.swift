//
//  ViewController.swift
//  dataCase
//
//  Created by Toygun Çil on 28.10.2022.
//

import UIKit
import SnapKit
import IQKeyboardManagerSwift

struct ViewModel{
    var firstViewCount: Int
    var seconViewCount: Int
    var thirdViewCount: Int
}

enum CellTypes: Int, CaseIterable{
    case header
    case combobox
    case textInput
    
    var title: String {
        switch self {
        case .header:
            return "" // apiden çekilen
        case .combobox:
            return "" // apiden çekilen
        case .textInput:
            return "" // apiden çekilen
        }
    }
}

class ViewController: UIViewController {
    
    //MARK: - UIElements

    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    //MARK: - Properties
    var dataRange: Int = 0
    var testCnt: Int = 0
    var controllCnt: Int = 5
    
    var headerCount: Int = 0
    var comboCount: Int = 0
    var inputCount: Int = 0
    
    var viewModel = ViewModel(firstViewCount: 0, seconViewCount: 0, thirdViewCount: 0)
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        makeTableView()
        fetchData()
        
        controllCnt = NetworkService.sharetNetwork.responseData?.data?.count ?? 0
        
        for test in 0...(controllCnt-1) {
            if NetworkService.sharetNetwork.responseData?.data?[test].CustomViewType == "Header" {
                headerCount = headerCount + 1
            } else if NetworkService.sharetNetwork.responseData?.data?[test].CustomViewType == "Combobox" {
                comboCount = comboCount + 1
            } else if NetworkService.sharetNetwork.responseData?.data?[test].CustomViewType == "TextInput" {
                inputCount = inputCount + 1
            }
        }
        viewModel = ViewModel(firstViewCount: headerCount, seconViewCount: comboCount, thirdViewCount: inputCount)
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    
    //MARK: - Function
    
    private func fetchData() {
        NetworkService.sharetNetwork.parseJSON()
    }
    
    private func configure() {
        drawDesign()
        addElementSubview()
    }
    
    private func drawDesign() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HeaderCell.self, forCellReuseIdentifier: HeaderCell.Identifier.custom.rawValue)
        tableView.register(ComboboxCell.self, forCellReuseIdentifier: ComboboxCell.Identifier.custom.rawValue)
        tableView.register(TextInputCell.self, forCellReuseIdentifier: TextInputCell.Identifier.custom.rawValue)
        tableView.allowsSelection = false
    }
    
    private func addElementSubview() {
        view.addSubview(tableView)
    }

}


//MARK: table
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = CellTypes(rawValue: section) else{
            return 1
        }
        switch sections {
        case .header:
            return viewModel.firstViewCount
        case .combobox:
            return viewModel.seconViewCount
        case .textInput:
            return viewModel.thirdViewCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sections = CellTypes(rawValue: indexPath.section) else{
            return UITableViewCell()
        }
        switch sections {
        case .header:
            guard let headerCell: HeaderCell = tableView.dequeueReusableCell(withIdentifier: HeaderCell.Identifier.custom.rawValue) as? HeaderCell else {
                return UITableViewCell()
            }
            headerCell.headerLabel.text = NetworkService.sharetNetwork.responseData?.data?[dataRange].Properties?.Text
            dataRange = dataRange + 1
            return headerCell
        case .combobox:
            guard let comboboxCell: ComboboxCell = tableView.dequeueReusableCell(withIdentifier: ComboboxCell.Identifier.custom.rawValue) as? ComboboxCell else {
                return UITableViewCell()
            }
            comboboxCell.textField.placeholder = NetworkService.sharetNetwork.responseData?.data?[dataRange].Properties?.Header
            comboboxCell.comboData = NetworkService.sharetNetwork.responseData?.data?[dataRange].Properties?.Text
            dataRange = dataRange + 1
            return comboboxCell
        case .textInput:
            guard let textInputCell: TextInputCell = tableView.dequeueReusableCell(withIdentifier: TextInputCell.Identifier.custom.rawValue) as? TextInputCell else {
                return UITableViewCell()
            }
            
            textInputCell.textField.placeholder = NetworkService.sharetNetwork.responseData?.data?[dataRange].Properties?.Header
            dataRange = dataRange + 1
            return textInputCell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (((NetworkService.sharetNetwork.responseData?.data?.count)! - 1))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 50
        case 1:
            return 50
        case 2:
            return 50
        default:
            return 50
        }
    }
}


//MARK: -  constrait

extension ViewController {
    private func makeTableView() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
