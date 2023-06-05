//
//  SelectableTarget.m
//  ListController
//
//  Created by Aaron on 2021/5/13.
//

#import "SelectableTarget.h"

@implementation SelectableTarget

// MARK: - Common
- (BOOL)itemShouldHighlightAt:(NSIndexPath *)indexPath {
    return self.itemShouldHighlight != nil ? self.itemShouldHighlight(indexPath) : true;
}

- (void)itemDidHighlightAt:(NSIndexPath *)indexPath {
    if (self.itemDidHighlight != nil) {
        self.itemDidHighlight(indexPath);
    }
}

- (void)itemDidUnhighlightAt:(NSIndexPath *)indexPath {
    if (self.itemDidUnhighlight != nil) {
        self.itemDidUnhighlight(indexPath);
    }
}

- (BOOL)itemShouldSelecttAt:(NSIndexPath *)indexPath {
    return self.itemShouldSelect != nil ? self.itemShouldSelect(indexPath) : true;
}

- (BOOL)itemShouldDeselecttAt:(NSIndexPath *)indexPath {
    return self.itemShouldDeselect != nil ? self.itemShouldDeselect(indexPath) : true;
}

- (void)itemDidDeselectedAt:(NSIndexPath *)indexPath {
    if (self.itemDidDeselected != nil) {
        self.itemDidDeselected(indexPath);
    }
}

// MARK: - AnyTarget
- (nonnull NSArray<NSString *> *)supportedSelectors {
    NSAssert(false, @"子类指定支持的selectors");
    return @[];
}

@end
