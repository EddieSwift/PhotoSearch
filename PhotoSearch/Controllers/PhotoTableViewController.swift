//
//  PhotoTableViewController.swift
//  PhotoSearch
//
//  Created by Eduard Galchenko on 22.01.2020.
//  Copyright © 2020 Eduard Galchenko. All rights reserved.
//

import UIKit

class PhotoTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    private var searchBar: UISearchBar!
    private var searches = [String?]()
    private let networkManager = NetworkManager()
    private var allResults: [SearchResult] = []
    private let reuseIdentifier = "PhotoTableViewCell"

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        tableView.allowsSelection = false
        
        setupMainUI()
    }
    
    // MARK: - Setup UI Methods
    private func setupMainUI() {
        searchBar = UISearchBar()
        view.addSubview(searchBar)
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = "Search photo..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }

    // MARK: - Network Methods

    private func getPhoto() {
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        searchBar.addSubview(activityIndicator)
        activityIndicator.frame = searchBar.bounds
        activityIndicator.startAnimating()

        networkManager.searchFlickr(for: searchBar.text!) { searchResults in
            activityIndicator.removeFromSuperview()

            switch searchResults {
            case .error(let error) :
                print("Error Searching: \(error)")
            case .results(let results):
                print("Found \(results.searchResult.count) matching \(results.searchTerm)")
                print(results)
                self.allResults.append(results)

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}
// MARK: - UITableViewDataSource

extension PhotoTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searches.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier,
                                                       for: indexPath) as? PhotoTableViewCell else {
                                                        fatalError("Cell error")
        }

        cell.configureWith(searchResult: allResults[indexPath.row])

        return cell
    }
}

// MARK: - UITableViewDelegate

extension PhotoTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// MARK: - UISearchBarDelegate

extension PhotoTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searches.append(searchBar.text)
        
        getPhoto()

        searchBar.text = nil
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
}
