//
//  landscapeView.m
//  landscape
//
//  Created by fm on 2017/6/9.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "LandscapeView.h"

NSString *const LandscapeCellIdentifier = @"LandscapeCell";
NSInteger const authorCount = 10;

@interface LandscapeView()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    LandscapeType currentType;
}
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation LandscapeView

- (instancetype)initWithFrame:(CGRect)frame type:(LandscapeType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        currentType = type;
        [self addSubview:self.collectionView];
        [self.collectionView registerClass:[LandscapeCell class] forCellWithReuseIdentifier:LandscapeCellIdentifier];
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
    switch (currentType) {
        case LandscapeTypeLeft:
        {
            CGPoint targetLeft = CGPointMake(originalTargetContentOffset.x, CGRectGetHeight(self.collectionView.bounds) / 2);
            NSIndexPath *indexPath = nil;
            NSInteger i = 0;
            while (indexPath == nil) {
                targetLeft = CGPointMake(originalTargetContentOffset.x + 10*i, CGRectGetHeight(self.collectionView.bounds) / 2);
                indexPath = [self.collectionView indexPathForItemAtPoint:targetLeft];
                i++;
            }
            //这里用attributes比用cell要好很多，因为cell可能因为不在屏幕范围内导致cellForItemAtIndexPath返回nil
            UICollectionViewLayoutAttributes *attributes = [self.collectionView.collectionViewLayout layoutAttributesForItemAtIndexPath:indexPath];
            if (attributes) {
                if (scrollView.contentOffset.x + scrollView.frame.size.width >= scrollView.contentSize.width) {
                    
                } else {
                    *targetContentOffset = CGPointMake(attributes.frame.origin.x-GAP_JMAuthorCell, originalTargetContentOffset.y);
                }
            } else {
                NSLog(@"left is %@; indexPath is {%@, %@}; cell is %@",NSStringFromCGPoint(targetLeft), @(indexPath.section), @(indexPath.item), attributes);
            }
        }
            break;
        
        case LandscapeTypeCenter:
        {
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
            break;
            
        default:
            break;
    }
    
    
}

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
