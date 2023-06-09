//
//  TicketViewController.swift
//  WildberriesTravel
//
//  Created by Pavel Grigorev on 15.05.2023.
//

import UIKit

protocol LikeToMainProtocol: AnyObject {
    func likeToMain(id: Int)
}

final class TicketViewController: UIViewController {

    weak var delegate: LikeToMainProtocol?

    private let flight: Flight
    private let id: Int

    private let whiteView = UIView()
    private let ticketView: TicketView
    private let orderView = OrderView()

    private let totalLabel: UILabel = {
        let label = UILabel()
        label.text = "ИТОГО:"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "3910₽"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var orderButton: UIButton = {
        let button = UIButton()
        button.setTitle("Оформить заказ", for: .normal)
        button.backgroundColor = UIColor(named: "orangeButton")
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.systemGray5, for: .highlighted)
        button.setBackgroundImage(UIImage(named: "orangePixel"), for: .highlighted)
        button.clipsToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.addTarget(self, action: #selector(orderButtonDidTap), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.gray.cgColor
//        button.layer.shadowColor = UIColor.black.cgColor
//        button.layer.shadowOffset = CGSize(width: 0, height: 4)
//        button.layer.shadowOpacity = 0.5
//        button.layer.shadowRadius = 4
        return button
    }()

    // MARK: - Init

    init(flight: Flight, id: Int) {
        self.flight = flight
        self.id = id
        ticketView = TicketView(id: id)
        ticketView.fillData(date: flight.startDate.components(separatedBy: " ").first ?? "N/D", startCity: (flight.startCity, flight.startLocationCode.rawValue), endCity: (flight.endCity, flight.endLocationCode), like: flight.isLike, token: flight.searchToken)
        orderView.maxCount = (flight.seats[0].count, flight.seats[1].count, flight.seats[2].count)
        orderView.serviceClass = flight.serviceClass

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        ticketView.delegate = self
        setupNavigationController()
        setupView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Private methods

    private func setupNavigationController() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
    }

    private func setupView() {
        view.backgroundColor = UIColor(named: "wildPink")
        self.title = "\(flight.startCity)  -  \(flight.endCity)"
        self.priceLabel.text = "\(flight.price)₽"
        orderView.delegate = self
        view.addSubview(whiteView)
        whiteView.backgroundColor = .systemBackground
        whiteView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ticketView)
        view.addSubview(orderView)
        view.addSubview(orderButton)
        view.addSubview(totalLabel)
        view.addSubview(priceLabel)
        NSLayoutConstraint.activate([
            whiteView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            whiteView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            whiteView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            whiteView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            ticketView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            ticketView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ticketView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            ticketView.heightAnchor.constraint(equalToConstant: 166),

            orderView.topAnchor.constraint(equalTo: ticketView.bottomAnchor, constant: 20),
            orderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            orderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            orderView.bottomAnchor.constraint(equalTo: orderButton.topAnchor, constant: -72),

            totalLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            totalLabel.bottomAnchor.constraint(equalTo: orderButton.topAnchor, constant: -24),

            priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            priceLabel.centerYAnchor.constraint(equalTo: totalLabel.centerYAnchor),

            orderButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            orderButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            orderButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            orderButton.heightAnchor.constraint(equalToConstant: 48)

        ])
    }

    @objc private func orderButtonDidTap() {
        let alert = UIAlertController(title: "Покупка", message: "Успешно", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in self.dismiss(animated: true)}))
        self.present(alert, animated: true)
    }

}

// MARK: - Extensions

extension TicketViewController: PriceDelegateProtocol {
    func changePrice(count: Int, baggage: Bool) {
        let total = flight.price * count + (baggage ? 1300 : 0)
        priceLabel.text = "\(total)₽"
    }
}
extension TicketViewController: DetailLikeProtocol {
    func detailLikeTap(id: Int) {
//        self.like.toggle()
        delegate?.likeToMain(id: id)
    }
}
