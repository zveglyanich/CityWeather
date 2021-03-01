//
//  ViewController.swift
//  CityWeather
//
//  Created by Pavel Zveglyanich on 12/28/20.
//

import UIKit

class MainViewController: UIViewController {
    var presenter: MainViewPresenterProtocol!
    lazy var numberOfRows = presenter.listOfCities.count
    let alert = Alert()
    let tableView = UITableView().createCustomTableview()
    let smallSizeHeightCell: CGFloat = 60
    let bigSizeHeightCell: CGFloat = 160
    
    internal var selectedIndexPath: IndexPath? {
        didSet{
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Weather of city"
        tableView.tableFooterView = UIView()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
        self.view.insertSubview(backgroundImage, at: 0)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.navigationController?.navigationBar.barTintColor = .none
        let addCityBerButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCity))
        navigationItem.rightBarButtonItem = addCityBerButton
        
        view.addSubview(tableView)
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20.0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20.0).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.cellIdTableViewCell)
    }

    @objc func addCity() {
        numberOfRows +=  1
        let number = IndexPath(row: presenter.listOfCities.count, section: 0)
        tableView.reloadData()
        let cell = tableView.cellForRow(at: number) as! MainTableViewCell
        cell.tempLabel.text = ""
        cell.cityLabel.text = ""
        cell.iconWeatherImage.image = .none
        cell.createTextFieldToSubview()
        cell.cityTextField.isHidden = false
        cell.cityTextField.becomeFirstResponder()
        cell.cityTextField.addTarget(self, action: #selector(editingEnded(_:)), for: .editingDidEnd)
    }
    @objc func editingEnded(_ textField: UITextField) {
        let cityName = presenter.listOfCities.filter{ $0.city == textField.text}
        if textField.text != "" && cityName.count == 0 {
            presenter.getWeather(city: textField.text!)
            textField.removeFromSuperview()
        } else {
            numberOfRows = numberOfRows - 1
            succes()
        }
    }
}

extension MainViewController: MainViewprotocol {
    func failure(error: Error) {
        if numberOfRows > presenter.listOfCities.count {
            numberOfRows -= 1
            tableView.reloadData()
        }
        present(alert.showAlert(error: error), animated: true, completion: nil)
        
    }
    
    func succes() {
        tableView.reloadData()
    }
    
}
