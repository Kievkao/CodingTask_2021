//
//  AirlinesListViewController.swift
//  CodingChallenge
//
//  Created by Andrii Kravchenko on 27.01.21.
//

import UIKit

protocol AirlinesListView: class {
    func startProgress()
    func stopProgress()
    func showAirlines(_ airlines: [Airline])
    func showError(_ text: String)
}

final class AirlinesListViewController: UIViewController {
    enum DataMode {
        case all
        case favorites
    }

    var presenter: AirlinesListPresentable!
    weak var router: AirlinesRouter?

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!

    private var allAirlines = [Airline]()
    private var favoriteAirlines = [Airline]()
    private var currentMode: DataMode = .all

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.getAirlines()
    }

    @IBAction func favoritesSwitchToggled(_ sender: UISwitch) {
        currentMode = sender.isOn ? .favorites : .all
        tableView.reloadData()
    }
}

extension AirlinesListViewController: AirlinesListView {

    func showAirlines(_ airlines: [Airline]) {
        allAirlines = airlines
        tableView.reloadData()
    }

    func showError(_ text: String) {
        presentAlert(title: "Error", message: text)
    }

    func startProgress() {
        loadingIndicator.isHidden = false
    }

    func stopProgress() {
        loadingIndicator.isHidden = true
    }
}

extension AirlinesListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch currentMode {
        case .all:
            return allAirlines.count
        case .favorites:
            return favoriteAirlines.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AirlineCell", for: indexPath) as! AirlineCell

        let airline = airlineForCurrentMode(at: indexPath)
        let isFavorite = favoriteAirlines.contains(where: { $0.code == airline.code })

        let logoToken = presenter.getLogo(for: airline) { logo in
            DispatchQueue.main.async {
                cell.setLogo(logo)
            }
        }

        let viewModel = AirlineCell.ViewModel(name: airline.name, isFavorite: isFavorite, favoriteToggleHandler: { [weak self] in
            self?.toggleFavorite(for: airline, isFavoriteNow: isFavorite)
        }, onReuseHandler: { [weak self] in
            if let token = logoToken {
                self?.presenter.cancelLogoLoading(for: token)
            }
        })

        cell.configure(with: viewModel)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let airline = airlineForCurrentMode(at: indexPath)
        router?.route(to: .details(airline: airline))
    }
}

private extension AirlinesListViewController {
    func setupUI() {
        tableView.tableFooterView = UIView()
    }

    func toggleFavorite(for airline: Airline, isFavoriteNow: Bool) {

        guard let displayedIndex = itemIndexForMode(currentMode, airline: airline) else { return }

        if isFavoriteNow, let indexInFavorites = itemIndexForMode(.favorites, airline: airline) {
            favoriteAirlines.remove(at: indexInFavorites)
        } else {
            favoriteAirlines.append(airline)
        }

        switch currentMode {
        case .all:
            tableView.reloadRows(at: [IndexPath(row: displayedIndex, section: 0)], with: .automatic)
        case .favorites:
            tableView.deleteRows(at: [IndexPath(row: displayedIndex, section: 0)], with: .automatic)
        }
    }

    func airlineForCurrentMode(at indexPath: IndexPath) -> Airline {
        switch currentMode {
        case .all:
            return allAirlines[indexPath.row]
        case .favorites:
            return favoriteAirlines[indexPath.row]
        }
    }

    func itemIndexForMode(_ mode: DataMode, airline: Airline) -> Int? {
        switch mode {
        case .all:
            return allAirlines.firstIndex(where: { $0.code == airline.code })
        case .favorites:
            return favoriteAirlines.firstIndex(where: { $0.code == airline.code })
        }
    }
}
