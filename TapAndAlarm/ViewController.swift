//
//  ViewController.swift
//  TapAndAlarm
//
//  Created by 유지연 on 1/23/25.
//

/*
 구현해야 하는 것: 과목 바뀔 때 마다 totalTime 초기화
 시간 설정하면 title도 바뀌도록
 시작 버튼 생성 -> 혹시 과목별 시간과 안맞으면 "그대로 진행하시겠습니까?" 알람창
 일시 정지 버튼 / 리셋 버튼
 
*/




import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var dDay: UILabel!               //수능 디데이 체크
    @IBOutlet weak var subjectTitle: UILabel!       //과목 선택 title
    @IBOutlet weak var universityPick: UILabel!     //목표 대학 선택
    @IBOutlet weak var totalTimeLabel: UILabel!     //전체 남은 시간
    @IBOutlet weak var slideVar: UIStackView!
    
    private var buttons: [UIButton] = [] //과목 선택 버튼
    private var subjectButton: UIStackView!
    private var subjectTimeButton = UIStackView()
    var totalTime: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        caculateDday()
        let titles: [String] = ["국어", "수학", "영어", "탐구"]
        let subtitles: [String] = ["<1교시>", "<2교시>", "<3교시>", "<4교시>"]
        let colors: [UIColor] = [UIColor.green1, UIColor.green2, UIColor.green3, UIColor.green4]
        createButtonsInGrid(with: titles, subtitles: subtitles, colors: colors)
        
    }

    private func caculateDday() {
        let nowDate = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "ko_KR") // 한국 기준
        
        var daysLeft: Int = 0

        if let targetDate = dateFormatter.date(from: "2025-11-13") {

        daysLeft = Calendar.current.dateComponents([.day], from: nowDate, to: targetDate).day ?? 0
            print("D-\(daysLeft)")
        } else {
            print("날짜 변환에 실패했습니다.")
        }
        
        dDay.text = "\(daysLeft)"
    }
    
    private func createButtonsInGrid(with titles: [String], subtitles: [String], colors: [UIColor]) {
        // 부모 컨테이너 뷰 생성
        subjectButton = UIStackView()
        let stackView1 = UIStackView()
        let stackView2 = UIStackView()
        
        [stackView1, stackView2].forEach { stack in
            stack.axis = .horizontal
            stack.spacing = 10
            stack.distribution = .fillEqually
        }
        
        subjectButton.translatesAutoresizingMaskIntoConstraints = false
        subjectButton.axis = .vertical
        subjectButton.spacing = 10
        subjectButton.distribution = .fillProportionally
        
        
        // 버튼 추가
        for (index, title) in titles.enumerated() {
            let row = index / 2
            
            // 버튼 생성
            var config = UIButton.Configuration.filled()
            config.baseForegroundColor = .black
            config.titleAlignment = .center
            config.cornerStyle = .medium
            
            var titleContainer = AttributeContainer()
            titleContainer.foregroundColor = UIColor.black
            titleContainer.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            config.attributedTitle = AttributedString(subtitles[index], attributes: titleContainer)
            
            var subtitleContainer = AttributeContainer()
            subtitleContainer.foregroundColor = UIColor.black
            subtitleContainer.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
            config.attributedSubtitle = AttributedString(title, attributes: subtitleContainer)
            
            let button = UIButton(configuration: config)
            
            button.translatesAutoresizingMaskIntoConstraints = false
           
            button.configuration?.baseBackgroundColor = colors[index]
            button.layer.cornerRadius = 10
            button.layer.masksToBounds = true
            
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            
            if (row == 0) {
                stackView1.addArrangedSubview(button)
            }
            else {
                stackView2.addArrangedSubview(button)
            }
        }
        
        let subLabel: UILabel = {
            let label = UILabel()
            label.text = "과목을 선택한 후 세부 시간을 설정하세요!"
            label.font = UIFont.systemFont(ofSize: 12, weight: .light)
            label.textColor = UIColor.black
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        subjectButton.addArrangedSubview(stackView1)
        subjectButton.addArrangedSubview(stackView2)
        subjectButton.addArrangedSubview(subLabel)

         
        
        stackView2.heightAnchor.constraint(equalTo: stackView1.heightAnchor, multiplier: 1.0).isActive = true;
        subLabel.heightAnchor.constraint(equalTo: stackView1.heightAnchor, multiplier: 0.4).isActive = true
        
        view.addSubview(subjectButton)
        
        NSLayoutConstraint.activate([
            subjectButton.topAnchor.constraint(equalTo: slideVar.bottomAnchor, constant: 45),
            subjectButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            subjectButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            subjectButton.bottomAnchor.constraint(equalTo: slideVar.bottomAnchor, constant: 270)

        ])
        
    }
    
    private func createSubTimeButton(subtitle: String) {
        
        subjectTimeButton.axis = .horizontal
        subjectTimeButton.spacing = 10
        subjectTimeButton.distribution = .fillEqually
        subjectTimeButton.alignment = .fill
        subjectTimeButton.translatesAutoresizingMaskIntoConstraints = false

        var subjectCategories: [String] = []

        if (subtitle == "국어") {
            totalTime = 80
            subjectCategories = ["독서", "문학", "언매/화작"]
        } else if (subtitle == "수학") {
            totalTime = 100
            subjectCategories = ["공통", "기하/미적/확통"]
        } else if (subtitle == "영어") {
            totalTime = 70
            subjectCategories = ["듣기", "읽기"]
        } else if (subtitle == "탐구") {
            totalTime = 90
            subjectCategories = ["한국사", "탐구1", "탐구2"]
        }
        
        print(subjectCategories)
        
        
        for (_, subtitle) in subjectCategories.enumerated() {
            let subjectTimePickerButton = SubjectTimePicker(subjectTitle: subtitle)
            subjectTimePickerButton.translatesAutoresizingMaskIntoConstraints = false;
            subjectTimeButton.addArrangedSubview(subjectTimePickerButton)
            
            subjectTimePickerButton.timeButtonTappedClosure = { selectedTime in
                print("타이머가 설정되었습니다: \(selectedTime)분")
                self.totalTime += selectedTime
                print("전체 시간: \(self.totalTime)")
            }
        }
        
        view.addSubview(subjectTimeButton)
        
        NSLayoutConstraint.activate([
            subjectTimeButton.topAnchor.constraint(equalTo: subjectButton.bottomAnchor, constant: 20),
            subjectTimeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            subjectTimeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            subjectTimeButton.bottomAnchor.constraint(equalTo: subjectButton.bottomAnchor, constant: 130)

        ])
               
    }
    
    private func removeExistingSubTimeButtons() {
        for subview in subjectTimeButton.arrangedSubviews {
            subjectTimeButton.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }
        
    @objc private func buttonTapped(_ sender: UIButton) {
    
        guard let title = sender.configuration?.title else { return }
        guard let subtitle = sender.configuration?.subtitle else { return }
        subjectTitle.text = "\(title) \(subtitle)영역"
        print("\(title) 버튼이 눌렸습니다!")
        
        if (subjectTimeButton.arrangedSubviews.contains { $0 is SubjectTimePicker }) {
            removeExistingSubTimeButtons()
        }
        
        if (subtitle == "국어") {
            totalTime = 80
        } else if (subtitle == "수학") {
            totalTime = 100
        } else if (subtitle == "영어") {
            totalTime = 70
        } else if (subtitle == "탐구") {
            totalTime = 90
        }
        
        totalTimeLabel.text = "\(totalTime)분 00초"
        
        createSubTimeButton(subtitle: subtitle)
        
    }

}

