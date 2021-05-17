//
//  ListFeature.swift
//  ListController
//
//  Created by Aaron on 2021/5/15.
//

import Foundation

/// 列表功能
public enum ListFeature: Hashable {
    /// 基础功能
    case base
    /// 选择
    case selectable
    /// header or footer
    case supplementary
    /// layout
    case layout
    /// scroll
    case scrollable
    /// 索引
    case index
    /// 自定义，传入一个字符以区分不同的feature， 同时提供一个闭包生成对应的target
    case custom(String, (() -> AnyObject)?)
    
    public static func == (lhs: ListFeature, rhs: ListFeature) -> Bool {
        switch (lhs, rhs) {
        case (.base, .base),
             (.selectable, .selectable),
             (.supplementary, .supplementary),
             (.layout, .layout),
             (.scrollable, .scrollable),
             (.index, .index):
            return true
        case (.custom(let first, _), .custom(let second, _)):
            return first == second
        default:
            return false
        }
    }

    public func hash(into hasher: inout Hasher) {
        switch self {
        case .base, .supplementary, .index, .layout, .selectable, .scrollable:
            hasher.combine(String(describing: self))
        case .custom(let id, _):
            hasher.combine("custom")
            hasher.combine(id)
        }
    }
}
