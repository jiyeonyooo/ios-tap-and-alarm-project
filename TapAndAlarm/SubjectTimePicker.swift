//
//  SubjectTimePicker.swift
//  TapAndAlarm
//
//  Created by 유지연 on 1/29/25.
//

import Foundation
import UIKit

class SubjectTimePicker: UIView  {
    
    private let stackView = UIStackView()
    private var subjectTitle: String
    
    private let titleContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.brown1
        view.layer.cornerRadius = 8
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "" //과목별 선택사항
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor.white
        return label
    }()
    
   
    private let timeButton: UIButton = {
        let button = UIButton()
        button.setTitle("35분", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let pickerContainerView: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor.white
        container.layer.cornerRadius = 10
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOpacity = 0.3
        container.layer.shadowRadius = 5
        container.isHidden = true
        return container
    }()
    
    private let pickerView: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .countDownTimer
        picker.minuteInterval = 1
        picker.preferredDatePickerStyle = .wheels
        picker.isHidden = true
        return picker
    }()
    

    init(subjectTitle: String) {
        self.subjectTitle = subjectTitle
        super.init(frame: .zero)
        setupView(subjectTitle: subjectTitle)
    }
        
    required init?(coder: NSCoder) {
        self.subjectTitle = ""
        super.init(coder: coder)
        setupView(subjectTitle: subjectTitle)
    }
    
    private func setupView(subjectTitle: String) {
        
        titleLabel.text = subjectTitle
        
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.brown1.cgColor
        self.layer.borderWidth = 1
        self.backgroundColor = .white
        
        // titleContainerView 추가
        addSubview(titleContainerView)
        titleContainerView.addSubview(titleLabel)
        addSubview(timeButton)
        //addSubview(pickerContainerView)
        //pickerContainerView.addSubview(pickerView)

        
        timeButton.addTarget(self, action: #selector(timeButtonTapped), for: .touchUpInside)
        //pickerView.addTarget(self, action: #selector(timeSelected), for: .valueChanged)
        
        // AutoLayout 설정
        titleContainerView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        timeButton.translatesAutoresizingMaskIntoConstraints = false
        pickerContainerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // titleContainerView 위치 및 크기
            titleContainerView.topAnchor.constraint(equalTo: self.topAnchor),
            titleContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleContainerView.heightAnchor.constraint(equalToConstant: 35),
            
            // titleLabel 중앙 정렬
            titleLabel.centerXAnchor.constraint(equalTo: titleContainerView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: titleContainerView.centerYAnchor),
            
            // timeLabel 위치 및 크기
            timeButton.topAnchor.constraint(equalTo: titleContainerView.bottomAnchor, constant: 0),
            timeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            timeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            timeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            timeButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
//            pickerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            pickerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)
            
//            pickerContainerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            pickerContainerView.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 5),
//            pickerContainerView.widthAnchor.constraint(equalToConstant: 200),
//            pickerContainerView.heightAnchor.constraint(equalToConstant: 120),
//            
//            // PickerView
//            pickerView.centerXAnchor.constraint(equalTo: pickerContainerView.centerXAnchor),
//            pickerView.centerYAnchor.constraint(equalTo: pickerContainerView.centerYAnchor)
        ])
    }
    
//    @objc private func timeButtonTapped() {
//        
//        let alertController = UIAlertController(title: "시간 선택", message: nil, preferredStyle: .actionSheet)
//        
//        let times = ["10분", "20분", "30분", "35분", "40분"]
//        for time in times {
//            let action = UIAlertAction(title: time, style: .default) { _ in
//                self.timeButton.setTitle(time, for: .normal)
//            }
//            alertController.addAction(action)
//        }
//        
//        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
//        alertController.addAction(cancelAction)
//        
//        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//           let window = windowScene.windows.first,
//           let viewController = window.rootViewController {
//            viewController.present(alertController, animated: true, completion: nil)
//        }
//    }
    
    @objc private func timeButtonTapped() {
        let alertController = UIAlertController(title: "시간 선택", message: "\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet)
            
        let pickerView = UIDatePicker()
        pickerView.datePickerMode = .countDownTimer
        pickerView.minuteInterval = 1
        pickerView.preferredDatePickerStyle = .wheels
        pickerView.frame = CGRect(x: 10, y: 40, width:alertController.view.bounds.width - 40, height: 150)

        alertController.view.addSubview(pickerView)
            
        let confirmAction = UIAlertAction(title: "선택", style: .default) { _ in
        let minutes = Int(pickerView.countDownDuration / 60)
            self.timeButton.setTitle("\(minutes)분", for: .normal)
        }
            
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)

        if let viewController = UIApplication.shared.keyWindow?.rootViewController {
            viewController.present(alertController, animated: true, completion: nil)
        }
    }
        
    @objc private func timeSelected() {
        print("시간 선택")
        let minutes = Int(pickerView.countDownDuration / 60)
        timeButton.setTitle("\(minutes)분", for: .normal)
        pickerContainerView.isHidden = true
        
    }
}
