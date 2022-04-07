//
//  SortOptionTableViewCell.swift
//  JustEatDemo
//
//  Created by Alaeddine Houas on 3/4/2022.
//

import UIKit

class SortOptionTableViewCell: UITableViewCell {
    
    // MARK: - Private properties -
    
    @IBOutlet weak var sortOptionLabel: UILabel!
    @IBOutlet weak var radioButtonImage: UIImageView!
        
    // MARK: - Internal properties -

    var sortOption: SortOption?{
        didSet{
            sortOptionLabel.text = sortOption?.rawValue
        }
    }
    
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                radioButtonImage.image = ImageLinker.selectedButtonImage
            } else {
                radioButtonImage.image = ImageLinker.unselectedButtonImage
            }
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
    
}
