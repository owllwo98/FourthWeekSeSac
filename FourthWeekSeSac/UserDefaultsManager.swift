//
//  UserDefaultsManager.swift
//  FourthWeekSeSac
//
//  Created by 변정훈 on 1/16/25.
//

import Foundation

class UserDefaultsManager {
    
    // Singleton Pattern
    // 장점? 단점?
    // 다른 외부애서 UserDefaultsManager 공간을 만들지 않고 하나의 공간에서만 쓰겠다!
    static let shared = UserDefaultsManager()
    
    // 인스턴스 생성을 막기 위해서 Class 초기화를 막아버린다.
    private init() {}
    
    var age: Int {
        get {
            UserDefaults.standard.integer(forKey: "age")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "age")
        }
    }
    
    var nickname: String {
        get {
            UserDefaults.standard.string(forKey: "name") ?? "대장"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "name")
        }
    }
}
