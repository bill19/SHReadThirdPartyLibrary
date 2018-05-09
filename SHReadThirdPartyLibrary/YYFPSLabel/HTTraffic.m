//
//  HTTraffic.m
//  YYFPSLabel
//
//  Created by HaoSun on 2018/5/3.
//  Copyright © 2018年 yehot. All rights reserved.
//

#import "HTTraffic.h"
#include <arpa/inet.h>
#include <net/if.h>
#include <ifaddrs.h>
#include <net/if_dl.h>
#import <sys/sysctl.h>
#import <mach/mach.h>

@implementation HTTraffic

/**
 *  WiFiSent WiFi发送流量
 *  WiFiReceived WiFi接收流量
 *  WWANSent 移动网络发送流量
 *  WWANReceived 移动网络接收流量
 */
+ (NSDictionary *)getTrafficMonitorings {
    NSDictionary * trafficDict = [[NSDictionary alloc] init];
    BOOL success;
    struct ifaddrs *addrs;
    const struct ifaddrs *cursor;
    const struct if_data *networkStatisc;
    int WiFiSent = 0;
    int WiFiReceived = 0;
    int WWANSent = 0;
    int WWANReceived = 0;
    NSString *name=[[NSString alloc]init];
    success = getifaddrs(&addrs) == 0;
    if (success) {
        cursor = addrs;
        while (cursor != NULL) {
            name=[NSString stringWithFormat:@"%s",cursor->ifa_name];

            if (cursor->ifa_addr->sa_family == AF_LINK) {
                //wifi消耗流量
                if ([name hasPrefix:@"en"]) {
                    networkStatisc = (const struct if_data *) cursor->ifa_data;
                    WiFiSent+=networkStatisc->ifi_obytes;
                    WiFiReceived+=networkStatisc->ifi_ibytes;
                }

                //移动网络消耗流量
                if ([name hasPrefix:@"pdp_ip0"]) {
                    networkStatisc = (const struct if_data *) cursor->ifa_data;
                    WWANSent+=networkStatisc->ifi_obytes;
                    WWANReceived+=networkStatisc->ifi_ibytes;
                }
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }

    WiFiSent = abs(WiFiSent);
    WiFiReceived = abs(WiFiReceived);
    WWANSent = abs(WWANSent);
    WWANReceived = abs(WWANReceived);
    int send = WiFiSent+WWANSent;
    int received = WiFiReceived+WWANReceived;
    int nowSend = 11;
    int nowReceived = 22;
    trafficDict = @{
                    @"WiFiSentTraffic":@(WiFiSent),
                    @"WiFiReceivedTraffic":@(WiFiReceived),
                    @"WWANSentTraffic":@(WWANSent),
                    @"WWANReceivedTraffic":@(WWANReceived),
                    @"send":@(send),
                    @"received":@(received),
                    @"nowSend":@(nowSend),
                    @"nowReceived":@(nowReceived),
                    @"availableMemory":@([self availableMemory]),
                    @"usedMemory":@([self usedMemory]),
                    };
    NSLog(@"---info = %@",trafficDict);
    return trafficDict;
}


/**
 获取当前设备内存

 @return 获取当前设备内存
 */
+ (double)availableMemory {
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount =HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    return ((vm_page_size *vmStats.free_count) /1024.0) / 1024.0;

}

/**
 获取内存使用量 MB

 @return 获取内存使用量 MB
 */
+ (double)usedMemory {
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount =TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn =task_info(mach_task_self(),
                                        TASK_BASIC_INFO,
                                        (task_info_t)&taskInfo,
                                        &infoCount);
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    return taskInfo.resident_size / 1024.0 / 1024.0;

}


- (NSString *)wiFiSent {
    return [[HTTraffic getTrafficMonitorings] objectForKey:@"WiFiSentTraffic"];
}

- (NSString *)wiFiReceived {
    return [[HTTraffic getTrafficMonitorings] objectForKey:@"WiFiReceivedTraffic"];
}
- (NSString *)wWANSent {
    return [[HTTraffic getTrafficMonitorings] objectForKey:@"WWANSentTraffic"];
}
- (NSString *)wWANReceived {
    return [[HTTraffic getTrafficMonitorings] objectForKey:@"WWANReceivedTraffic"];
}
- (NSString *)send {
    return [[HTTraffic getTrafficMonitorings] objectForKey:@"send"];
}

- (NSString *)received {
    return [[HTTraffic getTrafficMonitorings] objectForKey:@"received"];
}

- (NSString *)nowSend {
    return [[HTTraffic getTrafficMonitorings] objectForKey:@"nowSend"];
}

- (NSString *)nowReceived {
    return [[HTTraffic getTrafficMonitorings] objectForKey:@"nowReceived"];
}

@end
