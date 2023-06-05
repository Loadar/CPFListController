//
//  SupplementaryTarget.h
//  ListController
//
//  Created by Aaron on 2021/5/14.
//

#import <UIKit/UIKit.h>
#import "AnySupplementaryTarget.h"

NS_ASSUME_NONNULL_BEGIN

@interface SupplementaryTarget : NSObject<AnySupplementaryTarget>

@property (nonatomic, copy, nullable) NSString *_Nonnull(^headerIdentifierProviding)(NSIndexPath *_Nonnull);
/// 指定indexPath的footer的identifier
@property (nonatomic, copy, nullable) NSString *_Nonnull(^footerIdentifierProviding)(NSIndexPath *_Nonnull);

/// 默认的cell identifier, 未指定cellIdentifierProviding时尝试使用此项的值
@property (nonatomic, copy, nullable) NSString *defaultHeaderIdentifier;
/// 默认的cell identifier, 未指定cellIdentifierProviding时尝试使用此项的值
@property (nonatomic, copy, nullable) NSString *defaultFooterIdentifier;


- (NSString *)headerIdentifierAt:(NSIndexPath *)indexPath;
- (NSString *)footerIdentifierAt:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
