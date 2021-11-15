//
//  ViewCode.swift
//  GymApp
//
//  Created by rafael.rollo on 10/11/21.
//

import Foundation

protocol ViewCode {
    func setup()
    
    func addTheme()
    func addViews()
    func addConstraints()
}

extension ViewCode {
    
    func setup() {
        addTheme()
        addViews()
        addConstraints()
    }
    
    func addTheme() {}
    func addViews() {}
    func addConstraints() {}
    
}

protocol ViewCodeController: ViewCode {
    func addChild()
}

extension ViewCodeController {
    func setup() {
        addTheme()
        addViews()
        addChild()
        addConstraints()
    }

    func addChild() {}
}
