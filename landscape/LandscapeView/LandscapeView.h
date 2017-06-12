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
    LandscapeTypeLeft,      // 停靠在左边
    LandscapeTypeCenter     // 停靠在中央
};

@interface LandscapeView : UIView

- (instancetype)initWithFrame:(CGRect)frame type:(LandscapeType)type;
- (void)updateContent;

@end
