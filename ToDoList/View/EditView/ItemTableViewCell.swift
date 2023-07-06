//
//  ItemTableViewCell.swift
//  ToDoList
//
//  Created by Lei on 2023/7/4.
//

import UIKit

protocol ItemTableViewCellDelegate: AnyObject {
    func textFieldDidEndEditing(itemType: ItemList, text: String)
}

class ItemTableViewCell: UITableViewCell {
    
    weak var delegate: ItemTableViewCellDelegate?
    
    var itemType: ItemList?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var contextTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, content: String) {
        titleLabel.text = title
        contextTextField.text = content
    }
    
    private func setupConstraint() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview()
        }
        
        contentView.addSubview(contextTextField)
        contextTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
}

extension ItemTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let itemType = itemType else { return }
        delegate?.textFieldDidEndEditing(itemType: itemType, text: textField.text ?? "")
    }
}
