//
//  SHAnimatorViewController.m
//  SHReadThirdPartyLibrary
//
//  Created by HaoSun on 2018/5/21.
//  Copyright © 2018年 SHKIT. All rights reserved.
//

#import "SHAnimatorViewController.h"

@interface SHAnimatorViewController ()

@end

@implementation SHAnimatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(100, 100, 100, 100);
    label.text = @" Dispose of any resources that can be recreated.";
    label.backgroundColor = [UIColor redColor];
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
