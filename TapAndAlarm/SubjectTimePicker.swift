//
//  SubjectTimePicker.swift
//  TapAndAlarm
//
//  Created by 유지연 on 1/29/25.
//

import Foundation
import UIKit

class SubjectTimePicker: UIView, TimePickerDelegate  {
    
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
        
        // AutoLayout 설정
        titleContainerView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        timeButton.translatesAutoresizingMaskIntoConstraints = false
        
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
            
        ])
    }
    
    @objc private func timeButtonTapped() {
        guard let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
                  let viewController = windowScene.windows.first(where: { $0.isKeyWindow })?.rootViewController else {
                return
            }
  
            
            let timePickerVC = TimePickerViewController()
            timePickerVC.delegate = self
            timePickerVC.modalPresentationStyle = .overCurrentContext
            timePickerVC.modalTransitionStyle = .crossDissolve

            viewController.present(timePickerVC, animated: true)
        }

        // TimePickerDelegate 메서드
        func timePickerDidSelect(minutes: Int) {
            timeButton.setTitle("\(minutes)분", for: .normal)
        }
}
