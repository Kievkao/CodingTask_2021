//
//  AirlineDetailsViewController.swift
//  CodingChallenge
//
//  Created by Andrii Kravchenko on 27.01.21.
//

import UIKit

protocol AirlineDetailsView: class {
    func show(name: String, logo: UIImage?, website: NSAttributedString, phone: NSAttributedString)
}

final class AirlineDetailsViewController: UIViewController {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var websiteLabel: UILabel!
    @IBOutlet private weak var phoneLabel: UILabel!

    var presenter: AirlineDetailsPresentable!

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.getAirlineDetails()
    }

    @IBAction func websiteTapped(_ sender: Any) {
        guard let websiteString = websiteLabel.text, let link = URL(string: websiteString) else { return }
        UIApplication.shared.open(link.sanitiseWeb, options: [:], completionHandler: nil)
    }

    @IBAction func phoneTapped(_ sender: Any) {
        guard let phoneString = phoneLabel.text?.asPhone(), let link = URL(string: phoneString) else { return }
        UIApplication.shared.open(link, options: [:], completionHandler: nil)
    }
}

extension AirlineDetailsViewController: AirlineDetailsView {
    func show(name: String, logo: UIImage?, website: NSAttributedString, phone: NSAttributedString) {
        nameLabel.text = name
        logoImageView.image = logo
        websiteLabel.attributedText = website
        phoneLabel.attributedText = phone

        logoImageView.isHidden = logo == nil
    }
}
