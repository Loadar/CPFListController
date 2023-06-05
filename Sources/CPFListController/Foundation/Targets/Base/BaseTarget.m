//
//  BaseTarget.m
//  ListController
//
//  Created by Aaron on 2021/5/12.
//

#import "BaseTarget.h"


@implementation BaseTarget

@dynamic cellConfiguring;

// MARK: - Common
- (NSInteger)sectionCount {
    if (self.sectionCountProviding == nil) {
        return 1;
    }
    return self.sectionCountProviding();
}

- (NSInteger)itemCountOfSection:(NSInteger)section {
    if (self.itemListCountProviding == nil) {
        return 0;
    }
    return self.itemListCountProviding(section);
}

- (NSString *)cellIdentifierAt:(NSIndexPath *)indexPath {
    NSString *identifier = @"";
    if (self.cellIdentifierProviding != nil) {
        identifier = self.cellIdentifierProviding(indexPath);
    } else {
        identifier = self.defaultCellIdentifier;
    }
    
    if (identifier == nil || [identifier isEqualToString:@""]) {
        NSAssert(false, @"无效的cell identifier");
    }
    
    return  identifier;
}

- (void)itemDidSelectedAt:(NSIndexPath *)indexPath {
    if (self.itemDidSelected != nil) {
        self.itemDidSelected(indexPath);
    }
}

// MARK: - AnyTarget
- (nonnull NSArray<NSString *> *)supportedSelectors {
    return @[
        NSStringFromSelector(@selector(scrollViewDidScroll:))
    ];
}

// MARK: - ScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.scrolled != nil) {
        self.scrolled(scrollView);
    }
    
    if (self.didEndScrollCompletely != nil && !scrollView.isDragging && !scrollView.isDecelerating) {
        
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [self performSelector:@selector(didStopScrolling:) withObject:scrollView afterDelay:0.3];
    }
}

// 滚动停止
- (void)didStopScrolling:(UIScrollView *)scrollView {
    if (self.didEndScrollCompletely != nil) {
        self.didEndScrollCompletely(scrollView);
    }
}

@end
