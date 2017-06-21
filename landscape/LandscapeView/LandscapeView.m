//
//  landscapeView.m
//  landscape
//
//  Created by fm on 2017/6/9.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "LandscapeView.h"

NSString *const LandscapeCellIdentifier = @"LandscapeCell";

@interface LandscapeView()<
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout>
{
    LandscapeType currentType;
    CGFloat gap_cell;
    CGFloat height_img;
    CGFloat width_img;
}

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong, readwrite) NSMutableArray *mArr;

@end

@implementation LandscapeView

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame type:LandscapeTypeNone];
}

- (instancetype)initWithFrame:(CGRect)frame type:(LandscapeType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        gap_cell = 0;
        height_img = 0;
        width_img = 0;
        currentType = type;
        [self addSubview:self.collectionView];
        [self.collectionView registerClass:[LandscapeCell class] forCellWithReuseIdentifier:LandscapeCellIdentifier];
        [self addSubview:self.topLine];
        [self addSubview:self.bottomLine];
    }
    return self;
}

- (void)updateConstraints
{
    WS(weakSelf);
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    [self.topLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf).offset(gap_cell).priorityHigh(999);
        make.right.equalTo(weakSelf).offset(-gap_cell).priorityHigh(999);
        make.height.mas_equalTo(1.f);
    }];
    [self.bottomLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf);
        make.left.equalTo(weakSelf).offset(gap_cell).priorityHigh(999);
        make.right.equalTo(weakSelf).offset(-gap_cell).priorityHigh(999);
        make.height.mas_equalTo(1.f);
    }];
    [super updateConstraints];
}

#pragma mark - Public methods
- (void)configuration
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(registerCell:identifierStr:)]) {
        [self.delegate registerCell:self.collectionView identifierStr:LandscapeCellIdentifier];
    }
}

- (void)configueImgHeight:(CGFloat)H_img imgWidth:(CGFloat)W_img Gap:(CGFloat)gap
{
    gap_cell = gap;
    height_img = H_img;
    width_img = W_img;
}

- (void)updateContent:(NSArray *)array
{
    self.mArr = [NSMutableArray arrayWithArray:array];
    [self setNeedsUpdateConstraints];
    [self.collectionView reloadData];
}

- (CGFloat)heightForLandscapeView
{
    return height_img + gap_cell*2;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedLandscapeViewAtIndex:)]) {
        [self.delegate didSelectedLandscapeViewAtIndex:indexPath.row];
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(fm_collectionView:numberOfItemsInSection:)]) {
        return [self.dataSource fm_collectionView:collectionView numberOfItemsInSection:section];
    }
    return CGFLOAT_MIN;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(fm_numberOfSectionsInCollectionView:)]) {
        return [self.dataSource fm_numberOfSectionsInCollectionView:collectionView];
    }
    return CGFLOAT_MIN;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(fm_collectionView:cellForItemAtIndexPath:identifierStr:)]) {
        return [self.dataSource fm_collectionView:collectionView cellForItemAtIndexPath:indexPath identifierStr:LandscapeCellIdentifier];
    }
    return nil;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(fm_collectionView:layout:sizeForItemAtIndexPath:)]) {
        return [self.delegate fm_collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
    }
    return CGSizeZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(fm_collectionView:layout:minimumLineSpacingForSectionAtIndex:)]) {
        return [self.delegate fm_collectionView:collectionView layout:collectionViewLayout minimumLineSpacingForSectionAtIndex:section];
    }
    return CGFLOAT_MIN;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(fm_collectionView:layout:insetForSectionAtIndex:)]) {
        return [self.delegate fm_collectionView:collectionView layout:collectionViewLayout insetForSectionAtIndex:section];
    }
    return UIEdgeInsetsZero;
}

#pragma mark - UIScrollViewDelegate
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
                targetLeft = CGPointMake(originalTargetContentOffset.x + gap_cell*i, CGRectGetHeight(self.collectionView.bounds) / 2);
                indexPath = [self.collectionView indexPathForItemAtPoint:targetLeft];
                i++;
            }
            //这里用attributes比用cell要好很多，因为cell可能因为不在屏幕范围内导致cellForItemAtIndexPath返回nil
            UICollectionViewLayoutAttributes *attributes = [self.collectionView.collectionViewLayout layoutAttributesForItemAtIndexPath:indexPath];
            if (attributes) {
                if (scrollView.contentOffset.x + scrollView.frame.size.width >= scrollView.contentSize.width) {
                    
                } else {
                    *targetContentOffset = CGPointMake(attributes.frame.origin.x-gap_cell, originalTargetContentOffset.y);
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
                 targetCenter = CGPointMake(originalTargetContentOffset.x + CGRectGetWidth(self.collectionView.bounds)/2 + gap_cell*i, CGRectGetHeight(self.collectionView.bounds) / 2);
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
            
        case LandscapeTypeNone:
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

- (UIView *)topLine
{
    if (!_topLine) {
        _topLine = [[UIView alloc] initWithFrame:CGRectZero];
        _topLine.backgroundColor = [UIColor colorWithRed:0.859f green:0.859f blue:0.859f alpha:1.00f];
    }
    return _topLine;
}

- (UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomLine.backgroundColor = [UIColor colorWithRed:0.859f green:0.859f blue:0.859f alpha:1.00f];
    }
    return _bottomLine;
}

- (NSMutableArray *)mArr
{
    if (!_mArr) {
        _mArr = [[NSMutableArray alloc] init];
    }
    return _mArr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
