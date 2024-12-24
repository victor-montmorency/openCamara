//
//  homeVC.swift
//  openData Camara federal
//
//  Created by victor mont-morency on 16/12/24.
//

import UIKit

class homeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    
    var tableView: UITableView!
    var forecastResponse: ForecastResponse?
    var filteredDados: [Dado] = [] // To hold filtered data
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the table view
        setupTableView()
        
        // Set up the search controller
        setupSearchController()
        
        // Fetch data from the network
        fetchData()
        
        tableView.backgroundColor = UIColor.systemGray
    }
    
    // Set up table view
    func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ForecastTableViewCell.self, forCellReuseIdentifier: "ForecastCell")
        tableView.rowHeight = 100
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        // Set up constraints for table view
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // Set up the search controller
    func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Procurar Deputado(a)"
        
        // Add the search bar to the navigation bar
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    // Fetch forecast data
    func fetchData() {
        NetworkManager.shared.fetchForecastData { result in
            DispatchQueue.main.async { // Make sure the UI updates are on the main thread
                switch result {
                case .success(let forecastResponse):
                    self.forecastResponse = forecastResponse
                    self.filteredDados = forecastResponse.dados // Initialize filtered data
                    self.tableView.reloadData() // Update the UI (reload table view)
                    
                case .failure(let error):
                    print("Failed to fetch forecast data: \(error)")
                    self.showAlert(message: "Failed to load data.")
                }
            }
        }
    }
    
    // MARK: - UITableView DataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredDados.count // Use filtered data
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath) as! ForecastTableViewCell
        
        let dado = filteredDados[indexPath.row]
        cell.configure(with: dado)
        
        return cell
    }
    
    // MARK: - UITableView Delegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Handle row selection here if needed
    }
    
    // MARK: - UISearchResultsUpdating Method
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            filteredDados = forecastResponse?.dados ?? [] // Reset to all data when search text is empty
            tableView.reloadData()
            return
        }
        
        // Filter the data based on the search text
        filteredDados = forecastResponse?.dados.filter { dado in
            // Assuming Dado has a property 'title' or similar that can be searched
            return dado.nome.localizedCaseInsensitiveContains(searchText)
        } ?? []
        
        tableView.reloadData()
    }
    
    // MARK: - Error Handling
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
