//
//  CollectionSupplementaryTarget.m
//  ListModelTest
//
//  Created by Aaron on 2021/5/14.
//

#import "CollectionSupplementaryTarget.h"

@implementation CollectionSupplementaryTarget

@synthesize headerConfiguring;
@synthesize footerConfiguring;

// MARK: - AnyTarget
- (nonnull NSArray<NSString *> *)supportedSelectors {
    return @[
        NSStringFromSelector(@selector(collectionView:viewForSupplementaryElementOfKind:atIndexPath:))
    ];
}

// MARK: - UICollectionView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        NSString *identifier = [self headerIdentifierAt:indexPath];
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
        if (self.headerConfiguring != nil) {
            self.headerConfiguring(indexPath, header);
        }
        return header;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        NSString *identifier = [self footerIdentifierAt:indexPath];
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
        if (self.footerConfiguring != nil) {
            self.footerConfiguring(indexPath, footer);
        }
        return footer;
    } else {
        NSAssert(false, @"不是Header也不是Footer?");
        return nil;
    }
}

@end
