//
//  OrderView.swift
//  WildberriesTravel
//
//  Created by Pavel Grigorev on 15.05.2023.
//

import UIKit

final class OrderView: UIView {

    @IBOutlet var xib: OrderView!



//    init() {
//        super.init(frame: .zero)
//        setupNib()
//        setupView()
//    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupNib()
//        setupView()
    }


    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupNib()
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


    }


}
