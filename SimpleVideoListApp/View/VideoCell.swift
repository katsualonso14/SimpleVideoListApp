
import UIKit

class VideoCell: UITableViewCell {
    let titleLabel = UILabel()
    let nameLabel = UILabel()
    let idLabel = UILabel()
    let image = UIImageView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupContentView()
        setupTitleLabel()
        setupNameLabel()
        setupIdLabel()
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func setupNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func setupIdLabel() {
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(idLabel)
        
        NSLayoutConstraint.activate([
            idLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            idLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            idLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            idLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    //TODO: 全体的なUI修正(本家かオリジナルのUIに寄せる、する)
    func setupImageView() {
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        contentView.addSubview(image)

        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 10),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -10),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
            image.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
}
