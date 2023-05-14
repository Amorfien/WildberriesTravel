//
//  OrderView.swift
//  WildberriesTravel
//
//  Created by Pavel Grigorev on 15.05.2023.
//

import UIKit

final class OrderView: UIView {

    init() {
        super.init(frame: .zero)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .systemGray4
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 4
        translatesAutoresizingMaskIntoConstraints = false

//        addSubview(loadButton)
//        addSubview(collectionView)
//        addSubview(activityIndicator)

        NSLayoutConstraint.activate([

        ])
    }

}
