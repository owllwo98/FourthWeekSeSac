//
//  BookCollectionViewCell.swift
//  FourthWeekSeSac
//
//  Created by 변정훈 on 1/13/25.
//

import UIKit
import SnapKit

class BookCollectionViewCell: UICollectionViewCell {
    
    let bookCoverImageView = UIImageView()
    
    
    // viewDidLoad, awakeFromNib 과 비슷하다
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 셀에는 contentView 가 존재! 여기에다가 뷰를 추가해주어야 액션이 동작합니다.
        contentView.addSubview(bookCoverImageView)
        
        bookCoverImageView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        bookCoverImageView.backgroundColor = .brown
    }
    
    // 내일
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
