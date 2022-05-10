//
//  Protocol.swift
//  PrecoEuroApi
//
//  Created by Luan.Lima on 20/04/22.
//

import Foundation

protocol ViewCode {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupView()
}

extension ViewCode {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
    
}
