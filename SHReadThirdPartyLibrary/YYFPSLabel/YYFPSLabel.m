//
//  YYFPSLabel.m
//  YYKitExample
//
//  Created by ibireme on 15/9/3.
//  Copyright (c) 2015 ibireme. All rights reserved.
//

#import "YYFPSLabel.h"
#import "YYTextWeakProxy.h"
#import "HTTraffic.h"

@interface YYFPSLabel ()

@property (nonatomic, strong) NSMutableArray *sendTimeSource;
@property (nonatomic, strong) NSMutableArray *receivedTimeSource;

@end
@implementation YYFPSLabel
{
    CADisplayLink *_link;
    NSUInteger _count;
    NSTimeInterval _lastTime;
    UIFont *_font;
    UIFont *_subFont;
    NSString *_lastSendDate;
    NSString *_lastReceivedDate;
    HTTraffic *_traffic;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _traffic = [[HTTraffic alloc] init];
        self.layer.cornerRadius = 5;
        self.numberOfLines = 0;
        self.clipsToBounds = YES;
        self.textAlignment = NSTextAlignmentCenter;
        self.userInteractionEnabled = NO;
        self.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.700];
        _font = [UIFont fontWithName:@"Menlo" size:14];
        if (_font) {
            _subFont = [UIFont fontWithName:@"Menlo" size:4];
        } else {
            _font = [UIFont fontWithName:@"Courier" size:14];
            _subFont = [UIFont fontWithName:@"Courier" size:4];
        }
        _link = [CADisplayLink displayLinkWithTarget:[YYTextWeakProxy proxyWithTarget:self] selector:@selector(tick:)];
        [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return self;
}


//
- (void)dealloc {
    [_link invalidate];
    NSLog(@"timer release");
}

- (void)tick:(CADisplayLink *)link {
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
        return;
    }

    _count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) return;
    _lastTime = link.timestamp;
    float fps = _count / delta;
    _count = 0;

    CGFloat progress = fps / 60.0;
    UIColor *color = [UIColor colorWithHue:0.27 * (progress - 0.2) saturation:1 brightness:0.9 alpha:1];
    self.textColor = color;

    [self.sendTimeSource addObject:_traffic.send];
    if (_sendTimeSource.count > 2) {
        [_sendTimeSource removeObjectAtIndex:0];
    }
    int nowSentTime = [[_sendTimeSource firstObject] intValue] - [[_sendTimeSource lastObject] intValue];
    int nowReceivedTime = [[_receivedTimeSource firstObject] intValue] - [[_receivedTimeSource lastObject] intValue];
    NSString *text1 = [NSString stringWithFormat:@"FPS %d \n发送数据 %@ \n接收数据 %@",(int)round(fps),[self btypesWithDate:abs(nowSentTime)],[self btypesWithDate:abs(nowReceivedTime)]];

    self.text = text1;

}
- (NSMutableArray *)sendTimeSource {
    if (!_sendTimeSource) {
        _sendTimeSource = [NSMutableArray arrayWithCapacity:10];
    }
    return _sendTimeSource;
}
- (NSMutableArray *)receivedTimeSource {
    if (!_receivedTimeSource) {
        _receivedTimeSource = [NSMutableArray arrayWithCapacity:10];
    }
    return _receivedTimeSource;
}

- (NSString *)btypesWithDate:(int)date {
    if (date/1000 < 1) {
        return [NSString stringWithFormat:@"%d btypes",date];
    }else if (date/1000 > 1 && date/1000 < 1000){
        return [NSString stringWithFormat:@"%d kb",date/1000];
    }else if (date/1000 > 1000){
        return [NSString stringWithFormat:@"%d Mb",date/1000/1000];
    }
    return [NSString stringWithFormat:@"%d bts",date];
}

@end
