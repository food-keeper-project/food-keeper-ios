//
//  BaseVM.swift
//  FoodKeeperFoundation
//
//  Created by 박성민 on 1/21/26.
//

import Foundation

import RxSwift

public protocol BaseVM: AnyObject {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
