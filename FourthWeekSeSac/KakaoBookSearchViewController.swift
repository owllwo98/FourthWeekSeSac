//
//  KakaoBookSearchViewController.swift
//  SeSACFourthWeek
//
//  Created by Jack on 1/14/25.
//

import UIKit
import Alamofire
import SnapKit
import Kingfisher

class KakaoBookSearchViewController: UIViewController {
    
    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    var list: [BookDetail] = []
    
    /*
     1. 스크롤이 끝날 쯤 다음 페이지를 요청 (page += 1 후 callRequest)
     2. 이전 내용도 확인해야 해서 list.append 로 수정
     3. 다른 검색어를 입력한 경우, 배열 초기화
     4. 새로운 검색어 입력시 cell 최상단으로 이동
     5. 마지막 페이지인 경우 더이상 호출하지 않기
     */
    
    
    var page = 1
    var isEnd = false
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
        
        tableView.prefetchDataSource = self
    }
    
    func callRequest() {
        print(#function)
        
        query = searchBar.text ?? "네이버"
        
        let url = "https://dapi.kakao.com/v3/search/book.json?query=\(query)&size=20&page=\(page)"
        
        let headers: HTTPHeaders = ["Authorization" : APIKey.kakao]
        
        // 상태 코드 (200, 401, 404 ...) .validate(statusCode: 200..<300) -> 200 ~ 299 까지를 success 로 보겠다.
        AF.request(url, method: .get, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Book.self) { response in
            
//                print(response.response?.statusCode)
                
            switch response.result {
                
            case.success(let value):
                // page 1 1-20 page 2 21-40
//                self.list.append(contentsOf: value.documents)
                
                self.isEnd = value.meta.is_end
                
                if self.page == 1 {
                    self.list = value.documents
                } else {
                    self.list.append(contentsOf: value.documents)
                }
                
                self.tableView.reloadData()
                
                if self.page == 1 {
                    self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                }
                
            case.failure(let error) :
                print(error)
            }
        }
    }
}


extension KakaoBookSearchViewController: UISearchBarDelegate {
    
    // 검색 버튼 클릭 시무조건 통신되지 않고,
    // 빈칸, 최소 1글자 이상, 같은 글자에 대한 처리 필요
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        page = 1
        callRequest()
    }
    
}


extension KakaoBookSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print(#function)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KakaoBookSearchTableViewCell.id, for: indexPath) as? KakaoBookSearchTableViewCell else { return UITableViewCell() }
         
        let data = list[indexPath.row]
        
        let url = URL(string: data.thumbnail)
        
        cell.titleLabel.text = "타이틀 레이블: \(data.title)"
        cell.overviewLabel.text = "줄거리 레이블: \(data.contents)"
        cell.thumbnailImageView.backgroundColor = .brown
        cell.thumbnailImageView.kf.setImage(with: url)

        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        print(#function, indexPath)
//    }
//    
//    // UIScrollViewDelegate
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(#function, scrollView.contentSize.height, scrollView.contentOffset.y)
//    }
    
}

extension KakaoBookSearchViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        print(#function, indexPaths)
        
        for item in indexPaths {
            // 사용자의 마지막 스크롤 시점
            if list.count - 2 == item.row && !isEnd {
                page += 1
                callRequest()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print(#function, indexPaths)
    }
    
}


