//
//  DatePickerTableViewCell.swift
//  ToDoList
//
//  Created by Lei on 2023/7/4.
//

import UIKit

class DatePickerTableViewCell: UITableViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
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
}
