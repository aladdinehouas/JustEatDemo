//
//  SortViewController.swift
//  JustEatDemo
//
//  Created by Alaeddine Houas on 3/4/2022.
//

import UIKit

protocol SortViewDelegate{
    func didSelect(option: SortOption?)
}

enum SortOption: String{
    case alphabet = "Alphabet"
    case openState = "Open state"
    case ratingAverage = "Rating average"
    case distance = "Distance"
    case minCost = "Minimum cost"
    case deliveryCosts = "Delivery costs"
}

class SortViewController: UIViewController {
    
    // MARK: - Internal properties -

    var presenter: SortingPresenterProtocol?
    var delegate: SortViewDelegate?
    
    // MARK: - Private properties -

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dragView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    private var viewTranslation = CGPoint(x: 0, y: 0)
    
    
    private let sortOptions: [SortOption] = [.alphabet, .openState, .ratingAverage, .distance, .minCost, .deliveryCosts]
    private var selectedOption: SortOption? {
        didSet{
            tableView.reloadData()
        }
    }
    
    // MARK: - LifeCycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setUpUIViews()
    }
    
    func setUpUIViews(){
        dragView.roundCorners(.allCorners, radius: 2.5)
        
        containerView.roundCorners([.topLeft, .topRight], radius: 30)
        containerView.dropShadow()
        containerView.backgroundColor = .white
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismiss)))
        setUpTableView()
    }
    
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: SortOptionTableViewCell.self), bundle: nil) ,forCellReuseIdentifier:  String(describing: SortOptionTableViewCell.self))
    }

    
    
    //MARK: - Actions -
    /*
     //This method is to handle the dismiss gesture
     */
    @objc func handleDismiss(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .changed:
            viewTranslation = sender.translation(in: view)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
            })
        case .ended:
            if viewTranslation.y < 200 {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.view.transform = .identity
                })
            } else {
                dismiss(animated: true, completion: nil)
            }
        default:
            break
        }
    }
    
}

// MARK: - Extensions -

extension SortViewController: SortingViewProtocol{
    
    func select(sortOption option: SortOption) {
        selectedOption = option
    }
    
}


extension SortViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SortOptionTableViewCell.self)) as! SortOptionTableViewCell
        cell.sortOption = sortOptions[indexPath.row]
        cell.isChecked = (sortOptions[indexPath.row] == selectedOption)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedOption = sortOptions[indexPath.row]
        presenter?.didSelect(option: selectedOption)
        delegate?.didSelect(option: selectedOption)
        self.dismiss(animated: true, completion: nil)
    }
}
