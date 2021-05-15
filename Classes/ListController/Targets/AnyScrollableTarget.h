//
//  AnyScrollableTarget.h
//  ListController
//
//  Created by Aaron on 2021/5/15.
//

#import <UIKit/UIKit.h>
#import "AnyTarget.h"

#ifndef AnyScrollableTarget_h
#define AnyScrollableTarget_h

@protocol AnyScrollableTarget<AnyTarget>

/// 将要开始减速
@property (nonatomic, copy, nullable) void (^willBeginDecelerating)(UIScrollView *_Nonnull);
/// 已结束减速
@property (nonatomic, copy, nullable) void (^didEndDecelerating)(UIScrollView *_Nonnull);

/// 将要开始拖动
@property (nonatomic, copy, nullable) void (^willBeginDragging)(UIScrollView *_Nonnull);
/// 将要结束拖动
@property (nonatomic, copy, nullable) void (^willEndDragging)(UIScrollView *_Nonnull, CGPoint, CGPoint *_Nullable);
/// 已结束拖动
@property (nonatomic, copy, nullable) void (^didEndDragging)(UIScrollView *_Nonnull, BOOL);

/// 滚动动画结束
@property (nonatomic, copy, nullable) void (^didEndScrollingAnimation)(UIScrollView *_Nonnull);

/// 是否可滚动到顶部
@property (nonatomic, copy, nullable) BOOL (^shouldScrollToTop)(UIScrollView *_Nonnull);
/// 已滚动到顶部
@property (nonatomic, copy, nullable) void (^didScrollToTop)(UIScrollView *_Nonnull);

/// 缩放系数变化
@property (nonatomic, copy, nullable) void (^didZoom)(UIScrollView *_Nonnull);
/// 指定缩放的view
@property (nonatomic, copy, nullable) UIView *_Nullable (^viewForZooming)(UIScrollView *_Nonnull);
/// 将要开始缩放
@property (nonatomic, copy, nullable) void (^willBeginZooming)(UIScrollView *_Nonnull, UIView *_Nullable);
/// 已结束缩放
@property (nonatomic, copy, nullable) void (^didEndZooming)(UIScrollView *_Nonnull, UIView *_Nullable, CGFloat);

///// adjusted content insets改变
//@property (nonatomic, copy, nullable) void (^adjustedContentInsetChanged)(UIScrollView *_Nonnull) API_AVAILABLE(ios(11.0), tvos(11.0));

@end

#endif /* AnyScrollableTarget_h */
