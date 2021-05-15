//
//  AnySupplementaryTarget.h
//  ListController
//
//  Created by Aaron on 2021/5/14.
//

#import <UIKit/UIKit.h>
#import "AnyTarget.h"

#ifndef AnySupplementaryTarget_h
#define AnySupplementaryTarget_h

@protocol AnySupplementaryTarget <AnyTarget>

/// 指定indexPath的header的identifier
@property (nonatomic, copy, nullable) NSString *_Nonnull(^headerIdentifierProviding)(NSIndexPath *_Nonnull);
/// 指定indexPath的footer的identifier
@property (nonatomic, copy, nullable) NSString *_Nonnull(^footerIdentifierProviding)(NSIndexPath *_Nonnull);

/// 配置指定indexPath的header
@property (nonatomic, copy, nullable) void (^headerConfiguring)(NSIndexPath *_Nonnull, UIView *_Nonnull);
/// 配置指定indexPath的header
@property (nonatomic, copy, nullable) void (^footerConfiguring)(NSIndexPath *_Nonnull, UIView *_Nonnull);

/// 默认的cell identifier, 未指定cellIdentifierProviding时尝试使用此项的值
@property (nonatomic, copy, nullable) NSString *defaultHeaderIdentifier;
/// 默认的cell identifier, 未指定cellIdentifierProviding时尝试使用此项的值
@property (nonatomic, copy, nullable) NSString *defaultFooterIdentifier;


@end


#endif /* AnySupplementaryTarget_h */
