//
//  RandomViewController.swift
//  FourthWeekSeSac
//
//  Created by 변정훈 on 1/14/25.
//

import UIKit
import SnapKit
import Alamofire

// AnyObject 를 사용해서 class 만 채택가능하게 함
protocol ViewConfiguration: AnyObject {
    func configureHierarchy() // addSubView
    func configureLayout() // snapKit
    func configureView() // property
}

struct Dog: Decodable {
    let message: String
    let status: String
}

struct Lotto: Decodable {
    let drwNoDate: String
    let firstWinamnt: Int
}

struct User: Decodable {
    let results: [UserDetail]
//    let info:
}

struct UserDetail: Decodable {
    let gender: String
    let email: String
    let name: UserName
}

struct UserName: Decodable {
    let first: String
    let last: String
}


class RandomViewController: UIViewController, ViewConfiguration {
    let dogImageView = UIImageView()
    let nameLabel = UILabel()
    let randomButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureHierarchy()
        configureLayout()
        configureView()
        
    }
    
    func configureHierarchy() {
        view.addSubview(dogImageView)
        view.addSubview(nameLabel)
        view.addSubview(randomButton)
    }
    
    func configureLayout() {
        dogImageView.snp.makeConstraints { make in
            make.size.equalTo(300)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(dogImageView.snp.bottom).offset(20)
        }
        
        randomButton.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
        }
    }
    
    func configureView() {
        dogImageView.backgroundColor = .brown
        nameLabel.backgroundColor = .systemGreen
        randomButton.backgroundColor = .brown
        randomButton.addTarget(self, action: #selector(userButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func randomButtonTapped() {
        print("========1111111=========")
        
        let url = "https://dog.ceo/api/breeds/image/random"
        
        // responseDecodable: 응답이 잘못된것도 실패고, 식판에 안담겨도 실패
        // responseString: 식판이랑 상관없이 응답이 잘 왔는지 확인!
        AF.request(url, method: .get).responseDecodable(of: Dog.self) { response in
            
            print("========222222=========")
            
            switch response.result {
                
            case .success(let value):
                print(value.message)
                print(value.status)
                
                self.nameLabel.text = value.message
                // KF
            case .failure(let error):
                print(error)
            }
            print("========3333333=========")
            
        }
//        AF.request(url, method: .get).responseString { value in
//            print(value)
//        }
        
        print("========444444=========")
    }
    
    @objc
    func lottoButtonTapped() {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=888"
        
        AF.request(url, method: .get)
            .responseDecodable(of: Lotto.self) { response in
                      
            switch response.result {
                
            case .success(let value):
                self.nameLabel.text = value.drwNoDate + value.firstWinamnt.formatted()
                // KF
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc
    func userButtonTapped() {
        
        let url = "https://randomuser.me/api/?results=10"
        
        AF.request(url, method: .get)
            .responseDecodable(of: User.self) { response in
                      
            switch response.result {
                
            case .success(let value):
                self.nameLabel.text = value.results[0].name.first
                // KF
                
            case .failure(let error):
                print(error)
            }
        }
    }

}
