//
//  ViewControl.h
//  landscape
//
//  Created by fm on 2017/6/21.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"

@interface ViewControl : NSObject<
    LandscapeViewDelegate,
    LandscapeViewDataSource>

@property (nonatomic, weak) ViewController *vc;

@end
