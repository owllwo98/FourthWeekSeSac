//
//  BookView.swift
//  FourthWeekSeSac
//
//  Created by 변정훈 on 1/16/25.
//

import UIKit
import SnapKit

class BookView: BaseView {
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: creatCollectionViewLayout())
    
    
    func creatCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 50)
        layout.scrollDirection = .vertical
        
        return layout
    }
    
    override func configureHierarchy() {
        self.addSubview(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureView() {
        backgroundColor = .white
        
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: "BookCollectionViewCell")
    }
}
