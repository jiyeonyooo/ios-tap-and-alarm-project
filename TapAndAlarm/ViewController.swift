//
//  ViewController.swift
//  TapAndAlarm
//
//  Created by 유지연 on 1/23/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dDay: UILabel!            //수능 디데이 체크
    @IBOutlet weak var subjectTitle: UILabel!    //과목 선택 title
    
    @IBOutlet weak var slideVar: UIStackView!
    private var buttons: [UIButton] = [] //과목 선택 버튼

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titles: [String] = ["국어", "수학", "영어", "탐구"]
        let subtitles: [String] = ["<1교시>", "<2교시>", "<3교시>", "<4교시>"]
        let colors: [UIColor] = [UIColor.green1, UIColor.green2, UIColor.green3, UIColor.green4]
        createButtonsInGrid(with: titles, subtitles: subtitles, colors: colors)
        
    }
    
    private func createButtonsInGrid(with titles: [String], subtitles: [String], colors: [UIColor]) {
        // 부모 컨테이너 뷰 생성
        let containerView = UIStackView()
        let stackView1 = UIStackView()
        let stackView2 = UIStackView()
        
        [stackView1, stackView2].forEach { stack in
            stack.axis = .horizontal
            stack.spacing = 10
            stack.distribution = .fillEqually
        }
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.axis = .vertical
        containerView.spacing = 10
        containerView.distribution = .fillProportionally
        
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
        
        containerView.addArrangedSubview(stackView1)
        containerView.addArrangedSubview(stackView2)
        containerView.addArrangedSubview(subLabel)

         
        
        stackView2.heightAnchor.constraint(equalTo: stackView1.heightAnchor, multiplier: 1.0).isActive = true;
        subLabel.heightAnchor.constraint(equalTo: stackView1.heightAnchor, multiplier: 0.4).isActive = true
        
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: slideVar.bottomAnchor, constant: 45),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            containerView.bottomAnchor.constraint(equalTo: slideVar.bottomAnchor, constant: 270)

        ])
        
        
    }
    
    private func createSubTimeButton(subtitle: String) {
        
        let containerView = UIStackView()
        let stackView1 = UIStackView()
        var subjectCategories: [String] = []

        if (subtitle == "국어") {
            subjectCategories = ["독서", "문학", "선택"]
        } else if (subtitle == "수학") {
            subjectCategories = ["공통", "선택"]
        } else if (subtitle == "영어") {
            subjectCategories = ["듣기", "나머지"]
        } else if (subtitle == "탐구") {
            subjectCategories = ["한국사", "탐구1", "탐구2"]
        }
        
        print(subjectCategories)
        
        let timeButtonSpacing: CGFloat = 100
        
        for (index, subtitle) in subjectCategories.enumerated() {
            let subjectTimePickerButton = SubjectTimePicker(subjectTitle: subtitle)
            subjectTimePickerButton.translatesAutoresizingMaskIntoConstraints = false;
            containerView.addArrangedSubview(subjectTimePickerButton)
        }
               
    }

        
    @objc private func buttonTapped(_ sender: UIButton) {
        // 버튼이 눌렸을 때 동작
        guard let title = sender.configuration?.title else { return }
        guard let subtitle = sender.configuration?.subtitle else { return }
        subjectTitle.text = "\(title) \(subtitle)영역"
        print("\(title) 버튼이 눌렸습니다!")
        
        createSubTimeButton(subtitle: subtitle)
        
    }

}

