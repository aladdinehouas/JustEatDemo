//
//  HomeViewController.swift
//  JustEatDemo
//
//  Created by Alaeddine Houas on 30/3/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Internal properties -
    
    var presenter: HomePresenterProtocol?
    
    // MARK: - Private properties -
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - LifeCycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUIViews()
        presenter?.viewDidLoad()
    }
    
    func setUpUIViews(){
        setUpTableView()
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    func setUpTableView() {
        view.backgroundColor = .white.withAlphaComponent(0.9)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: RestaurantTableViewCell.self), bundle: nil) ,forCellReuseIdentifier:  String(describing: RestaurantTableViewCell.self))
    }
    
    // MARK: - Actions -
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty{
            presenter?.filterRestaurants(with: text)
        } else {
            presenter?.getAllItems()
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        searchTextField.text = ""
        view.endEditing(true)
        presenter?.getAllItems()
    }
    
    @IBAction func sortAction(_ sender: Any) {
        presenter?.showSortView()
    }
}

// MARK: - Extensions -

extension HomeViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

extension HomeViewController: HomeViewProtocol{
    func showLoading() {
        showHud()
    }
    
    func hideLoading() {
        hideHUD()
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func showError() {
        self.showFailureAlert()
    }
    
    func didSelect(option: SortOption?) {
        if let option = option {
            searchTextField.text = ""
            presenter?.sortRestaurants(by: option)
        }
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfItems ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantTableViewCell.self)) as! RestaurantTableViewCell
        cell.restaurant = presenter?.item(at: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
