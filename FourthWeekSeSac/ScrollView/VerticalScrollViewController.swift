//
//  VerticalScrollViewController.swift
//  FourthWeekSeSac
//
//  Created by 변정훈 on 1/17/25.
//

import UIKit
import SnapKit

class VerticalScrollViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    
    let imageView = UIImageView()
    let label = UILabel()
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        configureLayout()
        configureContentView()
    }
    
    func configureLayout() {
        scrollView.backgroundColor = .lightGray
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.backgroundColor = .red
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width)
            make.verticalEdges.equalTo(scrollView)
//            make.edges.equalTo(scrollView)
        }
    }
    
    func configureContentView() {
        contentView.addSubview(label)
        contentView.addSubview(imageView)
        contentView.addSubview(button)
        
        label.backgroundColor = .orange
        imageView.backgroundColor = .black
        button.backgroundColor = .purple
        
        label.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(900)
        }
        
        imageView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(200)
        }
        
        button.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView).inset(20)
            make.top.equalTo(label.snp.bottom).offset(50)
            make.bottom.equalTo(imageView.snp.top).offset(-50)
        }
    }
        
    
}
