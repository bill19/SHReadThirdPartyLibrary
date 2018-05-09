//
//  KMPViewController.m
//  SHReadThirdPartyLibrary
//
//  Created by HaoSun on 2018/4/26.
//  Copyright © 2018年 SHKIT. All rights reserved.
//

#import "KMPViewController.h"

@interface KMPViewController ()

@end

@implementation KMPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    char sourceStr[] = "abaaabaabccacbab";
    char subStr[] = "cc";
    int next[(int)strlen(subStr)];

    getNext(subStr, next);
    int index = index_KMP(sourceStr, subStr, next);
    printf("index = %d", index);
}
void getNext(char subStr[], int *next){
    int i=0;
    int j=-1;
    next[0]=-1;
    while(i<strlen(subStr)){
        if(j==-1||subStr[i]==subStr[j]){
            i++;
            j++;
            next[i] = j;
        } else {
            j=next[j];
        }
    }
    next[0] = 0;
}

int index_KMP(char sourceStr[], char subStr[], int next[]){
    int i = 0;
    int j = 0;
    while(i < strlen(sourceStr) && j < strlen(subStr)) {
        if(j == 0 || sourceStr[i] == subStr[j]){
            i++;
            j++;
        } else {
            j=next[j];
        }
    }
    if (j == strlen(subStr)) {
        return i - (int)strlen(subStr);
    } else {

        return -1;
    }
}
@end
