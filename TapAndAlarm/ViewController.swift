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
        containerView.distribution = .fillEqually
        
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
        
        containerView.addArrangedSubview(stackView1)
        containerView.addArrangedSubview(stackView2)
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: slideVar.bottomAnchor, constant: 50),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            containerView.bottomAnchor.constraint(equalTo: slideVar.bottomAnchor, constant: 230)

        ])
    }
    
    private func createSubTimeButton() {
        let subjectTitles: [String] = ["독서", "문학", "선택"]
        
        let timeButtonSpacing: CGFloat = 100
        
        for (index, subtitle) in subjectTitles.enumerated() {
            let subjectTimePickerButton = SubjectTimePicker(frame: CGRect(x: 55 + Int(timeButtonSpacing) * index, y: 687, width: 90, height: 90), subjectTitle: subtitle)
            view.addSubview(subjectTimePickerButton)
        }
       
        //각 과목별로 다르게
        //부모 컨테이너에 넣어서 적절한 위치에 뜨도록 설정
        
    }

        
    @objc private func buttonTapped(_ sender: UIButton) {
        // 버튼이 눌렸을 때 동작
        guard let title = sender.configuration?.title else { return }
        guard let subtitle = sender.configuration?.subtitle else { return }
        subjectTitle.text = "\(title) \(subtitle)영역"
        print("\(title) 버튼이 눌렸습니다!")
        
        createSubTimeButton()
        
    }

}

