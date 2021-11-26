//
//  ViewController.swift
//  didSet test
//
//  Created by Andrey Alymov on 02.11.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var textFieldText: String? = "Arbuz" {
        didSet {
            print("alo")
            DispatchQueue.main.async {
                self.users.append(.init(userName: self.textFieldText, userFirstName: nil, userAge: nil))
                self.tableView.reloadData()
                print("Hoolo")
            }
        }
    }
    
    var users: [Model] = [.init(userName: "Andrey", userFirstName: "A", userAge: 28), .init(userName: "Kris", userFirstName: "A", userAge: 28)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: CustomTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CustomTableViewCell.identifier)
    }

}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier) as! CustomTableViewCell
        let model = users[indexPath.row]
        cell.configure(with: CustomCellViewModel(firstName: model.userName, lastName: model.userFirstName, age: model.userAge))
        return cell
    }
    
    
}

extension ViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldText = textField.text
        textField.text = ""
        print("1 - \(textField.text) 2 - \(textFieldText)")
    }
    
    
    
}
