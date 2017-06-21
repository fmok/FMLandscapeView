//
//  JMAuthorCell.m
//  landscape
//
//  Created by fm on 2017/6/9.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "LandscapeCell.h"
#import "UIImageView+WebCache.h"

@interface LandscapeCell()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation LandscapeCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.f green:arc4random_uniform(255)/255.f blue:arc4random_uniform(255)/255.f alpha:1];
        self.layer.cornerRadius = 10.f;
        self.layer.masksToBounds = YES;
        self.selectedBackgroundView = nil;
        [self addSubview:self.imgView];
    }
    return self;
}

- (void)updateConstraints
{
    WS(weakSelf);
    [self.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    [super updateConstraints];
}

#pragma makr - Public methods
- (void)updateContent:(NSString *)imgUrl
{
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRetryFailed];
    [self setNeedsUpdateConstraints];
}

#pragma mark - getter & setter
- (UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imgView;
}

@end
