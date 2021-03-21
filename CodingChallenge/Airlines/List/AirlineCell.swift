//
//  AirlineCell.swift
//  CodingChallenge
//
//  Created by Andrii Kravchenko on 27.01.21.
//

import UIKit

final class AirlineCell: UITableViewCell {
    private enum Constants {
        static let normalImage = UIImage(systemName: "star")
        static let favoriteImage = UIImage(systemName: "star.fill")
    }

    struct ViewModel {
        let name: String
        let isFavorite: Bool
        let favoriteToggleHandler: () -> Void
        let onReuseHandler: (() -> Void)?
    }

    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!

    private var favoriteToggleHandler: (() -> Void)?
    private var onReuseHandler: (() -> Void)?

    override func prepareForReuse() {
        super.prepareForReuse()
        onReuseHandler?()
        logoImageView.image = nil
    }

    func configure(with model: ViewModel) {
        nameLabel.text = model.name
        favoriteToggleHandler = model.favoriteToggleHandler
        onReuseHandler = model.onReuseHandler

        let favoriteButtonImage = model.isFavorite ? Constants.favoriteImage : Constants.normalImage
        favoriteButton.setImage(favoriteButtonImage, for: .normal)
    }

    func setLogo(_ logo: UIImage?) {
        logoImageView.image = logo
    }

    @IBAction func favoriteButtonTapped() {
        favoriteToggleHandler?()
    }
}
