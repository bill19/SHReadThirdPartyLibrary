//
//  ViewController.m
//  SHReadThirdPartyLibrary
//
//  Created by HaoSun on 2018/3/6.
//  Copyright © 2018年 SHKIT. All rights reserved.
//

#import "ViewController.h"
#import "SHEchartsViewController.h"
#import "KMPViewController.h"
#import "SHMaskView.h"
#import "UIImage+Vague.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"66666";
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor greenColor];
    button.frame = CGRectMake(100, 100, 100, 100);
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    SHMaskView *maskview = [[SHMaskView alloc] init];
    maskview.vagueImage = [UIImage imageNamed:@"SH_Mask"];
    maskview.contentViewClick = ^(SHMaskView *view) {
        NSLog(@"点击了背景");
    };
    maskview.backClick = ^(SHMaskView *view) {
        NSLog(@"点击了返回");
    };
    [[UIApplication sharedApplication].keyWindow addSubview:maskview];
}

- (void)buttonClick {
    [self.navigationController pushViewController:[[KMPViewController alloc] init] animated:YES];
}


@end
