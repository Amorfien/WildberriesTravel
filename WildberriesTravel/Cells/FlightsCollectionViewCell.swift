//
//  FlightsCollectionViewCell.swift
//  WildberriesTravel
//
//  Created by Pavel Grigorev on 14.05.2023.
//

import UIKit

final class FlightsCollectionViewCell: UICollectionViewCell {
//    weak var delegateProgressUpd: HVCProgressUpd?

    static let reuseId = "FlightsCollectionViewCell"

    private let stackView = UIStackView()

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

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "23:45 LED  -  01:20 MOW"
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "1560₽"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let seatsLabel: UILabel = {
        let label = UILabel()
        label.text = "мест 2"
        label.textAlignment = .center
        label.backgroundColor = UIColor(named: "wildRed")//wildGreen
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()



    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "noHeart"), for: .normal)
//        button.tintColor = .secondaryLabel
//        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(pressLike), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - Private methods

    private func setupView() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 10

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(likeButton)
//        let stackView = UIStackView(arrangedSubviews: [dateLabel, priceLabel, likeButton])
//        let flightViews = [dateLabel, cityLabel, timeLabel, priceLabel, seatsLabel, likeButton]
        let flightViews = [stackView, cityLabel, timeLabel, seatsLabel]
        flightViews.forEach { contentView.addSubview($0) }

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 24),

            likeButton.widthAnchor.constraint(equalToConstant: 24),

            cityLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 12),
            cityLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),

            timeLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),

            seatsLabel.bottomAnchor.constraint(equalTo: timeLabel.bottomAnchor),
            seatsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            seatsLabel.widthAnchor.constraint(equalToConstant: 70),
            seatsLabel.heightAnchor.constraint(equalToConstant: 24)

        ])
    }

    func fillData(date: String, price: Int, start: (String, String),
                  destination: (String, String), seats: Int) {
        dateLabel.text = date
        priceLabel.text = "\(price)₽"
        cityLabel.text = "\(start.1)  -  \(destination.1)"
        timeLabel.text = "23:45 \(start.0)  -  01:20 \(destination.0)"
        seatsLabel.text = "мест \(seats)"
    }

    @objc private func pressLike() {
        likeButton.setImage(UIImage(named: "yesHeart"), for: .normal)
    }
}
