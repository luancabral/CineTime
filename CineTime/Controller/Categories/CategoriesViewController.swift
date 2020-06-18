//
//  CategoriesViewController.swift
//  teste
//
//  Created by Beatriz Carlos on 11/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {
    // Table view.
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CategoriesTableViewCell.self, forCellReuseIdentifier: "MyCell")
        return tableView
    }()
    
    // Collection header names.
    let sectionsHeader : [String] = ["Ação", "Aventura", "Animação", "Comédia", "Crime", "Documentário", "Drama", "Fantasia", "Horror", "Musical", "Mistério", "Romance", "Ficção cientifica", "Suspense", "Séries", "Guerra", "Faroeste"]
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureTableView()
        configureNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.largeTitleDisplayMode = .automatic
    }
    
    func configureNavBar() {
       
        navigationController?.navigationBar.barStyle = .black
        navigationItem.title = "Buscar"
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Place the search bar in the navigation item's title view.
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        // Don't hide the navigation bar because the search bar is in it.
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar"
        searchController.searchBar.set(textColor: .white)
        searchController.searchBar.setTextField(color: .actionColor)
        searchController.searchBar.setPlaceholder(textColor: .white)
        searchController.searchBar.setSearchImage(color: .white)
        searchController.searchBar.setClearButton(color: .white)
        searchController.searchBar.delegate = self
        
        definesPresentationContext = true
        
        
        if #available(iOS 13.0, *) {
            searchController.searchBar.searchTextField.backgroundColor = .systemYellow
        }
        
//        view.addSubview(searchController.searchBar)
    }
    
    // configure table view.
    func configureTableView() {
        view.addSubview(tableView) // Add na sub view.
        setTableViewDelegates() // Setando a delegação.
        tableView.rowHeight = 200 // Altura de cada linha da table view.
        tableView.sectionHeaderHeight = 30
        tableView.backgroundColor = .black
        tableView.tableAutoLayout(to: view)  // setando as constraints da table view.
    }
    
    // set delegates table view.
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsHeader.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderTableView()
        header.label.text = sectionsHeader[section]
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as! CategoriesTableViewCell
        cell.delegate = self
        
        return cell
    }
}

// Custom delegate to push the description screen.
extension CategoriesViewController: DelegatePushDescriptionViewController {
    func didSelectItem() {
        //        let destination = DescriptionViewController()
        //        navigationController?.pushViewController(destination, animated: true)
    }
}

extension CategoriesViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let destination = SearchViewController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(destination, animated: true)
        searchBar.setShowsCancelButton(false, animated: true)
        return false
    }
}
