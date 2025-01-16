//
//  MarketViewController.swift
//  SeSACFourthWeek
//
//  Created by Jack on 1/14/25.
//

import UIKit
import SnapKit
import Alamofire

/*
 서버에서 키를 바꾸면 앱이 터진다
 1. 옵셔널을 통해 해결
 2. CodingKeys 를 통해 해결 -> DecodingStrategy
 */

struct Market: Decodable {
    let market: String
    let name: String?
    let korean: String
    let english: String
    
    // 멤버와 값의 분리
    enum CodingKeys: String, CodingKey {
        case market
        case name
        case korean = "korean_name"
        case english = "english_name"
    }
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.market = try container.decode(String.self, forKey: .market)
//        self.name = try container.decodeIfPresent(String.self, forKey: .name)
//        self.korean = try container.decode(String.self, forKey: .korean)
//        self.english = try container.decode(String.self, forKey: .english)
//    }
}


class MarketViewController: UIViewController {
 
    let tableView = UITableView()
    
    let list = Array(1...100)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureTableView()
        callRequest()

    }
    
    func callRequest() {
        let url = "https://api.upbit.com/v1/market/all"
        
        AF.request(url, method: .get)
            .responseDecodable(of: [Market].self) { response in
                
                switch response.result {
                
            case.success(let value):
                    print(value)
            case.failure(let error) :
                print(error)
            }
        }
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.backgroundColor = .white
        tableView.rowHeight = 50
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MarketTableViewCell.self, forCellReuseIdentifier: MarketTableViewCell.id)
    }
    
    func configureView() {
        view.backgroundColor = .white
    }

}

extension MarketViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function, list.count)
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MarketTableViewCell.id, for: indexPath) as? MarketTableViewCell else { return UITableViewCell() }
        
        let data = list[indexPath.row]
        
        cell.nameLabel.text = "마켓 레이블: \(data)"
        
        return cell
    }
    
}
