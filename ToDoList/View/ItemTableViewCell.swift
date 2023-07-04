//
//  ItemTableViewCell.swift
//  ToDoList
//
//  Created by Lei on 2023/7/4.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, content: String) {
        titleLabel.text = title
        contentLabel.text = content
    }
    
    private func setupConstraint() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview()
        }
        
        contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
}
