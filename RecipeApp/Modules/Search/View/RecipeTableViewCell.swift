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
    
    func configure(with viewModel: RecipeViewModel) {
        titleLabel.text = viewModel.title
        sourceLabel.text = viewModel.source
        totalTimeLabel.text = viewModel.totalTime
        recipeImageView.kf.setImage(with: viewModel.imageURL)
    }
}
