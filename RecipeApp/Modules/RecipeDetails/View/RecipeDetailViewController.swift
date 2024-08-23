//
//  RecipeDetailViewController.swift
//  RecipeApp
//
//  Created by Mohamed Kotb Saied Kotb on 23/08/2024.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var totalWeightLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    
    private var viewModel: RecipeViewModel
    
    init(recipeViewModel: RecipeViewModel) {
        self.viewModel = recipeViewModel
        super.init(nibName: "RecipeDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        titleLabel.text = viewModel.title
        caloriesLabel.text = "Calories: \(viewModel.calories)"
        totalWeightLabel.text = "Total Weight: \(viewModel.totalWeight)"
        totalTimeLabel.text = "Total Time: \(viewModel.totalTime)"
        recipeImageView.kf.setImage(with: viewModel.imageURL)
    }
}

