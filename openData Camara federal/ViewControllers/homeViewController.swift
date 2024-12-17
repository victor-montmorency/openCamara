//
//  homeVC.swift
//  openData Camara federal
//
//  Created by victor mont-morency on 16/12/24.
//

import UIKit

class homeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var collectionView: UICollectionView!
    var forecastResponse: ForecastResponse?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the collection view
        setupCollectionView()
        
        // Fetch data from the network
        fetchData()
        
        collectionView.backgroundColor = UIColor.systemGray
    }
    
    // Set up collection view
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width / 2.1, height: view.frame.height / 2.9)
        layout.minimumLineSpacing = 20
        
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ForecastCollectionViewCell.self, forCellWithReuseIdentifier: "ForecastCell")
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        // Set up constraints for collection view
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // Fetch forecast data
    func fetchData() {
        NetworkManager.shared.fetchForecastData { result in
            DispatchQueue.main.async { // Make sure the UI updates are on the main thread
                switch result {
                case .success(let forecastResponse):
                    self.forecastResponse = forecastResponse
                    self.collectionView.reloadData() // Update the UI (reload collection view)
                    
                case .failure(let error):
                    print("Failed to fetch forecast data: \(error)")
                    self.showAlert(message: "Failed to load data.")
                }
            }
        }
    }
    
    // MARK: - UICollectionView DataSource Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecastResponse?.dados.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastCell", for: indexPath) as! ForecastCollectionViewCell
        
        if let dado = forecastResponse?.dados[indexPath.row] {
            cell.configure(with: dado)
        }
        
        return cell
    }
    
    // MARK: - Error Handling
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
