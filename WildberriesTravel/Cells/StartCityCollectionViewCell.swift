//
//  StartCityCollectionViewCell.swift
//  WildberriesTravel
//
//  Created by Pavel Grigorev on 14.05.2023.
//

import UIKit

protocol StartCityDelegateProtocol: AnyObject {
    func changeStartCity(_ startCity: StartLocationCode)
}

final class StartCityCollectionViewCell: UICollectionViewCell {

    weak var delegate: StartCityDelegateProtocol?

    static let reuseId = "StartCityCollectionViewCell"

    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.text = "Город вылета"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var citySegmentedControl: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["СПб", "Москва", "Сочи", "Минск"])
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(changeCity), for: .valueChanged)
        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
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

        contentView.addSubview(cityLabel)
        contentView.addSubview(citySegmentedControl)

        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),

            citySegmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            citySegmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            citySegmentedControl.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10),

        ])
    }

    @objc private func changeCity() {
        var startCity: StartLocationCode
        switch citySegmentedControl.selectedSegmentIndex {
        case 0: startCity = .led
        case 1: startCity = .mow
        case 2: startCity = .aer
        default: startCity = .msq
        }
        delegate?.changeStartCity(startCity)
    }
}
