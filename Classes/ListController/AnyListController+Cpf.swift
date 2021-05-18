//
//  AnyListController+Cpf.swift
//  ListController
//
//  Created by Aaron on 2021/5/13.
//

import UIKit
import CPFChain

// MARK: - Base
public extension Cpf where Base: AnyListController {
    @discardableResult
    func sectionCount(_ closour: @escaping () -> Int) -> Self {
        base.sectionCount(with: closour)
        return self
    }
    
    @discardableResult
    func itemList(_ closour: @escaping (Int) -> [Base.Item]) -> Self {
        base.itemList(with: closour)
        return self
    }
    
    @discardableResult
    func itemLists(_ data: [[Base.Item]]) -> Self {
        base.sectionCount { () -> Int in
            data.count
        }
        base.itemList { (section) -> [Base.Item] in
            guard 0..<data.endIndex ~= section else { return [] }
            return data[section]
        }
        return self
    }
    
    @discardableResult
    func itemList(_ data: [Base.Item]) -> Self {
        base.sectionCount { () -> Int in
            return 1
        }
        base.itemList { (section) -> [Base.Item] in
            return data
        }
        return self
    }
    
    @discardableResult
    func cellIdentifier(_ closour: @escaping (IndexPath, Base.Item) -> String) -> Self {
        base.cellIdentifier(with: closour)
        return self
    }
    
    @discardableResult
    func itemDidSelected(_ closour: @escaping (IndexPath, Base.Item) -> Void) -> Self {
        base.itemDidSelected(with: closour)
        return self
    }
    
    @discardableResult
    func scrolled(_ closour: @escaping (UIScrollView) -> Void) -> Self {
        base.scrolled(with: closour)
        return self
    }
}

// MARK: - Selectable
public extension Cpf where Base: AnyListController {
    @discardableResult
    func itemShouldHighlight(_ closour: @escaping (IndexPath, Base.Item) -> Bool) -> Self {
        base.itemShouldHighlight(with: closour)
        return self
    }

    @discardableResult
    func itemDidHighlight(_ closour: @escaping (IndexPath, Base.Item) -> Void) -> Self {
        base.itemDidHighlight(with: closour)
        return self
    }

    @discardableResult
    func itemDidUnHighlight(_ closour: @escaping (IndexPath, Base.Item) -> Void) -> Self {
        base.itemDidUnHighlight(with: closour)
        return self
    }

    @discardableResult
    func itemShouldSelect(_ closour: @escaping (IndexPath, Base.Item) -> Bool) -> Self {
        base.itemShouldSelect(with: closour)
        return self
    }

    func itemShouldDeselect(_ closour: @escaping (IndexPath, Base.Item) -> Bool) -> Self {
        base.itemShouldDeselect(with: closour)
        return self
    }

    @discardableResult
    func itemDidDeselected(_ closour: @escaping (IndexPath, Base.Item) -> Void) -> Self {
        base.itemDidDeselected(with: closour)
        return self
    }
}

// MARK: - Supplementary
public extension Cpf where Base: AnyListController {
    @discardableResult
    func headerIdentifier(_ closour: @escaping (IndexPath) -> String) -> Self {
        base.headerIdentifier(with: closour)
        return self
    }
    
    @discardableResult
    func footerIdentifier(_ closour: @escaping (IndexPath) -> String) -> Self {
        base.footerIdentifier(with: closour)
        return self
    }
}

extension AnyListController where ListView: UICollectionView {
    fileprivate func validateRegisterViews() {
        configurers.forEach { validateRegisterView(with: $0) }
    }

    fileprivate func validateRegisterView(with configurer: AnyListComponentConfigurer) {
        for configurer in configurers {
            switch configurer.type {
            case .cell:
                listView?.register(configurer.viewClass, forCellWithReuseIdentifier: configurer.id)
            case .supplementary(let type):
                switch type {
                case .header:
                    listView?.register(configurer.viewClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: configurer.id)
                case .footer:
                    listView?.register(configurer.viewClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: configurer.id)
                }
            }
        }
    }
}

extension AnyListController where ListView: UITableView {
    fileprivate func validateRegisterViews() {
        configurers.forEach { validateRegisterView(with: $0) }
    }
    
    fileprivate func validateRegisterView(with configurer: AnyListComponentConfigurer) {
        switch configurer.type {
        case .cell:
            listView?.register(configurer.viewClass, forCellReuseIdentifier: configurer.id)
        case .supplementary(let type):
            switch type {
            case .header:
                listView?.register(configurer.viewClass, forHeaderFooterViewReuseIdentifier: configurer.id)
            case .footer:
                listView?.register(configurer.viewClass, forHeaderFooterViewReuseIdentifier: configurer.id)
            }
        }
    }
}

public extension Cpf where Base: AnyListController, Base.ListView: UICollectionView {
    @discardableResult
    func link(_ listView: Base.ListView) -> Self {
        base.link(listView)
        base.validateRegisterViews()
        return self
    }

    @discardableResult
    func register<Cell: UICollectionViewCell>(
        cell cellClass: Cell.Type,
        for identifier: String? = nil,
        configure: @escaping (Cell, IndexPath, Base.Item) -> Void) -> Self {
        
        let configurer = CollectionCellConfigurer<Cell, Base.Item>(
            id: identifier ?? String(describing: Cell.self),
            action: configure
        )
        // Note: 注册同一个类型，同一个Id时，仅最后一个生效，前面重复的configurer会被移除
        base.configurers.removeAll(where: { $0.id == configurer.id && $0.type == configurer.type })
        base.configurers.append(configurer)
        
        base.validateRegisterView(with: configurer)
        base.enableConfiguring(of: .cell)
        return self
    }
}

public extension Cpf where Base: AnyListController, Base.ListView: UICollectionView {
    @discardableResult
    func register<View: UICollectionReusableView>(
        type: ListComponentType.SupplementaryType,
        view cellClass: View.Type,
        for identifier: String? = nil,
        configure: @escaping (View, IndexPath) -> Void) -> Self {
        
        let configurer = CollectionSupplementaryConfigurer<View>(
            type: .supplementary(type),
            id: identifier ?? String(describing: View.self),
            action: configure
        )
        // Note: 注册同一个类型，同一个Id时，仅最后一个生效，前面重复的configurer会被移除
        base.configurers.removeAll(where: { $0.id == configurer.id && $0.type == configurer.type })
        base.configurers.append(configurer)

        base.validateRegisterView(with: configurer)
        base.enableConfiguring(of: .supplementary(type))
        return self
    }
}

public extension Cpf where Base: AnyListController, Base.ListView: UITableView {
    @discardableResult
    func link(_ listView: Base.ListView) -> Self {
        base.link(listView)
        base.validateRegisterViews()
        return self
    }

    @discardableResult
    func register<Cell: UITableViewCell>(
        cell cellClass: Cell.Type,
        for identifier: String? = nil,
        config: @escaping (Cell, IndexPath, Base.Item) -> Void) -> Self {
        
        let configurer = TableCellConfigurer<Cell, Base.Item>(
            id: identifier ?? String(describing: Cell.self),
            action: config
        )
        // Note: 注册同一个类型，同一个Id时，仅最后一个生效，前面重复的configurer会被移除
        base.configurers.removeAll(where: { $0.id == configurer.id && $0.type == configurer.type })
        base.configurers.append(configurer)
        
        base.validateRegisterView(with: configurer)
        base.enableConfiguring(of: .cell)
        return self
    }
}

public extension Cpf where Base: AnyListController, Base.ListView: UITableView {
    @discardableResult
    func register<View: UITableViewHeaderFooterView>(
        type: ListComponentType.SupplementaryType,
        view cellClass: View.Type,
        for identifier: String? = nil,
        configure: @escaping (View, IndexPath) -> Void) -> Self {
        
        let configurer = TableSupplementaryConfigurer<View>(
            type: .supplementary(type),
            id: identifier ?? String(describing: View.self),
            action: configure
        )
        // Note: 注册同一个类型，同一个Id时，仅最后一个生效，前面重复的configurer会被移除
        base.configurers.removeAll(where: { $0.id == configurer.id && $0.type == configurer.type })
        base.configurers.append(configurer)

        base.validateRegisterView(with: configurer)
        base.enableConfiguring(of: .supplementary(type))
        return self
    }
}

// MARK: - Layout
public extension Cpf where Base: AnyListController, Base.ListView: UICollectionView {
    @discardableResult
    func cellSize(_ closour: @escaping (IndexPath, Base.Item) -> CGSize) -> Self {
        base.cellSize(with: closour)
        return self
    }
    
    @discardableResult
    func sectionInsets(_ closour: @escaping (Int) -> UIEdgeInsets) -> Self {
        base.sectionInsets(with: closour)
        return self
    }
    
    @discardableResult
    func lineSpacing(_ closour: @escaping (Int) -> CGFloat) -> Self {
        base.lineSpacing(with: closour)
        return self
    }
    
    @discardableResult
    func interitemSpacing(_ closour: @escaping (Int) -> CGFloat) -> Self {
        base.interitemSpacing(with: closour)
        return self
    }
    
    @discardableResult
    func headerSize(_ closour: @escaping (Int) -> CGSize) -> Self {
        base.headerSize(with: closour)
        return self
    }
    
    @discardableResult
    func footerSize(_ closour: @escaping (Int) -> CGSize) -> Self {
        base.footerSize(with: closour)
        return self
    }
}

public extension Cpf where Base: AnyListController, Base.ListView: UITableView {
    @discardableResult
    func rowHeight(_ closour: @escaping (IndexPath, Base.Item) -> CGFloat) -> Self {
        base.rowHeight(with: closour)
        return self
    }

    @discardableResult
    func headerHeight(_ closour: @escaping (Int) -> CGFloat) -> Self {
        base.headerHeight(with: closour)
        return self
    }
    
    @discardableResult
    func footerHeight(_ closour: @escaping (Int) -> CGFloat) -> Self {
        base.footerHeight(with: closour)
        return self
    }
}

// MARK: - Scrollable
public extension Cpf where Base: AnyListController, Base.ListView: UIScrollView {
    @discardableResult
    func willBeginDecelerating(_ closour: @escaping (UIScrollView) -> Void) -> Self {
        base.willBeginDecelerating(with: closour)
        return self
    }
    
    @discardableResult
    func didEndDecelerating(_ closour: @escaping (UIScrollView) -> Void) -> Self {
        base.didEndDecelerating(with: closour)
        return self
    }

    @discardableResult
    func willBeginDragging(_ closour: @escaping (UIScrollView) -> Void) -> Self {
        base.willBeginDragging(with: closour)
        return self
    }
    
    @discardableResult
    func willEndDragging(_ closour: @escaping (UIScrollView, CGPoint, UnsafeMutablePointer<CGPoint>?) -> Void) -> Self {
        base.willEndDragging(with: closour)
        return self
    }

    @discardableResult
    func didEndDragging(_ closour: @escaping (UIScrollView, Bool) -> Void) -> Self {
        base.didEndDragging(with: closour)
        return self
    }

    @discardableResult
    func didEndScrollingAnimation(_ closour: @escaping (UIScrollView) -> Void) -> Self {
        base.didEndScrollingAnimation(with: closour)
        return self
    }
    
    @discardableResult
    func shouldScrollToTop(_ closour: @escaping (UIScrollView) -> Bool) -> Self {
        base.shouldScrollToTop(with: closour)
        return self
    }

    @discardableResult
    func didScrollToTop(_ closour: @escaping (UIScrollView) -> Void) -> Self {
        base.didScrollToTop(with: closour)
        return self
    }
    
    @discardableResult
    func didZoom(_ closour: @escaping (UIScrollView) -> Void) -> Self {
        base.didZoom(with: closour)
        return self
    }

    @discardableResult
    func viewForZooming(_ closour: @escaping (UIScrollView) -> UIView?) -> Self {
        base.viewForZooming(with: closour)
        return self
    }

    @discardableResult
    func willBeginZooming(_ closour: @escaping (UIScrollView, UIView?) -> Void) -> Self {
        base.willBeginZooming(with: closour)
        return self
    }
    
    @discardableResult
    func didEndZooming(_ closour: @escaping (UIScrollView, UIView?, CGFloat) -> Void) -> Self {
        base.didEndZooming(with: closour)
        return self
    }
}

extension NSProxy: CpfCompatible {}
