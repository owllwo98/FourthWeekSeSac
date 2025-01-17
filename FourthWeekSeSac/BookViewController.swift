//
//  BookViewController.swift
//  FourthWeekSeSac
//
//  Created by 변정훈 on 1/13/25.
//

import UIKit
import SnapKit

class BookViewController: UIViewController {
    
    var mainView = BookView()
    
    
    
    // loadView() 먼저 실행 후 viewDidLoad 실행
    // super 호출 X
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        mainView.collectionView.dataSource = self
//        mainView.collectionView.delegate = self
        
        UserDefaultsManager.shared.age = 1
        print( UserDefaultsManager.shared.age = 1)
        
        NetworkManager.shared.randomUser { name in
            self.navigationItem.title = name
        }
 
    }
}

//extension BookViewController: UICollectionViewDataSource, UICollectionViewDelegate {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 100
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell", for: indexPath) as! BookCollectionViewCell
//        
//        cell.bookCoverImageView.layer.cornerRadius = 8
//        
//        return cell
//    }
//    
//    
//}
