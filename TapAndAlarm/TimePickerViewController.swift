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
    func loadSubjectName() -> String?
}

class TimePickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    weak var delegate: TimePickerDelegate?

    private let containerView = UIStackView()
    private let pickerView = UIPickerView()
    private let confirmButton = UIButton()
    private let cancelButton = UIButton()
    private let subjectTitle = UILabel()
    private let subLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 12

        pickerView.delegate = self
        pickerView.dataSource = self
        
        setupLayout()
    }
    
    private func setupLayout() {
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.axis = .vertical
        containerView.spacing = 10
        containerView.distribution = .fillProportionally
        
        if let subjectName = delegate?.loadSubjectName() {
            subjectTitle.text = "\(subjectName)의 제한시간을 선택하세요!"
        } else {
            subjectTitle.text = "제목이 없습니다."
        }
        subjectTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        subjectTitle.textAlignment = .center
        subjectTitle.textColor = UIColor.black
    
        
        subLabel.text = "각 파트의 제한시간이 끝나면 작은 진동이 3회 울려요 🔔"
        subLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        subLabel.textAlignment = .center
        subLabel.textColor = UIColor.black
        
        subjectTitle.translatesAutoresizingMaskIntoConstraints = false
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addArrangedSubview(subjectTitle)
        containerView.addArrangedSubview(subLabel)
        containerView.addArrangedSubview(pickerView)
        
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
        containerView.addArrangedSubview(buttonStack)
        
        view.addSubview(containerView)

        NSLayoutConstraint.activate([
            subjectTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subjectTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            subLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subLabel.topAnchor.constraint(equalTo: subjectTitle.bottomAnchor, constant: 0),
            
            pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickerView.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 100),
            pickerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            buttonStack.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 20),
            buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
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
        return 101 // 0~60분
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)분"
    }
}

