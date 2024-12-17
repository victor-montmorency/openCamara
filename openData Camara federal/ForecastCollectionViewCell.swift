//
//  ForecastCollectionViewCell.swift
//  openData Camara federal
//
//  Created by victor mont-morency on 16/12/24.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
    
    let nameLabel = UILabel()
    let partyLabel = UILabel()
    let photoImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Set up the image view
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.contentMode = .scaleAspectFill
        contentView.addSubview(photoImageView)
        
        // Set up the name label
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        contentView.addSubview(nameLabel)
        
        // Set up the party label
        partyLabel.translatesAutoresizingMaskIntoConstraints = false
        partyLabel.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(partyLabel)
        
        // Add constraints to position the views
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            partyLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            partyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            partyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            partyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with dado: Dado) {
        nameLabel.text = dado.nome
        partyLabel.text = dado.siglaPartido.rawValue
        
        if let url = URL(string: dado.urlFoto) {
            loadImage(from: url)
        }
    }
    
    // Ensure image is set on the main thread
    private func loadImage(from url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {  // Update UI on the main thread
                    self.photoImageView.image = UIImage(data: data)
                }
            }
        }
    }
}
