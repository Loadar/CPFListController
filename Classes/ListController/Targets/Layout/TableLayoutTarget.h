//
//  TableLayoutTarget.h
//  ListModelTest
//
//  Created by Aaron on 2021/5/14.
//

#import <UIKit/UIKit.h>
#import "AnyLayoutTarget.h"

NS_ASSUME_NONNULL_BEGIN

@interface TableLayoutTarget : NSObject<AnyLayoutTarget>

/// 行高
@property (nonatomic, copy, nullable) CGFloat (^rowHeightProviding)(NSIndexPath *_Nonnull);
/// header高
@property (nonatomic, copy, nullable) CGFloat (^headerHeightProviding)(NSInteger);
/// footer高
@property (nonatomic, copy, nullable) CGFloat (^footerHeightProviding)(NSInteger);

@end

NS_ASSUME_NONNULL_END
