//
//  TicketView.swift
//  WildberriesTravel
//
//  Created by Pavel Grigorev on 15.05.2023.
//

import UIKit

protocol DetailLikeProtocol: AnyObject {
    func detailLikeTap(id: Int)
}

final class TicketView: UIView {

    weak var delegate: DetailLikeProtocol?

    private let id: Int
    private var like: Bool = false {
        didSet {
            likeButton.setBackgroundImage(UIImage(named: like ? "yesHeart" : "noHeart"), for: .normal)
        }
    }

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "10.06.2023"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let cityLabel: UILabel = {
        let label = UILabel()
        label.text = "Санкт-Петербург  -  Москва"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let detailLabel: UILabel = {
        let label = UILabel()
        label.text = "прямой рейс, 4ч35м в пути"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let tokenLabel: UILabel = {
        let label = UILabel()
        label.text = "023d66f7g7h8"
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let departureLabel: UILabel = {
        let label = UILabel()
        label.text = "03:30"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let arrivalLabel: UILabel = {
        let label = UILabel()
        label.text = "▶︎  08:05"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "noHeart"), for: .normal)
        button.addTarget(self, action: #selector(pressLike), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Init
    
    init(id: Int) {
        self.id = id
        super.init(frame: .zero)
        setupView()

    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setupView() {
        backgroundColor = .systemGray6
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 4
        translatesAutoresizingMaskIntoConstraints = false

        let lineView = UIView()
        lineView.backgroundColor = .black
        let flightViews = [dateLabel, likeButton, cityLabel, detailLabel, tokenLabel, departureLabel, arrivalLabel, lineView]
        flightViews.forEach { self.addSubview($0) }
        flightViews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),

            likeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            likeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            likeButton.widthAnchor.constraint(equalToConstant: 40),
            likeButton.heightAnchor.constraint(equalToConstant: 40),

            cityLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            cityLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),

            detailLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 4),
            detailLabel.leadingAnchor.constraint(equalTo: cityLabel.leadingAnchor),

            tokenLabel.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 16),
            tokenLabel.leadingAnchor.constraint(equalTo: cityLabel.leadingAnchor),

            departureLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            departureLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            arrivalLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            arrivalLabel.bottomAnchor.constraint(equalTo: departureLabel.bottomAnchor),
            lineView.centerYAnchor.constraint(equalTo: departureLabel.centerYAnchor),
            lineView.leadingAnchor.constraint(equalTo: departureLabel.trailingAnchor, constant: 10),
            lineView.trailingAnchor.constraint(equalTo: arrivalLabel.leadingAnchor, constant: 2),
            lineView.heightAnchor.constraint(equalToConstant: 1)

        ])
    }

    @objc private func pressLike() {
        self.like.toggle()
        delegate?.detailLikeTap(id: id)
    }

    // MARK: - Public method
    func fillData(date: String, startCity: (String, String), endCity: (String, String), like: Bool, token: String) {
        dateLabel.text = date
        cityLabel.text = "\(startCity.0)  -  \(endCity.0)"
        departureLabel.text = startCity.1
        arrivalLabel.text = "▶︎  \(endCity.1)"
        tokenLabel.text = token
        self.like = like
    }



}
