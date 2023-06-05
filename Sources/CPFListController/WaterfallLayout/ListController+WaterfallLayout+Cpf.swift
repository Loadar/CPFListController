//
//  ListController+WaterfallLayout+Cpf.swift
//  
//
//  Created by Aaron on 2023/6/5.
//

import UIKit
import CPFChain
import CPFWaterfallFlowLayout
import CPFListController

public extension Cpf where Wrapped: AnyListController, Wrapped.ListView: UICollectionView {
    @discardableResult
    func columnCount(_ closour: @escaping (Int) -> (Int)) -> Self {
        wrapped.listView?.cpf.columnCount(closour)
        return self
    }
}
