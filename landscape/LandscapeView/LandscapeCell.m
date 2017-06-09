//
//  JMAuthorCell.m
//  landscape
//
//  Created by fm on 2017/6/9.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "LandscapeCell.h"

@interface LandscapeCell()

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation LandscapeCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.f green:arc4random_uniform(255)/255.f blue:arc4random_uniform(255)/255.f alpha:1];
        self.layer.cornerRadius = 5.f;
        self.layer.masksToBounds = YES;
        self.selectedBackgroundView = nil;
        [self addSubview:self.textLabel];
    }
    return self;
}

- (void)updateConstraints
{
    __weak typeof(self) weakSelf = self;
    [self.textLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    [super updateConstraints];
}

#pragma makr - Public methods
- (void)updateContent:(NSString *)title
{
    self.textLabel.text = title;
    [self setNeedsUpdateConstraints];
}

#pragma mark - getter & setter
- (UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _textLabel.font = [UIFont systemFontOfSize:20.f];
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _textLabel;
}

@end
