//
//  ViewController.swift
//  TapAndAlarm
//
//  Created by 유지연 on 1/23/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dDay: UILabel!
    @IBOutlet weak var subjectTitle: UILabel!
    
    @IBOutlet weak var slideVar: UIStackView!
    private var buttons: [UIButton] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titles: [String] = ["국어", "수학", "영어", "탐구"]
        let subtitles: [String] = ["<1교시>", "<2교시>", "<3교시>", "<4교시>"]
        let colors: [UIColor] = [UIColor.green1, UIColor.green2, UIColor.green3, UIColor.green4 ]
        createButtonsInGrid(with: titles, subtitles: subtitles, colors: colors)
        
    }
    
    private func createButtonsInGrid(with titles: [String], subtitles: [String], colors: [UIColor]) {
        // 부모 컨테이너 뷰 생성
        let containerView = UIView()
        
        // 버튼 크기와 간격 설정
        let buttonWidth: CGFloat = 150
        let buttonHeight: CGFloat = 90
        let buttonSpacing: CGFloat = 10
        
        // 버튼 추가
        for (index, title) in titles.enumerated() {
            let row = index / 2
            let column = index % 2
            
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
           
            //button.configuration?.title = title
            button.configuration?.baseBackgroundColor = colors[index]
            button.layer.cornerRadius = 10
            button.layer.masksToBounds = true
            
            // 버튼 위치 설정 (컨테이너 내부에서의 위치)
            let xPosition = CGFloat(column) * (buttonWidth + buttonSpacing)
            let yPosition = CGFloat(row) * (buttonHeight + buttonSpacing)
            button.frame = CGRect(x: xPosition, y: yPosition, width: buttonWidth, height: buttonHeight)
            
            // 버튼을 부모 뷰에 추가
            containerView.addSubview(button)
        }
        
        // 컨테이너 크기 설정 (2*2 버튼 크기 + 간격 계산)
        let containerWidth = (buttonWidth * 2) + buttonSpacing
        let containerHeight = (buttonHeight * 2) + buttonSpacing
        containerView.frame = CGRect(x: 0, y: 0, width: containerWidth, height: containerHeight)
        
        // 기준 객체와 컨테이너의 Y축 오프셋 설정
        let referenceViewBottomY = slideVar.frame.origin.y + slideVar.frame.height
        containerView.center = CGPoint(x: view.frame.width / 2, y: referenceViewBottomY + containerHeight / 2 + 30)
        
        // 컨테이너를 화면에 추가
        view.addSubview(containerView)
    }

        
        @objc private func buttonTapped(_ sender: UIButton) {
            // 버튼이 눌렸을 때 동작
            guard let title = sender.configuration?.title else { return }
            subjectTitle.text = "\(title)"
            print("\(title) 버튼이 눌렸습니다!")
        }
    
    



}

