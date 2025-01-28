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
        let colors: [UIColor] = [UIColor.green1, UIColor.green2, UIColor.green3, UIColor.green4 ]
        createButtons(with: titles, colors: colors)
        
    }
    
    private func createButtons(with titles: [String], colors: [UIColor]) {
            
            var config = UIButton.Configuration.filled()
            config.baseForegroundColor = .black
            config.titleAlignment = .center
            config.cornerStyle = .medium
            
            // 버튼 반복 생성
            for (index, title) in titles.enumerated() {
                let button = UIButton(configuration: config)
                button.configuration?.title = title //제목 설정
                button.configuration?.baseBackgroundColor = colors[index]
                
                let row = index / 2
                let column = index % 2
                
                let referenceViewBottomY = slideVar.frame.origin.y + slideVar.frame.height
                let yPosition = referenceViewBottomY + 40 + (CGFloat(row) * 100)
                let xPosition = 50 + (column * 160)
                
                // 버튼의 위치와 크기 설정
                button.frame = CGRect(x: xPosition, y: Int(yPosition), width: 150, height: 90)
                
                
                // 버튼 스타일 커스터마이즈
                button.layer.cornerRadius = 5
                button.layer.masksToBounds = true
                
                // 버튼에 액션 추가
                button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                
                // 버튼을 화면에 추가
                view.addSubview(button)
                
            }
        }
        
        @objc private func buttonTapped(_ sender: UIButton) {
            // 버튼이 눌렸을 때 동작
            guard let title = sender.configuration?.title else { return }
            subjectTitle.text = "\(title)"
            print("\(title) 버튼이 눌렸습니다!")
        }



}

