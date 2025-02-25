//
//  TimePickerViewController.swift
//  TapAndAlarm
//
//  Created by 유지연 on 2/25/25.
//

import Foundation
import UIKit

protocol TimePickerDelegate: AnyObject {
    func timePickerDidSelect(minutes: Int)
}

class TimePickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    weak var delegate: TimePickerDelegate?

    private let pickerView = UIPickerView()
    private let confirmButton = UIButton()
    private let cancelButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 12

        pickerView.delegate = self
        pickerView.dataSource = self
        
        setupLayout()
    }
    
    private func setupLayout() {
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pickerView)
        
        confirmButton.setTitle("확인", for: .normal)
        confirmButton.setTitleColor(.systemBlue, for: .normal)
        confirmButton.addTarget(self, action: #selector(confirmSelection), for: .touchUpInside)
        
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.setTitleColor(.systemRed, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelSelection), for: .touchUpInside)

        let buttonStack = UIStackView(arrangedSubviews: [cancelButton, confirmButton])
        buttonStack.axis = .horizontal
        buttonStack.distribution = .fillEqually
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonStack)

        NSLayoutConstraint.activate([
            pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            pickerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            buttonStack.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 20),
            buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
    
    @objc private func confirmSelection() {
        let selectedMinutes = pickerView.selectedRow(inComponent: 0)
        delegate?.timePickerDidSelect(minutes: selectedMinutes)
        dismiss(animated: true)
    }
    
    @objc private func cancelSelection() {
        dismiss(animated: true)
    }

    // MARK: - UIPickerView DataSource & Delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 61 // 0~60분
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)분"
    }
}

