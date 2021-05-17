//
//  WaterfallLayout+Cpf.swift
//  CPFListControllerApp
//
//  Created by Aaron on 2021/5/17.
//

import Foundation
import CPFChain
import CPFWaterfallFlowLayout

public extension Cpf where Base: AnyListController, Base.ListView: UICollectionView {
    @discardableResult
    func columnCount(_ closour: @escaping (Int) -> (Int)) -> Self {
        base.listView?.cpf.columnCount(closour)
        return self
    }
}
