//
//  CharacterViewCell.swift
//  BackgroundContent
//
//  Created by Proteco on 29/10/22.
//

import UIKit

class CharacterViewCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    
    func setup(with character: Results) {
        nameLabel.text = character.name
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
