//
//  BaseTarget.h
//  ListModelTest
//
//  Created by Aaron on 2021/5/12.
//

#import <UIKit/UIKit.h>
#import "AnyBaseTarget.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseTarget : NSObject<AnyBaseTarget>

/// 分段数目
@property (nonatomic, copy, nullable) NSInteger (^sectionCountProviding)(void);
/// 指定分段列表项数目
@property (nonatomic, copy, nullable) NSInteger (^itemListCountProviding)(NSInteger);
/// 指定indexPath的cell的identifier
@property (nonatomic, copy, nullable) NSString *_Nonnull(^cellIdentifierProviding)(NSIndexPath *_Nonnull);

/// 默认的cell identifier, 未指定cellIdentifierProviding时尝试使用此项的值
@property (nonatomic, copy, nullable) NSString *defaultCellIdentifier;

/// 列表项已选中
@property (nonatomic, copy, nullable) void (^itemDidSelected)(NSIndexPath *_Nonnull);

/// 列表滚动
@property (nonatomic, copy, nullable) void(^scrolled)(UIScrollView *_Nonnull);

- (NSInteger)sectionCount;
- (NSInteger)itemCountOfSection:(NSInteger)section;
- (nonnull NSString *)cellIdentifierAt:(NSIndexPath *_Nonnull)indexPath;

- (void)itemDidSelectedAt:(NSIndexPath *_Nonnull)indexPath;


@end

NS_ASSUME_NONNULL_END
