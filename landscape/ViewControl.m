//
//  ViewControl.m
//  landscape
//
//  Created by fm on 2017/6/21.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "ViewControl.h"

@implementation ViewControl

#pragma mark - LandscapeViewDelegate
- (void)registerCell:(UICollectionView *)collectionView identifierStr:(NSString *)identifierStr
{
    [collectionView registerClass:[LandscapeCell class] forCellWithReuseIdentifier:identifierStr];
}

- (void)didSelectedLandscapeViewAtIndex:(NSInteger)index
{
    NSLog(@"\n*** did selected index:%@ ***\n", @(index));
}

- (CGSize)fm_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(H_JMAuthorCell*2, H_JMAuthorCell);
}

- (CGFloat)fm_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return GAP_JMAuthorCell;
}

- (UIEdgeInsets)fm_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(GAP_JMAuthorCell, GAP_JMAuthorCell, GAP_JMAuthorCell, GAP_JMAuthorCell);
}

#pragma mark - LandscapeViewDataSource
- (NSInteger)fm_collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.vc.landscapeView.mArr.count;
}

- (NSInteger)fm_numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)fm_collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath identifierStr:(NSString *)identifierStr
{
    LandscapeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifierStr forIndexPath:indexPath];
    NSString *imageUrl = self.vc.landscapeView.mArr[indexPath.row];
    [cell updateContent:imageUrl];
    return cell;
}

@end
