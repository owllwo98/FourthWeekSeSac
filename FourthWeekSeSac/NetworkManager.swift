//
//  NetworkManager.swift
//  FourthWeekSeSac
//
//  Created by 변정훈 on 1/16/25.
//

import UIKit
import Alamofire
 
class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init () {}
    
    func randomUser(completionhandler: @escaping (String) -> Void) {
        let url = "https://randomuser.me/api/?results=10"
        
        AF.request(url, method: .get)
            .responseDecodable(of: User.self) { response in
                      
            switch response.result {
                
            case .success(let value):
                print("Succes", value.results[0].name.last)
                
                let result = value.results[0].name.last
                completionhandler(result)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func callKakaoBookAPI(query: String, page: Int, completionHandle: @escaping (Book) -> Void) {
        
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
                completionHandle(value)
                
            case.failure(let error) :
                print(error)
            }
        }
    }
    
    func callKakaoBookAPITest(query: String, page: Int, completionHandle: @escaping (Book) -> Void) {
        
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
                completionHandle(value)
                
            case.failure(let error) :
                print(error)
            }
        }
    }
    
}
