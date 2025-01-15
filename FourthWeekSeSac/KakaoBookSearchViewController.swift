//
//  KakaoBookSearchViewController.swift
//  SeSACFourthWeek
//
//  Created by Jack on 1/14/25.
//

import UIKit
import Alamofire
import SnapKit

class KakaoBookSearchViewController: UIViewController {
    
    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    var list: [BookDetail] = []
    
    var query: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureSearchBar()
        configureTableView()
        
    }
    
    func configureView() {
        view.backgroundColor = .white
    }
    
    func configureSearchBar() {
        view.addSubview(searchBar)
        
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        searchBar.delegate = self
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp.bottom)
        }
        
        tableView.rowHeight = 120
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(KakaoBookSearchTableViewCell.self, forCellReuseIdentifier: KakaoBookSearchTableViewCell.id)
        // Scroll 할때 Keyboard Dismiss
        tableView.keyboardDismissMode = .onDrag

    }
    
    func callRequest() {
        print(#function)
        
        let url = "https://dapi.kakao.com/v3/search/book.json?query=\(query)"
        
        let headers: HTTPHeaders = ["Authorization" : APIKey.kakao]
        
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: Book.self) { response in
            
            switch response.result {
                
            case.success(let value):
                print(value.documents[0].title)
                self.list = value.documents
                self.tableView.reloadData()
            case.failure(let error) :
                print(error)
            }
        }
    }
}


extension KakaoBookSearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        callRequest()
    }
    
}


extension KakaoBookSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KakaoBookSearchTableViewCell.id, for: indexPath) as? KakaoBookSearchTableViewCell else { return UITableViewCell() }
         
        let data = list[indexPath.row]
        
        cell.titleLabel.text = "타이틀 레이블: \(data)"
        cell.overviewLabel.text = "줄거리 레이블: \(data)"
        cell.thumbnailImageView.backgroundColor = .brown
        
        return cell
    }
    
}

