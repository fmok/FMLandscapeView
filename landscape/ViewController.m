//
//  ViewController.m
//  landscape
//
//  Created by fm on 2017/6/9.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "ViewController.h"
#import "LandscapeView.h"

@interface ViewController ()

@property (nonatomic, strong) LandscapeView *landscapeView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.landscapeView];
    __weak typeof(self) weakSelf = self;
    [self.landscapeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf.view);
        make.centerY.equalTo(weakSelf.view);
        make.height.mas_equalTo(H_JMAuthorCell+GAP_JMAuthorCell*2);
    }];
    [self.landscapeView updateContent];
}

#pragma mark - getter & setter
- (LandscapeView *)landscapeView
{
    if (!_landscapeView) {
        _landscapeView = [[LandscapeView alloc] initWithFrame:CGRectZero];
    }
    return _landscapeView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
