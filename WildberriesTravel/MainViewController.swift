//
//  MainViewController.swift
//  WildberriesTravel
//
//  Created by Pavel Grigorev on 13.05.2023.
//

import UIKit

class MainViewController: UIViewController {

    private let viewModel: MainViewModelProtocol

    private var flights: [Flight] = []

    private lazy var flightsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.backgroundColor = .systemGray6
        collectionView.register(StartCityCollectionViewCell.self, forCellWithReuseIdentifier: StartCityCollectionViewCell.reuseId)
        collectionView.register(FlightsCollectionViewCell.self, forCellWithReuseIdentifier: FlightsCollectionViewCell.reuseId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    init(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()

        setupNavigationController()
        setupView()
//        fetchFlights()
    }

    private func setupNavigationController() {

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.backgroundColor = UIColor(named: "wildPink")

    }

    private func setupView() {
        view.backgroundColor = UIColor(named: "wildPink")
        self.title = "Пора в путешествие"
        view.addSubview(flightsCollectionView)
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            flightsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            flightsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            flightsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            flightsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func bindViewModel() {
        viewModel.onStateDidChange = { [weak self] state in
            guard let self = self else {
                return
            }
            switch state {
            case .initial:
                self.activityIndicator.stopAnimating()
            case .loading:
                self.activityIndicator.startAnimating()
            case let .loaded(flights):
                DispatchQueue.main.async {
                    self.flights = flights
                    self.activityIndicator.stopAnimating()
                    self.flightsCollectionView.reloadData()
                }
            case .error:
                // Here we can show alert with error text
                ()
            }
        }
    }


}
extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 1 : flights.count
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StartCityCollectionViewCell.reuseId, for: indexPath) as? StartCityCollectionViewCell else { return StartCityCollectionViewCell() }
            cell.delegate = self
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlightsCollectionViewCell.reuseId, for: indexPath) as? FlightsCollectionViewCell else { return FlightsCollectionViewCell() }
//            cell.clipsToBounds = false
                        cell.layer.borderWidth = 1
                        cell.layer.borderColor = UIColor.systemGray5.cgColor
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOffset = CGSize(width: 0, height: 4)
            cell.layer.shadowOpacity = 0.25
            cell.layer.shadowRadius = 4

            let flight = flights[indexPath.row]
            let fullDate = flight.startDate
            let date = fullDate.components(separatedBy: " ").first
            var sumSeats = 0
            for seat in flight.seats {
                sumSeats += seat.count
            }
            cell.fillData(date: date ?? "", price: flight.price,
                          start: (flight.startLocationCode.rawValue, flight.startCity),
                          destination: (flight.endLocationCode, flight.endCity), seats: sumSeats)
            return cell
        }

    }


}
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 44
        let height: CGFloat = indexPath.section == 0 ? 62 : 122
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: .zero, height: 20)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
extension MainViewController: StartCityDelegateProtocol {
    func changeStartCity(_ startCity: StartLocationCode) {
        viewModel.updateState(viewInput: .changeStartCity, startCity: startCity)
    }
}

