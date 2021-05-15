//
//  CollectionSelectableTarget.m
//  ListController
//
//  Created by Aaron on 2021/5/14.
//

#import "CollectionSelectableTarget.h"

@implementation CollectionSelectableTarget

// MARK: - AnyTarget
- (nonnull NSArray<NSString *> *)supportedSelectors {
    return @[
        NSStringFromSelector(@selector(collectionView:shouldHighlightItemAtIndexPath:)),
        NSStringFromSelector(@selector(collectionView:didHighlightItemAtIndexPath:)),
        NSStringFromSelector(@selector(collectionView:didUnhighlightItemAtIndexPath:)),
        NSStringFromSelector(@selector(collectionView:shouldSelectItemAtIndexPath:)),
        NSStringFromSelector(@selector(collectionView:shouldDeselectItemAtIndexPath:)),
        NSStringFromSelector(@selector(collectionView:didDeselectItemAtIndexPath:))
    ];
}

// MARK: - UICollectionView
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self itemShouldHighlightAt:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    [self itemDidHighlightAt:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    [self itemDidUnhighlightAt:indexPath];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self itemShouldSelecttAt:indexPath];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self itemShouldDeselecttAt:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self itemDidDeselectedAt:indexPath];
}


@end
