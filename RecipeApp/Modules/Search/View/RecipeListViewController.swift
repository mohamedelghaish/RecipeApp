//
//  RecipeListViewController.swift
//  RecipeApp
//
//  Created by Mohamed Kotb Saied Kotb on 23/08/2024.
//
//

import UIKit
import Kingfisher

class RecipeListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterSegmentedControl: UISegmentedControl!
    
    
    @IBAction func searchBtn(_ sender: Any) {
        performSearch()
    }
    
    private let viewModel = RecipeListViewModel()
    private var isFetchingMoreRecipes = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
    }
    
    private func performSearch() {
            guard let query = searchBar.text, !query.isEmpty else { return }
            viewModel.currentQuery = query
            viewModel.searchRecipes(query: query, pageNumber: 0, reset: true)
        }
    
    private func setupUI() {
        tableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeTableViewCell")
        tableView.rowHeight = 160
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        filterSegmentedControl.addTarget(self, action: #selector(filterChanged), for: .valueChanged)
    }
    
    private func setupBindings() {
        viewModel.reloadTableView = { [weak self] in
            self?.tableView.reloadData()
            self?.isFetchingMoreRecipes = false
        }
    }

    
    @objc func filterChanged() {
        viewModel.selectedHealthFilter = {
            switch filterSegmentedControl.selectedSegmentIndex {
            case 0: return nil          
            case 1: return "low-sugar"
            case 2: return "dairy-free"
            case 3: return "vegan"
            default: return nil
            }
        }()
        viewModel.searchRecipes(query: viewModel.currentQuery, pageNumber: 0, reset: true)
    }

    
    func loadMoreRecipes() {
        guard !isFetchingMoreRecipes else { return }
        isFetchingMoreRecipes = true
        viewModel.searchRecipes(query: viewModel.currentQuery, pageNumber: viewModel.currentPage, reset: false)
    }
}

extension RecipeListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRecipes()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        
        let recipeViewModel = viewModel.getRecipe(at: indexPath.row)
        cell.configure(with: recipeViewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipeViewModel = viewModel.getRecipe(at: indexPath.row)
        let detailVC = RecipeDetailViewController(recipeViewModel: recipeViewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        if position > contentHeight - frameHeight && !isFetchingMoreRecipes {
            loadMoreRecipes()
        }
    }
}

extension RecipeListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        performSearch()
    }
}
