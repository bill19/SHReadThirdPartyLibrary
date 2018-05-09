//
//  SHMaskView.m
//  SHReadThirdPartyLibrary
//
//  Created by HaoSun on 2018/5/9.
//  Copyright © 2018年 SHKIT. All rights reserved.
//

#import "SHMaskView.h"
#import "UIImage+Vague.h"
@interface SHMaskView ()

/**
 顶部 NAV
 */
@property (nonatomic, weak) UIView *navView;

/**
  返回按钮
 */
@property (nonatomic, weak) UIButton *backButton;

/**
 内容部分
 */
@property (nonatomic, weak) UIView *contentView;

@end

@implementation SHMaskView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupSubViews];
    }
    return self;
}


- (void)setupSubViews {

    self.frame = [UIApplication sharedApplication].keyWindow.bounds;
    self.userInteractionEnabled = YES;
    
    CGFloat maskWidth  = [UIScreen mainScreen].bounds.size.width;
    CGFloat maskHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat navHeight  = NAV_H();
    UIView *navView = [[UIView alloc] init];
    navView.frame = CGRectMake(0, 0, maskWidth, navHeight);
    navView.userInteractionEnabled = YES;
    _navView = navView;
    [self addSubview:_navView];

    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, navHeight, navHeight);
    [backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    backButton.userInteractionEnabled = YES;
    _backButton = backButton;
    [_navView addSubview:_backButton];

    UIView *contentView = [[UIView alloc] init];
    contentView.frame = CGRectMake(0, navHeight, maskWidth, maskHeight - navHeight);
    [contentView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewContentView)]];
    contentView.userInteractionEnabled = YES;
    _contentView = contentView;
    [self addSubview:_contentView];
}

- (void)backButtonAction:(UIButton *)sender {
    if (self.backClick) {
        self.backClick(self);
    }
}

- (void)contentViewContentView {
    if (self.contentViewClick) {
        self.contentViewClick(self);
    }
}

/**
 移除MaskView
 */
- (void)removeMaskView {
    [self removeFromSuperview];

}

#pragma mark - 属性设置
- (void)setContentBackgroundColor:(UIColor *)contentBackgroundColor {
    _contentBackgroundColor = contentBackgroundColor;
    _contentView.backgroundColor = _contentBackgroundColor;
}

- (void)setNavBackgroundColor:(UIColor *)navBackgroundColor {
    _navBackgroundColor = navBackgroundColor;
    _navView.backgroundColor = _navBackgroundColor;
}

- (void)setVagueImage:(UIImage *)vagueImage {
    _vagueImage = vagueImage;
    self.image = _vagueImage;
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    toolbar.barStyle = UIBarStyleBlackTranslucent;
    [self addSubview:toolbar];
}

#pragma mark - 计算nav的高度
NS_INLINE CGFloat NAV_H() {
    CGFloat navBarHeight = 0.0f;
    if ([[UIApplication sharedApplication].keyWindow.rootViewController isKindOfClass:[UINavigationController class]]) {
        navBarHeight = ((UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController).navigationBar.bounds.size.height;
    }else if ([[UIApplication sharedApplication].keyWindow.rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        if ([tabBarController.viewControllers.firstObject isKindOfClass:[UINavigationController class]]) {
            navBarHeight = ((UINavigationController *)tabBarController.viewControllers.firstObject).navigationBar.bounds.size.height;
        }else{
            navBarHeight = ((UIViewController *)tabBarController.viewControllers.firstObject).navigationController.navigationBar.bounds.size.height;
        }
    }else{
        navBarHeight = [UIApplication sharedApplication].keyWindow.rootViewController.navigationController.navigationBar.frame.size.height;
    }
    return navBarHeight + [UIApplication sharedApplication].statusBarFrame.size.height;
}
@end
