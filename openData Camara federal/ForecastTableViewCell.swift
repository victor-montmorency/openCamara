import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    let nameLabel = UILabel()
    let partyLabel = UILabel()
    let photoImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Set up the image view
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.contentMode = .scaleAspectFit
        photoImageView.clipsToBounds = true
        contentView.addSubview(photoImageView)
        
        // Set up the name label
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        contentView.addSubview(nameLabel)
        
        // Set up the party label
        partyLabel.translatesAutoresizingMaskIntoConstraints = false
        partyLabel.font = UIFont.systemFont(ofSize: 14)
        partyLabel.textColor = .darkGray
        contentView.addSubview(partyLabel)
        
        // Add constraints to position the views
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            photoImageView.widthAnchor.constraint(equalToConstant: 60),
            photoImageView.heightAnchor.constraint(equalToConstant: 90),
            
            nameLabel.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 15),
            
            partyLabel.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor),
            partyLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 5),
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
