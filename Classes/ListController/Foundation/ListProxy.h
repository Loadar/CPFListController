//
//  ListProxy.h
//  ListModelTest
//
//  Created by Aaron on 2021/5/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListProxy : NSProxy<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy, readonly) NSArray<id> *targets;

- (instancetype)initWithTargets:(NSArray<id> *)targets;

@end

NS_ASSUME_NONNULL_END
