//
//  landscapeView.m
//  landscape
//
//  Created by fm on 2017/6/9.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "LandscapeView.h"

NSString *const LandscapeCellIdentifier = @"LandscapeCell";
NSInteger const authorCount = 4;

@interface LandscapeView()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
//    NSInteger leftIndex;  // 最左边的序号
}
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation LandscapeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.collectionView];
        [self.collectionView registerClass:[LandscapeCell class] forCellWithReuseIdentifier:LandscapeCellIdentifier];
//        leftIndex = 0;
    }
    return self;
}

- (void)updateConstraints
{
    __weak typeof(self) weakSelf = self;
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    [super updateConstraints];
}

#pragma mark - Public methods
- (void)updateContent
{
    [self setNeedsUpdateConstraints];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"\n****** did select item %@ ******\n", @(indexPath.row));
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return authorCount;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LandscapeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LandscapeCellIdentifier forIndexPath:indexPath];
    [cell updateContent:[NSString stringWithFormat:@"*** %@ ***", @(indexPath.row)]];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(H_JMAuthorCell*2, H_JMAuthorCell);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return GAP_JMAuthorCell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(GAP_JMAuthorCell, GAP_JMAuthorCell, GAP_JMAuthorCell, GAP_JMAuthorCell);
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGPoint originalTargetContentOffset = CGPointMake(targetContentOffset->x, targetContentOffset->y);
    CGPoint targetCenter = CGPointMake(originalTargetContentOffset.x + CGRectGetWidth(self.collectionView.bounds)/2, CGRectGetHeight(self.collectionView.bounds) / 2);
    NSIndexPath *indexPath = nil;
    NSInteger i = 0;
    while (indexPath == nil) {
        targetCenter = CGPointMake(originalTargetContentOffset.x + CGRectGetWidth(self.collectionView.bounds)/2 + 10*i, CGRectGetHeight(self.collectionView.bounds) / 2);
        indexPath = [self.collectionView indexPathForItemAtPoint:targetCenter];
        i++;
    }
    //这里用attributes比用cell要好很多，因为cell可能因为不在屏幕范围内导致cellForItemAtIndexPath返回nil
    UICollectionViewLayoutAttributes *attributes = [self.collectionView.collectionViewLayout layoutAttributesForItemAtIndexPath:indexPath];
    if (attributes) {
        *targetContentOffset = CGPointMake(attributes.center.x - CGRectGetWidth(self.collectionView.bounds)/2, originalTargetContentOffset.y);
    } else {
        NSLog(@"center is %@; indexPath is {%@, %@}; cell is %@",NSStringFromCGPoint(targetCenter), @(indexPath.section), @(indexPath.item), attributes);
    }
}

//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
//{
//    CGFloat velocity_X = velocity.x;
//    NSLog(@"\n^^^ velocity.x: %@ ^^^\n", @(velocity_X));
//    
//    CGFloat x = targetContentOffset->x;
//    CGFloat pageWidth = (H_JMAuthorCell*2 + GAP_JMAuthorCell);
//
//    CGFloat movedX = x - pageWidth * (CGFloat)leftIndex;
//    
//    if (movedX < -pageWidth *0.5) {
//        // Move left
//        
//        CGFloat v_left = (fabs(velocity_X) > 0.4 ? fabs(round(velocity_X)) : 1);
//        if (v_left > 3) {
//            v_left = 2;
//        }
//        leftIndex -= v_left;
//        if (leftIndex <= 0) {
//            leftIndex = 0;
//        }
//    } else if (movedX > pageWidth * 0.5) {
//        // Move right
//        CGFloat v_right = fabs(round(velocity_X));
//        if (v_right > 3) {
//            v_right = 2;
//        }
//        leftIndex += (fabs(velocity_X) > 0.4 ? v_right : 1);
////        if (leftIndex >= authorCount) {
////            leftIndex = authorCount - 1;
////        }
//    }
//    
//    if (fabs(velocity_X) >= 2) {
//        NSLog(@"\n***  >=2 leftIndex: %@ ***\n", @(leftIndex));
//        targetContentOffset->x = pageWidth * (CGFloat)leftIndex;
//    } else {
//        NSLog(@"\n*** <2 leftIndex: %@ ***\n", @(leftIndex));
//        targetContentOffset->x = scrollView.contentOffset.x;
//        [scrollView setContentOffset:CGPointMake(pageWidth * (CGFloat)leftIndex, scrollView.contentOffset.y) animated:YES];
//    }
//}

#pragma mark - getter & setter
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
//        _collectionView.decelerationRate = 20;
    }
    return _collectionView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
