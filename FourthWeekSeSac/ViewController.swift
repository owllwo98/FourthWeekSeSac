//
//  ViewController.swift
//  FourthWeekSeSac
//
//  Created by 변정훈 on 1/13/25.
//

import UIKit
import SnapKit

/*
 1. 스토리보드에서 객체 얹기
 2. 객체 레이아웃 잡기
 3. 아웃렛 연결하기
 4. 객체 속성 코드로 조절하기
 */

// Right To Left, Left To Right -> 글씨를 쓰는 순서
// leading, Trailing 으로 레이아웃을 잡으면 아랍 등 우리랑 반대의 순서를 갖는 국가에서도 자동으로 적용된다.



class ViewController: UIViewController {
    // 1. 뷰 객체 프로퍼티 선언
    let emailTextField = UITextField() // Class 인스턴스 생성
    
    // NSLayoutConstraint
    let passwordTextField = UITextField()
    
    // NSLayoutAnchor
    let nameTextField = UITextField()
    
    let redView = UIView()
    let greenView = UIView()
    let grayView = UIView()
    
    lazy var buttonView = {
        let btn = UIButton()
        
        print("Button Button Button")
        btn.setTitle("dd", for: .normal)
        btn.backgroundColor = .brown
        // 즉시 실행 함수
        btn.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)

        return btn
    } ()
    
    // BookViewController 로 전환하는 버튼
    @objc
    func nextButtonTapped() {
        print(#function)
        let vc = BookViewController()
        present(vc, animated: true)
    }
    
//    let test = test()
    
    // 그냥 let buttinView = makeMyButton() 을 사용하면 컴파일 단계에서 makeMyButton() 이 생성타이밍과 buttonView 의 생성타이밍이 같아져 buttonView 에 담을 수 없다 따라서 lazy 사용해야한다.
    func makeMyButton() -> UIButton {
        let btn = UIButton()
        
        btn.setTitle("다음", for: .normal)
        btn.backgroundColor = .brown
        
        return btn
    }
    
    // func test() 인스턴스 메서드와 let test 인스턴스 프로퍼티가 생성되느 시점이 같아서 사용불가
    func test() -> UIButton {
        let btn = UIButton()
        
        btn.setTitle("다음", for: .normal)
        btn.backgroundColor = .brown
        
        return btn
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewdidload")
        frameBasedLayoout()
        autoLayout()
        autoLayoutAnchor()
//        autoLayoutSnapKit()
        autoLayoutSnapKit2()
        configureButton()
        
        
    }
    
    func frameBasedLayoout() {
        // 2. addSubview 로 뷰 추가
        view.addSubview(emailTextField)
        
        // 3. 뷰의 위치와 크기 설정
        emailTextField.frame = CGRect(x: 50, y: 100, width: 293, height: 50)
        
        // 4. 뷰 속성 코드로 조절
        emailTextField.backgroundColor = .brown
    }
    
    func autoLayout() {
        view.addSubview(passwordTextField)
        
        // 오토리사이징을 끄고 오토레이아웃을 사용한다.
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let top = NSLayoutConstraint(item: passwordTextField, attribute: .top, relatedBy: .equal , toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 50)
        let leading = NSLayoutConstraint(item: passwordTextField, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 40)
        let trailing = NSLayoutConstraint(item: passwordTextField, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -40)
        let height = NSLayoutConstraint(item: passwordTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 50)
        
        view.addConstraints([top, leading, trailing, height])
        
        passwordTextField.backgroundColor = .black
    }
    
    func autoLayoutAnchor() {
        view.addSubview(nameTextField)
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.widthAnchor.constraint(equalToConstant:  300),
            nameTextField.heightAnchor.constraint(equalToConstant:  50),
            nameTextField.bottomAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        nameTextField.backgroundColor = .green
    }
    
    func autoLayoutSnapKit() {
        view.addSubview(redView)
        view.addSubview(greenView)
        view.addSubview(grayView)
        
        redView.backgroundColor = .red
        greenView.backgroundColor = .green
        grayView.backgroundColor = .gray
        
        redView.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide)
//            make.bottom.equalTo(view.safeAreaLayoutGuide)
//            make.verticalEdges.equalTo(view.safeAreaLayoutGuide)
            
            // 이걸 한번에 어캐하지
//            make.leading.equalTo(view.safeAreaLayoutGuide).offset(50)
//            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-50)
//            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            
            // 이렇게 한번에 한다.
//            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(50)
//            make.bottom.trailing.equalTo(view.safeAreaLayoutGuide).offset(-50)
            
            // 이렇게 하면 모든 방향으로 SwiftUI Padding 주는 느낌
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(50)
            
//            make.edges.equalTo(view.safeAreaLayoutGuide)
            
            
//            make.width.equalTo(300)
//            make.height.equalTo(300)
        }
        
        greenView.snp.makeConstraints { make in
//            make.centerX.equalTo(view.safeAreaLayoutGuide)
//            make.centerY.equalTo(view.safeAreaLayoutGuide)
//            make.centerX.centerY.equalTo(view.safeAreaLayoutGuide)
            make.center.equalTo(view)

            
//            make.width.equalTo(200)
//            make.height.equalTo(200)
//            make.width.height.equalTo(200)
            make.size.equalTo(200)

        }
        
        grayView.snp.makeConstraints { make in
            make.top.equalTo(greenView.snp.bottom).offset(50)
            make.centerX.equalTo(greenView.snp.centerX).offset(-50)
            make.size.equalTo(200)

        }
    }
    
    func autoLayoutSnapKit2() {
        view.addSubview(redView)
        view.addSubview(grayView)
        redView.addSubview(greenView)
        
        let array = [1,2,3,4,5]
        
        redView.backgroundColor = .red
        grayView.backgroundColor = .gray
        greenView.backgroundColor = .green
        
        
        redView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.center.equalToSuperview()
        }
        
        greenView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        grayView.snp.makeConstraints { make in
//            make.edges.equalTo(redView).offset(50)
            make.edges.equalTo(redView).inset(50)
            
        }
        
    }
    
    func configureButton() {
        view.addSubview(buttonView)
        
        buttonView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(300)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

