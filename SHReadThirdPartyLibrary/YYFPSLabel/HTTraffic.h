//
//  HTTraffic.h
//  YYFPSLabel
//
//  Created by HaoSun on 2018/5/3.
//  Copyright © 2018年 yehot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HTTraffic : NSObject
/**
 WiFi发送流量
 */
@property (nonatomic, copy) NSString *wiFiSent;
/**
 WiFi接收流量
 */
@property (nonatomic, copy) NSString *wiFiReceived;

/**
 移动网络+WIFI网络综合发出
 */
@property (nonatomic, copy) NSString *send;
/**
 移动网络+WIFI网络综合接受
 */
@property (nonatomic, copy) NSString *received;

/**
移动网络发送流量
 */
@property (nonatomic, copy) NSString *wWANSent;
/**
移动网络接收流量
 */
@property (nonatomic, copy) NSString *wWANReceived;

/**
 当前发出
 */
@property (nonatomic, copy) NSString *nowSend;

/**
 当前接受
 */
@property (nonatomic, copy) NSString *nowReceived;

@property (nonatomic, assign) int lastTimeDate;
+ (NSDictionary *)getTrafficMonitorings;

@end
