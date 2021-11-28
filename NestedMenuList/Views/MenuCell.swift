//
//  FirstLevelCell.swift
//  NestedList
//
//  Created by Oleksandr Yevdokymov on 15.06.2021.
//

import UIKit
import Combine

final class MenuCell: UICollectionViewCell, Identifiable {
    // MARK: - Public properties
    var menuItem: OutlineItem?
    var publisher = PassthroughSubject<OutlineItem, Never>()
    
    private var isRightDiscloseButtonHidden: Bool {
        get {
            return rightDiscloseButton.isHidden
        }
        set {
            rightDiscloseButton.isHidden = newValue
        }
    }
    
    // MARK: - Private properties
    private var titleLabelLeadingConstraint: NSLayoutConstraint?
    
    private lazy var rightDiscloseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        button.setImage(UIImage(named: "downArrow"), for: .normal)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(rightDiscloseButton)
        contentView.addSubview(titleLabel)
        
        setupConstraints()
        
        rightDiscloseButton.addTarget(self, action: #selector(MenuCell.discloseButtonTapped) , for: .touchUpInside)
    }
    
    func setup(with menuItem: OutlineItem) {
        self.menuItem = menuItem
        setupDeapthLevel(with: menuItem.depthLevel)
        
        titleLabel.text = menuItem.title
        
        let image = menuItem.expanded ? UIImage(named: "upArrow") : UIImage(named: "downArrow")
        rightDiscloseButton.setImage(image, for: .normal)
        
        self.isRightDiscloseButtonHidden = menuItem.subitems.isEmpty
    }
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    @objc private func discloseButtonTapped() {
        guard let menuItem = menuItem else { return }
        publisher.send(menuItem)
    }
    
    private func setupDeapthLevel(with depthLevel: DepthLevel) {
        switch depthLevel {
        case .first:
            titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            titleLabelLeadingConstraint?.constant = 20
        case .second:
            titleLabel.font = UIFont.systemFont(ofSize: 18)
            titleLabelLeadingConstraint?.constant = 40
        case .third:
            titleLabel.font = UIFont.systemFont(ofSize: 18)
            titleLabelLeadingConstraint?.constant = 60
        }
    }
    
    private func setupConstraints() {
        titleLabelLeadingConstraint = titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        titleLabelLeadingConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            rightDiscloseButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            rightDiscloseButton.widthAnchor.constraint(equalToConstant: 26),
            rightDiscloseButton.heightAnchor.constraint(equalToConstant: 26),
            rightDiscloseButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: rightDiscloseButton.trailingAnchor, constant: -20)
        ])
    }
}
