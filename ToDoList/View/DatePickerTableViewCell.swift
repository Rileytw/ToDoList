//
//  DatePickerTableViewCell.swift
//  ToDoList
//
//  Created by Lei on 2023/7/4.
//

import UIKit

protocol DatePickerTableViewCellDelegate: AnyObject {
    func dateDidChanged(itemType: ItemList, date: Date)
}

class DatePickerTableViewCell: UITableViewCell {
    
    weak var delegate: DatePickerTableViewCellDelegate?
    
    var itemType: ItemList?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
        return datePicker
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, date: Date) {
        titleLabel.text = title
        datePicker.date = date
    }
    
    private func setupConstraint() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        }
        
        contentView.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.top)
            make.bottom.equalTo(titleLabel.snp.bottom)
            make.trailing.equalToSuperview().offset(-8)
        }
    }
    
    @objc func datePickerChanged() {
        guard let itemType = itemType else { return }
        let date = datePicker.date
        delegate?.dateDidChanged(itemType: itemType, date: date)
    }
}
