//
//  OrderView.swift
//  WildberriesTravel
//
//  Created by Pavel Grigorev on 15.05.2023.
//

import UIKit

protocol PriceDelegateProtocol: AnyObject {
    func changePrice(count: Int, baggage: Bool)
}

final class OrderView: UIView {

    weak var delegate: PriceDelegateProtocol?

    @IBOutlet private var xib: OrderView!
    @IBOutlet weak private var countStack: UIStackView!

    @IBOutlet weak private var adtLabel: UILabel!
    @IBOutlet weak private var chdLabel: UILabel!
    @IBOutlet weak private var infLabel: UILabel!

    @IBOutlet weak private var rateLabel: UILabel!

    var serviceClass = "" {
        didSet {
            rateLabel.text = serviceClass.lowercased().capitalized
        }
    }
    var maxCount = (0, 0, 0)
    private var seats = (1, 0, 0) {
        didSet {
            adtLabel.text = String(seats.0)
            chdLabel.text = String(seats.1)
            infLabel.text = String(seats.2)
            delegate?.changePrice(count: seats.0 + seats.1 + seats.2, baggage: baggageSwitch.isOn)
        }
    }
    @IBOutlet weak private var baggageSwitch: UISwitch!

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupNib()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupNib()
    }

    // MARK: - Private methods

    @IBAction private func adtPlusButton(_ sender: UIButton) {
        if seats.0 < maxCount.0 {
            seats.0 += 1
        }
    }
    @IBAction private func adtMinusButton(_ sender: UIButton) {
        if seats.0 > 0 {
            seats.0 -= 1
        }
    }
    @IBAction private func chdPlusButton(_ sender: UIButton) {
        if seats.1 < maxCount.1 {
            seats.1 += 1
        }
    }
    @IBAction private func chdMinusButton(_ sender: UIButton) {
        if seats.1 > 0 {
            seats.1 -= 1
        }
    }
    @IBAction private func infPlusButton(_ sender: UIButton) {
        if seats.2 < maxCount.2 {
            seats.2 += 1
        }
    }
    @IBAction private func infMinusButton(_ sender: UIButton) {
        if seats.2 > 0 {
            seats.2 -= 1
        }
    }

    @IBAction private func switchTap(_ sender: UISwitch) {
        delegate?.changePrice(count: seats.0 + seats.1 + seats.2, baggage: baggageSwitch.isOn)
    }

    private func setupNib() {
        let viewFromNib = Bundle.main.loadNibNamed("OrderView", owner: self)?.first as! UIView
        viewFromNib.frame = self.bounds
        addSubview(viewFromNib)
        translatesAutoresizingMaskIntoConstraints = false
        xib.layer.cornerRadius = 10
        xib.layer.shadowColor = UIColor.black.cgColor
        xib.layer.shadowOffset = CGSize(width: 0, height: 4)
        xib.layer.shadowOpacity = 0.5
        xib.layer.shadowRadius = 4
        countStack.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -2).isActive = true
    }

}
