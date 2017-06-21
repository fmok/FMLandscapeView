//
//  landscapeView.h
//  landscape
//
//  Created by fm on 2017/6/9.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LandscapeCell.h"

typedef NS_ENUM(NSInteger, LandscapeType) {
    LandscapeTypeNone,      // 无，default
    LandscapeTypeLeft,      // 停靠在左边
    LandscapeTypeCenter     // 停靠在中央
};

@protocol LandscapeViewDelegate <NSObject>

@required
- (void)registerCell:(UICollectionView *)collectionView identifierStr:(NSString *)identifierStr;
- (CGSize)fm_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)fm_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
- (UIEdgeInsets)fm_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;

@optional
- (void)didSelectedLandscapeViewAtIndex:(NSInteger)index;

@end

@protocol LandscapeViewDataSource <NSObject>

@required
- (NSInteger)fm_collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
- (NSInteger)fm_numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
- (UICollectionViewCell *)fm_collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath identifierStr:(NSString *)identifierStr;

@end

@interface LandscapeView : UIView

@property (nonatomic, weak) id<LandscapeViewDelegate>delegate;
@property (nonatomic, weak) id<LandscapeViewDataSource>dataSource;
@property (nonatomic, strong, readonly) NSMutableArray *mArr;

- (void)configuration;
- (instancetype)initWithFrame:(CGRect)frame type:(LandscapeType)type;
- (void)configueImgHeight:(CGFloat)H_img imgWidth:(CGFloat)W_img Gap:(CGFloat)gap;
- (void)updateContent:(NSArray *)array;
- (CGFloat)heightForLandscapeView;

@end
