//
//  ImageZoomViewController.swift
//  FourthWeekSeSac
//
//  Created by 변정훈 on 1/17/25.
//

import UIKit
import SnapKit

class ImageZoomViewController: UIViewController {
    
    private lazy var scrollView = {
        let view = UIScrollView()
        view.backgroundColor = .green
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.alwaysBounceVertical
        view.maximumZoomScale = 5.0
        view.minimumZoomScale = 1
        view.delegate = self
        
        return view
    }()
    
    // 즉시 실행 함수
    private let imageView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .yellow
        view.image = UIImage(systemName: "star")
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        scrollView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.center.equalTo(view)
        }
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(scrollView)
        }
        
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(doubleTapGesture))
        tap.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(tap)
    }
    
    
    
    @objc
    func doubleTapGesture() {
        if scrollView.zoomScale == 1 {
            scrollView.setZoomScale(3, animated: true)
        } else {
            scrollView.setZoomScale(1, animated: true)
        }
    }
}

extension ImageZoomViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
