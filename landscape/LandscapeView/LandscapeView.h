//
//  landscapeView.h
//  landscape
//
//  Created by fm on 2017/6/9.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LandscapeCell.h"

@interface LandscapeView : UIView

// 此方法，以及每个item内部样式需要使用者自定制
- (void)updateContent;

@end
