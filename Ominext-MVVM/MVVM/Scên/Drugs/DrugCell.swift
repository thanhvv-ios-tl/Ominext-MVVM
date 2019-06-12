//
//  DrugCell.swift
//
//  Copyright © 2019 Ominext. All rights reserved.
//

import UIKit

class DrugCell: UITableViewCell {
    @IBOutlet weak var drugIdLabel: UILabel!
    @IBOutlet weak var drugNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func bind(viewModel: DrugViewModel) {
        self.drugIdLabel.text = viewModel.id
        self.drugNameLabel.text = viewModel.name
    }
}
