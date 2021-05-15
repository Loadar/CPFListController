//
//  CellConfigurer.swift
//  ListController
//
//  Created by Aaron on 2021/5/13.
//

import Foundation

public enum ListComponentType: Equatable {
    public enum SupplementaryType {
        case header
        case footer
    }

    case cell
    case supplementary(SupplementaryType)
    
    var title: String {
        switch self {
        case .cell:
            return "cell"
        case .supplementary(let type):
            switch type {
            case .header:
                return "header"
            case .footer:
                return "footer"
            }
        }
    }
    
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.cell, .cell):
            return true
        case (.supplementary(let first), .supplementary(let second)):
            return first == second
        default:
            return false
        }
    }
}


/// 任意的cell配置器
public protocol AnyListComponentConfigurer {
    /// cell复用使用的identifier
    var id: String { get }
    var originalId: String { get }
    var type: ListComponentType { get }
    
    var viewClass: AnyClass { get }
}

public class PartialCellConfigurer<Item>: AnyListComponentConfigurer {
    public let id: String
    public var originalId: String { id }
    public var type: ListComponentType { .cell }
    public var viewClass: AnyClass {
        assert(false, "子类实现")
        return UICollectionViewCell.self
    }

    
    init(id: String) {
        self.id = id
    }
    
    func configure(cell: UIView, at indexPath: IndexPath, for item: Item) {
        assert(false, "子类实现")
    }
}

/// cell配置器
public class CellConfigurer<Cell: UIView, Item>: PartialCellConfigurer<Item> {
    public let configureAction: (Cell, IndexPath, Item) -> Void
    public override var viewClass: AnyClass {
        return Cell.self
    }
    
    init(id: String, action: @escaping (Cell, IndexPath, Item) -> Void) {
        configureAction = action
        super.init(id: id)
    }
    
    override func configure(cell: UIView, at indexPath: IndexPath, for item: Item) {
        guard let cell = cell as? Cell else { return }
        configureAction(cell, indexPath, item)
    }
}

public class CollectionCellConfigurer<Cell: UICollectionViewCell, Item>: CellConfigurer<Cell, Item> {
    
}

public class TableCellConfigurer<Cell: UITableViewCell, Item>: CellConfigurer<Cell, Item> {
    
}

public class PartialSupplementaryViewConfigurer: AnyListComponentConfigurer {
    public let type: ListComponentType
    public let id: String
    public let originalId: String
    public var viewClass: AnyClass {
        assert(false, "子类实现")
        return UIView.self
    }

    
    init(type: ListComponentType, id: String, originalId: String) {
        self.type = type
        self.id = id
        self.originalId = originalId
    }
    
    func configure(view: UIView, at indexPath: IndexPath) {
        assert(false, "子类实现")
    }
}

public class SupplementaryViewConfigurer<View: UIView>: PartialSupplementaryViewConfigurer {
    public let configureAction: (View, IndexPath) -> Void
    public override var viewClass: AnyClass { View.self }

    init(type: ListComponentType, id: String, effectiveId: String? = nil, action: @escaping (View, IndexPath) -> Void) {
        self.configureAction = action
        super.init(type: type, id: effectiveId ?? id, originalId: id)
    }

    override func configure(view: UIView, at indexPath: IndexPath) {
        guard let view = view as? View else { return }
        configureAction(view, indexPath)
    }
}

public class CollectionSupplementaryConfigurer<View: UICollectionReusableView>: SupplementaryViewConfigurer<View> {
    
}

public class TableSupplementaryConfigurer<View: UITableViewHeaderFooterView>: SupplementaryViewConfigurer<View> {
    override init(type: ListComponentType, id: String, effectiveId: String? = nil, action: @escaping (View, IndexPath) -> Void) {
        super.init(type: type, id: id, effectiveId: type.title + id, action: action)
    }
}
