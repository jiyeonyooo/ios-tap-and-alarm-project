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
    
    private var buttons: [UIButton] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titles: [String] = ["국어", "수학", "영어", "탐구"]
        let colors: [UIColor] = [.green1, .green2, .green3, .green4]
        createButtons(with: titles)
        
    }
    
    private func createButtons(with titles: [String]) {
            // 공통 스타일 설정
            var config = UIButton.Configuration.filled()
            config.baseBackgroundColor = .green1
            config.baseForegroundColor = .black
            config.titleAlignment = .center
            config.cornerStyle = .medium
            
            // 버튼 반복 생성
            for (index, title) in titles.enumerated() {
                let button = UIButton(configuration: config)
                button.configuration?.title = title // 버튼마다 다른 제목 설정
                
                // 버튼 위치 지정 (세로로 배치)
                button.frame = CGRect(x: 50, y: 100 + index * 80, width: 220, height: 60)
                
                // 버튼 스타일 커스터마이즈
                button.layer.cornerRadius = 15
                button.layer.masksToBounds = true
                
                // 버튼에 액션 추가
                button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                
                // 버튼을 화면에 추가
                view.addSubview(button)
                
                // 배열에 버튼 저장 (필요할 때 접근 가능)
                buttons.append(button)
            }
        }
        
        @objc private func buttonTapped(_ sender: UIButton) {
            // 버튼이 눌렸을 때 동작
            guard let title = sender.configuration?.title else { return }
            subjectTitle.text = "\(title)"
            print("\(title) 버튼이 눌렸습니다!")
        }



}

