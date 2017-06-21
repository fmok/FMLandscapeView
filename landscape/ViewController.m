//
//  ViewController.m
//  landscape
//
//  Created by fm on 2017/6/9.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "ViewController.h"
#import "ViewControl.h"

@interface ViewController ()

@property (nonatomic, strong) ViewControl *control;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self configueUI];
    NSArray *arr = @[@"http://mpic.tiankong.com/0ad/a4b/0ada4b7da206d617c3d06bd30863462f/640.jpg@360h",
                     @"http://mpic.tiankong.com/0f8/21d/0f821d5dd49ee1987557409fa8a40a68/640.jpg@360h",
                     @"http://mpic.tiankong.com/a1f/263/a1f263359009eb1492d6d1d0e717909c/640.jpg@360h",
                     @"http://mpic.tiankong.com/03c/0ac/03c0ac8102e5c9a544f1cf3f4d639148/1-1867.jpg@360h",
                     @"http://mpic.tiankong.com/136/0cf/1360cf50c5b41fba4d45cb374e093388/640.jpg@360h",
                     @"http://mpic.tiankong.com/b7e/64c/b7e64cae8b10a7c4c82c0025a27e026f/640.jpg@360h",
                     @"http://mpic.tiankong.com/1a3/732/1a373214cda28e170a1d32d857d5c85d/640.jpg@360h",
                     @"http://mpic.tiankong.com/a15/686/a156863b69a59539329a1e4dc2ee8da3/640.jpg@360h",
                     @"http://mpic.tiankong.com/a03/8f0/a038f094eb4e901ec7c8fbaf4a997269/640.jpg@360h",
                     @"http://mpic.tiankong.com/7ee/a45/7eea45682b692a3e1b3183d03949dfd0/designrf1832124.jpg@360h"
                     ];
    [self.landscapeView updateContent:arr];
}

#pragma mark - Private methods
- (void)configueUI
{
    [self.view addSubview:self.landscapeView];
    WS(weakSelf);
    [self.landscapeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf.view);
        make.centerY.equalTo(weakSelf.view);
        make.height.mas_equalTo(H_JMAuthorCell+GAP_JMAuthorCell*2);
    }];
}

#pragma mark - getter & setter
- (ViewControl *)control
{
    if (!_control) {
        _control = [[ViewControl alloc] init];
        _control.vc = self;
    }
    return _control;
}

- (LandscapeView *)landscapeView
{
    if (!_landscapeView) {
        _landscapeView = [[LandscapeView alloc] initWithFrame:CGRectZero type:LandscapeTypeCenter];
        _landscapeView.delegate = self.control;
        _landscapeView.dataSource = self.control;
        [_landscapeView configuration];
        [_landscapeView configueImgHeight:H_JMAuthorCell imgWidth:H_JMAuthorCell*2 Gap:GAP_JMAuthorCell];
    }
    return _landscapeView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
