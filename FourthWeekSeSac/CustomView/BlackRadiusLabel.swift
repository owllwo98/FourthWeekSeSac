//
//  BlackRadiusLabel.swift
//  FourthWeekSeSac
//
//  Created by 변정훈 on 1/15/25.
//

import UIKit


protocol SeSac {
    init()
}

class Mentor: SeSac {
    // Protocol 에 init 이 있음을 명시적으로 보여줌
    required init() {
        print("Mentor Init")
    }
}

class Jack: Mentor {
    // Mentor 의 init 도 함께 사용하고 싶어
    required init() {
        super.init()
        print("Jack Init")
    }
}

class BaseLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class PointLabel: BaseLabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
}

class PointButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




class BlackRadiusLabel: UILabel {
    
    init(color: UIColor) {
        super.init(frame: .zero)
        
        font = .boldSystemFont(ofSize: 15)
        textColor = color
        backgroundColor = .black
        layer.cornerRadius = 10
        clipsToBounds = true
        textAlignment = .center
    }
    
    // 코드베이스로 코드를 구성할 때 호출되는 초기화 구문
    // 슈퍼클래스로 구현된 init
//    override init(frame: CGRect) {
//        
//        
//        
//        
//    }
    
    
    
    // UIView ->  NSCoding protocol 채택
    // UIVIew -> UILabel -> BlackRadiusLabel
    
    // 스토리보드 구성될 때 초기화 되는 구문
    // 프로토콜에 구현된 init -> Required Initalizer
    // ? -> 실패가능한 이니셜라이저 (Failable Initalizer) / 스토리보드를 쓰지 않으면 실패할 수 있다.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
