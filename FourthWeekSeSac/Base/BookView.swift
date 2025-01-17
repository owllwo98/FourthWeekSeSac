//
//  BookView.swift
//  FourthWeekSeSac
//
//  Created by 변정훈 on 1/16/25.
//

import UIKit
import SnapKit

class BookView: BaseView {
    lazy var collectionView =  {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: creatCollectionViewLayout())
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: "BookCollectionViewCell")
        
        return collectionView
    }()
    
    func creatCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 50)
        layout.scrollDirection = .vertical
        
        return layout
    }
    
//    func createCollectionView() -> UICollectionView {
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: creatCollectionViewLayout())
//        
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        
//        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: "BookCollectionViewCell")
//        
//        return collectionView
//    }
    
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
    }
}

extension BookView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell", for: indexPath) as! BookCollectionViewCell
        
        cell.bookCoverImageView.layer.cornerRadius = 8
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
    }
    
    
}
