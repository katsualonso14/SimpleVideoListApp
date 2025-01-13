
import UIKit

class VideoCell: UITableViewCell {
    let titleLabel = UILabel()
    let nameLabel = UILabel()
    let idLabel = UILabel()
    let image = UIImageView()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true // ストップ時に非表示
        return indicator
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContentView()
        setupTitleLabel()
        setupNameLabel()
        setupIdLabel()
        setupImageView()
        startLoading()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 120),
            titleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func setupNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = .systemGray
        nameLabel.font = .systemFont(ofSize: 14)
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 120),
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func setupIdLabel() {
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        idLabel.textColor = .systemGray
        idLabel.font = .systemFont(ofSize: 10)
        contentView.addSubview(idLabel)
        
        NSLayoutConstraint.activate([
            idLabel.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
            idLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 120),
            idLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func setupImageView() {
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        contentView.addSubview(image)

        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -10),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            image.heightAnchor.constraint(equalToConstant: 100),
            image.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func startLoading() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        contentView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: image.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: image.centerYAnchor)
        ])
    }
    
}
