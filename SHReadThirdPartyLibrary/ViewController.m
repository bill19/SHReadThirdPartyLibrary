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
#import "UIViewController+HGAnimator.h"
#import "SHAnimatorViewController.h"
@interface ViewController ()<HGTransitionAnimatorDelegate>

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

//    SHMaskView *maskview = [[SHMaskView alloc] init];
//    maskview.vagueImage = [UIImage imageNamed:@"SH_Mask"];
//    maskview.contentViewClick = ^(SHMaskView *view) {
//        NSLog(@"点击了背景");
//    };
//    maskview.backClick = ^(SHMaskView *view) {
//        NSLog(@"点击了返回");
//    };
//    [[UIApplication sharedApplication].keyWindow addSubview:maskview];
}

- (void)buttonClick {
//    [self.navigationController pushViewController:[[KMPViewController alloc] init] animated:YES];
    CGRect leftPresentFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * 0.7,  [UIScreen mainScreen].bounds.size.height);
    CGRect rightPresentFrame = CGRectMake([UIScreen mainScreen].bounds.size.width * 0.3, 0, [UIScreen mainScreen].bounds.size.width * 0.7,  [UIScreen mainScreen].bounds.size.height);
    CGRect topPresentFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height * 0.3);
    CGRect bottomPresentFrame = CGRectMake([UIScreen mainScreen].bounds.size.width * 0.1, [UIScreen mainScreen].bounds.size.height * 0.35, [UIScreen mainScreen].bounds.size.width * 0.8,  [UIScreen mainScreen].bounds.size.height * 0.3);
    UIColor *backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];

    SHAnimatorViewController *animVC = [[SHAnimatorViewController alloc] init];
    [self hg_presentViewController:animVC animateStyle:HGTransitionAnimatorFromBottomStyle delegate:self presentFrame:topPresentFrame    backgroundColor:backgroundColor animated:YES];
}


@end
