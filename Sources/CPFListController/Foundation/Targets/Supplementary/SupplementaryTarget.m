//
//  SupplementaryTarget.m
//  ListController
//
//  Created by Aaron on 2021/5/14.
//

#import "SupplementaryTarget.h"

@implementation SupplementaryTarget

@dynamic headerConfiguring;
@dynamic footerConfiguring;

- (NSString *)headerIdentifierAt:(NSIndexPath *)indexPath {
    NSString *identifier = @"";
    if (self.headerIdentifierProviding != nil) {
        identifier = self.headerIdentifierProviding(indexPath);
    } else {
        identifier = self.defaultHeaderIdentifier;
    }
    if (identifier == nil || [identifier isEqualToString:@""]) {
        NSAssert(false, @"无效的cell identifier");
    }
    return  identifier;
}

- (NSString *)footerIdentifierAt:(NSIndexPath *)indexPath {
    NSString *identifier = @"";
    if (self.footerIdentifierProviding != nil) {
        identifier = self.footerIdentifierProviding(indexPath);
    } else {
        identifier = self.defaultFooterIdentifier;
    }
    if (identifier == nil || [identifier isEqualToString:@""]) {
        NSAssert(false, @"无效的cell identifier");
    }
    return  identifier;
}

// MARK: - AnyTarget
- (nonnull NSArray<NSString *> *)supportedSelectors {
    NSAssert(false, @"子类指定支持的selectors");
    return @[];
}

@end
