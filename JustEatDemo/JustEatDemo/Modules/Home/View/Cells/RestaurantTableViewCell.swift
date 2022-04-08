//
//  RestaurantTableViewCell.swift
//  JustEatDemo
//
//  Created by Alaeddine Houas on 2/4/2022.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    
    // MARK: - Private properties -
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var logoImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var deliveryCostLabel: UILabel!
    @IBOutlet weak var minCostLabel: UILabel!
    
    // MARK: - Internal properties -
    
    var restaurant: Restaurant?{
        didSet{
            nameLabel.text = restaurant?.name
            statusLabel.text = restaurant?.status?.rawValue
            statusLabel.textColor = getStatusTextColor(for: restaurant?.status)
            ratingLabel.text = String(describing: restaurant?.sortingValues?.ratingAverage ?? 0)
            distanceLabel.text = String(describing: restaurant?.sortingValues?.distance ?? 0)
            deliveryCostLabel.text = getDeliveryCostsText(of: restaurant?.sortingValues?.deliveryCosts)
            deliveryCostLabel.textColor = getDeliveryCostsTextColor(of: restaurant?.sortingValues?.deliveryCosts)
            minCostLabel.text = "Min. \(restaurant?.sortingValues?.minCost ?? 0)"
        }
    }
    
    // MARK: - LifeCycle -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.roundCorners(.allCorners, radius: 10)
        logoImage.roundCorners(.allCorners, radius: 50)
    }
    
    private func getStatusTextColor(for status: OpenStatus?) -> UIColor {
        switch status {
        case .open:
            return .primaryGreenColor
        case .orderAhead:
            return .primaryOrangeColor
        case .closed:
            return .red
        case .none:
            return .primaryOrangeColor
        }
    }
    
    private func getDeliveryCostsText(of costs: Int?) -> String{
        if costs == 0 {
            return "free"
        } else {
            return String(describing: costs ?? 0)
        }
    }
    
    private func getDeliveryCostsTextColor(of costs: Int?) -> UIColor{
        if costs == 0 {
            return .primaryGreenColor
        } else {
            return .black
        }
    }
    
}
