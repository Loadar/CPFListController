//
//  AnyListController+Cpf.swift
//  ListController
//
//  Created by Aaron on 2021/5/13.
//

import UIKit
import CPFChain

// MARK: - Base
public extension Cpf where Wrapped: AnyListController {
    @discardableResult
    func sectionCount(_ closour: @escaping () -> Int) -> Self {
        wrapped.sectionCount(with: closour)
        return self
    }
    
    @discardableResult
    func itemList(_ closour: @escaping (Int) -> [Wrapped.Item]) -> Self {
        wrapped.itemList(with: closour)
        return self
    }
    
    @discardableResult
    func itemLists(_ data: [[Wrapped.Item]]) -> Self {
        wrapped.sectionCount { () -> Int in
            data.count
        }
        wrapped.itemList { (section) -> [Wrapped.Item] in
            guard 0..<data.endIndex ~= section else { return [] }
            return data[section]
        }
        return self
    }
    
    @discardableResult
    func itemList(_ data: [Wrapped.Item]) -> Self {
        wrapped.sectionCount { () -> Int in
            return 1
        }
        wrapped.itemList { (section) -> [Wrapped.Item] in
            return data
        }
        return self
    }
    
    @discardableResult
    func cellIdentifier(_ closour: @escaping (IndexPath, Wrapped.Item) -> String) -> Self {
        wrapped.cellIdentifier(with: closour)
        return self
    }
    
    @discardableResult
    func itemDidSelected(_ closour: @escaping (IndexPath, Wrapped.Item) -> Void) -> Self {
        wrapped.itemDidSelected(with: closour)
        return self
    }
    
    @discardableResult
    func scrolled(_ closour: @escaping (UIScrollView) -> Void) -> Self {
        wrapped.scrolled(with: closour)
        return self
    }
}

// MARK: - Selectable
public extension Cpf where Wrapped: AnyListController {
    @discardableResult
    func itemShouldHighlight(_ closour: @escaping (IndexPath, Wrapped.Item) -> Bool) -> Self {
        wrapped.itemShouldHighlight(with: closour)
        return self
    }
    
    @discardableResult
    func itemDidHighlight(_ closour: @escaping (IndexPath, Wrapped.Item) -> Void) -> Self {
        wrapped.itemDidHighlight(with: closour)
        return self
    }
    
    @discardableResult
    func itemDidUnHighlight(_ closour: @escaping (IndexPath, Wrapped.Item) -> Void) -> Self {
        wrapped.itemDidUnHighlight(with: closour)
        return self
    }
    
    @discardableResult
    func itemShouldSelect(_ closour: @escaping (IndexPath, Wrapped.Item) -> Bool) -> Self {
        wrapped.itemShouldSelect(with: closour)
        return self
    }
    
    func itemShouldDeselect(_ closour: @escaping (IndexPath, Wrapped.Item) -> Bool) -> Self {
        wrapped.itemShouldDeselect(with: closour)
        return self
    }
    
    @discardableResult
    func itemDidDeselected(_ closour: @escaping (IndexPath, Wrapped.Item) -> Void) -> Self {
        wrapped.itemDidDeselected(with: closour)
        return self
    }
}

// MARK: - Supplementary
public extension Cpf where Wrapped: AnyListController {
    @discardableResult
    func headerIdentifier(_ closour: @escaping (IndexPath) -> String) -> Self {
        wrapped.headerIdentifier(with: closour)
        return self
    }
    
    @discardableResult
    func footerIdentifier(_ closour: @escaping (IndexPath) -> String) -> Self {
        wrapped.footerIdentifier(with: closour)
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

public extension Cpf where Wrapped: AnyListController, Wrapped.ListView: UICollectionView {
    @discardableResult
    func link(_ listView: Wrapped.ListView) -> Self {
        wrapped.link(listView)
        wrapped.validateRegisterViews()
        return self
    }
    
    @discardableResult
    func register<Cell: UICollectionViewCell>(
        cell cellClass: Cell.Type,
        for identifier: String? = nil,
        configure: @escaping (Cell, IndexPath, Wrapped.Item) -> Void) -> Self {
            
            let configurer = CollectionCellConfigurer<Cell, Wrapped.Item>(
                id: identifier ?? String(describing: Cell.self),
                action: configure
            )
            // Note: 注册同一个类型，同一个Id时，仅最后一个生效，前面重复的configurer会被移除
            wrapped.configurers.removeAll(where: { $0.id == configurer.id && $0.type == configurer.type })
            wrapped.configurers.append(configurer)
            
            wrapped.validateRegisterView(with: configurer)
            wrapped.enableConfiguring(of: .cell)
            return self
        }
}

public extension Cpf where Wrapped: AnyListController, Wrapped.ListView: UICollectionView {
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
            wrapped.configurers.removeAll(where: { $0.id == configurer.id && $0.type == configurer.type })
            wrapped.configurers.append(configurer)
            
            wrapped.validateRegisterView(with: configurer)
            wrapped.enableConfiguring(of: .supplementary(type))
            return self
        }
}

public extension Cpf where Wrapped: AnyListController, Wrapped.ListView: UITableView {
    @discardableResult
    func link(_ listView: Wrapped.ListView) -> Self {
        wrapped.link(listView)
        wrapped.validateRegisterViews()
        return self
    }
    
    @discardableResult
    func register<Cell: UITableViewCell>(
        cell cellClass: Cell.Type,
        for identifier: String? = nil,
        config: @escaping (Cell, IndexPath, Wrapped.Item) -> Void) -> Self {
            
            let configurer = TableCellConfigurer<Cell, Wrapped.Item>(
                id: identifier ?? String(describing: Cell.self),
                action: config
            )
            // Note: 注册同一个类型，同一个Id时，仅最后一个生效，前面重复的configurer会被移除
            wrapped.configurers.removeAll(where: { $0.id == configurer.id && $0.type == configurer.type })
            wrapped.configurers.append(configurer)
            
            wrapped.validateRegisterView(with: configurer)
            wrapped.enableConfiguring(of: .cell)
            return self
        }
}

public extension Cpf where Wrapped: AnyListController, Wrapped.ListView: UITableView {
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
            wrapped.configurers.removeAll(where: { $0.id == configurer.id && $0.type == configurer.type })
            wrapped.configurers.append(configurer)
            
            wrapped.validateRegisterView(with: configurer)
            wrapped.enableConfiguring(of: .supplementary(type))
            return self
        }
}

// MARK: - Layout
public extension Cpf where Wrapped: AnyListController, Wrapped.ListView: UICollectionView {
    @discardableResult
    func cellSize(_ closour: @escaping (IndexPath, Wrapped.Item) -> CGSize) -> Self {
        wrapped.cellSize(with: closour)
        return self
    }
    
    @discardableResult
    func sectionInsets(_ closour: @escaping (Int) -> UIEdgeInsets) -> Self {
        wrapped.sectionInsets(with: closour)
        return self
    }
    
    @discardableResult
    func lineSpacing(_ closour: @escaping (Int) -> CGFloat) -> Self {
        wrapped.lineSpacing(with: closour)
        return self
    }
    
    @discardableResult
    func interitemSpacing(_ closour: @escaping (Int) -> CGFloat) -> Self {
        wrapped.interitemSpacing(with: closour)
        return self
    }
    
    @discardableResult
    func headerSize(_ closour: @escaping (Int) -> CGSize) -> Self {
        wrapped.headerSize(with: closour)
        return self
    }
    
    @discardableResult
    func footerSize(_ closour: @escaping (Int) -> CGSize) -> Self {
        wrapped.footerSize(with: closour)
        return self
    }
}

public extension Cpf where Wrapped: AnyListController, Wrapped.ListView: UITableView {
    @discardableResult
    func rowHeight(_ closour: @escaping (IndexPath, Wrapped.Item) -> CGFloat) -> Self {
        wrapped.rowHeight(with: closour)
        return self
    }
    
    @discardableResult
    func headerHeight(_ closour: @escaping (Int) -> CGFloat) -> Self {
        wrapped.headerHeight(with: closour)
        return self
    }
    
    @discardableResult
    func footerHeight(_ closour: @escaping (Int) -> CGFloat) -> Self {
        wrapped.footerHeight(with: closour)
        return self
    }
}

// MARK: - Scrollable
public extension Cpf where Wrapped: AnyListController, Wrapped.ListView: UIScrollView {
    @discardableResult
    func willBeginDecelerating(_ closour: @escaping (UIScrollView) -> Void) -> Self {
        wrapped.willBeginDecelerating(with: closour)
        return self
    }
    
    @discardableResult
    func didEndDecelerating(_ closour: @escaping (UIScrollView) -> Void) -> Self {
        wrapped.didEndDecelerating(with: closour)
        return self
    }
    
    @discardableResult
    func willBeginDragging(_ closour: @escaping (UIScrollView) -> Void) -> Self {
        wrapped.willBeginDragging(with: closour)
        return self
    }
    
    @discardableResult
    func willEndDragging(_ closour: @escaping (UIScrollView, CGPoint, UnsafeMutablePointer<CGPoint>?) -> Void) -> Self {
        wrapped.willEndDragging(with: closour)
        return self
    }
    
    @discardableResult
    func didEndDragging(_ closour: @escaping (UIScrollView, Bool) -> Void) -> Self {
        wrapped.didEndDragging(with: closour)
        return self
    }
    
    @discardableResult
    func didEndScrollingAnimation(_ closour: @escaping (UIScrollView) -> Void) -> Self {
        wrapped.didEndScrollingAnimation(with: closour)
        return self
    }
    
    @discardableResult
    func shouldScrollToTop(_ closour: @escaping (UIScrollView) -> Bool) -> Self {
        wrapped.shouldScrollToTop(with: closour)
        return self
    }
    
    @discardableResult
    func didScrollToTop(_ closour: @escaping (UIScrollView) -> Void) -> Self {
        wrapped.didScrollToTop(with: closour)
        return self
    }
    
    @discardableResult
    func didZoom(_ closour: @escaping (UIScrollView) -> Void) -> Self {
        wrapped.didZoom(with: closour)
        return self
    }
    
    @discardableResult
    func viewForZooming(_ closour: @escaping (UIScrollView) -> UIView?) -> Self {
        wrapped.viewForZooming(with: closour)
        return self
    }
    
    @discardableResult
    func willBeginZooming(_ closour: @escaping (UIScrollView, UIView?) -> Void) -> Self {
        wrapped.willBeginZooming(with: closour)
        return self
    }
    
    @discardableResult
    func didEndZooming(_ closour: @escaping (UIScrollView, UIView?, CGFloat) -> Void) -> Self {
        wrapped.didEndZooming(with: closour)
        return self
    }
    
    @discardableResult
    func didEndScrollCompletely(_ closour: @escaping (UIScrollView) -> Void) -> Self {
        wrapped.didEndScrollCompletely(with: closour)
        return self
    }
}

extension NSProxy: CpfCompatible {}
