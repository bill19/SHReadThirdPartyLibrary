//
//  SHMaskView.h
//  SHReadThirdPartyLibrary
//
//  Created by HaoSun on 2018/5/9.
//  Copyright © 2018年 SHKIT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SHMaskView;

typedef void(^backBtnClick)(SHMaskView *view);

typedef void(^contentViewBtnClick)(SHMaskView *view);

@interface SHMaskView : UIImageView

/**
 点击左上角的按钮
 */
@property (nonatomic, copy) backBtnClick backClick;

/**
 点击背景
 */
@property (nonatomic, copy) contentViewBtnClick contentViewClick;

/**
 移除MaskView
 */
- (void)removeMaskView;

/**
 顶部的颜色
 */
@property (nonatomic, strong) UIColor *navBackgroundColor;

/**
 背景颜色
 */
@property (nonatomic, strong) UIColor *contentBackgroundColor;
/**
 高斯模糊的图片
 */
@property (nonatomic, strong) UIImage *vagueImage;

@end
