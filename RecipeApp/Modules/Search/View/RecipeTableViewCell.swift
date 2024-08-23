//
//  RecipeTableViewCell.swift
//  RecipeApp
//
//  Created by Mohamed Kotb Saied Kotb on 23/08/2024.
//
import UIKit
import Kingfisher
class RecipeTableViewCell: UITableViewCell {
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    
    override func awakeFromNib() {
            super.awakeFromNib()

        
            contentView.layer.borderWidth = 1.0
            contentView.layer.borderColor = UIColor.lightGray.cgColor
            contentView.layer.cornerRadius = 8.0
            contentView.layer.masksToBounds = true

            
            contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
        }

        override func layoutSubviews() {
            super.layoutSubviews()

            
            contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
        }
    func configure(with viewModel: RecipeViewModel) {
        titleLabel.text = viewModel.title
        sourceLabel.text = "Source: \(viewModel.source)"
        totalTimeLabel.text = "Time: \(viewModel.totalTime)"
        recipeImageView.kf.setImage(with: viewModel.imageURL)
    }
}
