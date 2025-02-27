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
    private var preTime: Int
    var timeButtonTappedClosure: ((Int) -> Void)?
    
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
    
    
    var timeButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.layer.cornerRadius = 8
        return button
    }()
    
    init(subjectTitle: String) {
        self.subjectTitle = subjectTitle
        self.preTime = 0
        if (subjectTitle == "문학") {
            timeButton.setTitle("25분", for: .normal)
        }
        else if (subjectTitle == "독서") {
            timeButton.setTitle("35분", for: .normal)
        }
        else if (subjectTitle == "언매/화작") {
            timeButton.setTitle("20분", for: .normal)
        }
        else if (subjectTitle == "공통") {
            timeButton.setTitle("60분", for: .normal)
        }
        else if (subjectTitle == "기하/미적/확통") {
            timeButton.setTitle("40분", for: .normal)
        }
        else if (subjectTitle == "듣기") {
            timeButton.setTitle("25분", for: .normal)
        } 
        else if (subjectTitle == "읽기") {
            timeButton.setTitle("45분", for: .normal)
        }
        else {
            timeButton.setTitle("30분", for: .normal)
        }
        super.init(frame: .zero)
        setupView(subjectTitle: subjectTitle)
    }
    
    required init?(coder: NSCoder) {
        self.subjectTitle = ""
        self.preTime = 0
        if (subjectTitle == "문학") {
            timeButton.setTitle("25분", for: .normal)
        }
        else if (subjectTitle == "독서") {
            timeButton.setTitle("35분", for: .normal)
        }
        else if (subjectTitle == "언매/화작") {
            timeButton.setTitle("20분", for: .normal)
        }
        else if (subjectTitle == "공통") {
            timeButton.setTitle("60분", for: .normal)
        }
        else if (subjectTitle == "기하/미적/확통") {
            timeButton.setTitle("40분", for: .normal)
        }
        else if (subjectTitle == "듣기") {
            timeButton.setTitle("25분", for: .normal)
        }
        else if (subjectTitle == "읽기") {
            timeButton.setTitle("45분", for: .normal)
        }
        else {
            timeButton.setTitle("30분", for: .normal)
        }
        super.init(coder: coder)
        setupView(subjectTitle: subjectTitle)
    }

    
    func getTimeValue() -> Int? {
        if let timeText = timeButton.title(for: .normal), let timeValue = Int(timeText) {
            return timeValue
        }
        return nil
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
        
        if let timeText = timeButton.title(for: .normal),
           let extractedTime = Int(timeText.filter { $0.isNumber }) {
            preTime = extractedTime
        }
  
        let timePickerVC = TimePickerViewController()
        timePickerVC.delegate = self
        timePickerVC.modalPresentationStyle = .overCurrentContext
        timePickerVC.modalTransitionStyle = .crossDissolve

        viewController.present(timePickerVC, animated: true)
    }
    

    func timePickerDidSelect(minutes: Int) {
        timeButton.setTitle("\(minutes)분", for: .normal)
        timeButtonTappedClosure?(minutes-preTime)
        
    }
    
    func loadSubjectName() -> String? {
        return titleLabel.text ?? "홍길동"
    }

}
