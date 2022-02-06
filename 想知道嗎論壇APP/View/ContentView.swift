//
//  ContentView.swift
//  想知道嗎論壇APP
//
//  Created by Jhen Mu on 2022/1/19.
//

import UIKit

class ContentView: UIView {

    private let collectionButtonContainer:UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let menuContainer:UIView = {
       let view = UIView()
        view.backgroundColor = .cyan
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionButtonContainer)
        addSubview(menuContainer)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout(){
        collectionButtonContainer.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(60)
        }
        
        menuContainer.snp.makeConstraints { make in
            make.top.equalTo(collectionButtonContainer.snp_bottomMargin)
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        
    }
}
