//
//  XCTimerManager.m
//  IntelligentAgriculture
//
//  Created by Junial on 2018/5/9.
//  Copyright © 2018年 RongRui. All rights reserved.
//

#import "XCTimerManager.h"

#define kMaxCountDownTime           60

@implementation XCTimerManager

+ (instancetype)sharedTimerManager {
    static XCTimerManager *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[XCTimerManager alloc] init];
    });
    return _instance;
}

- (void)countDown {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    
    NSTimeInterval seconds = kMaxCountDownTime;
    NSDate *endTime = [NSDate dateWithTimeIntervalSinceNow:seconds];
    
    dispatch_source_set_event_handler(_timer, ^{
        int interval = [endTime timeIntervalSinceNow];
        self->_timeout = interval;
        if (interval > 0) {
            NSLog(@"%@", [NSString stringWithFormat:@"单例倒计时:剩余 %ds", interval]);
        }else {
            dispatch_source_cancel(_timer);
        }
        
        if ([self.delegate respondsToSelector:@selector(xc_timeCountDown:)]) {
            [self.delegate xc_timeCountDown:interval];
        }
    });
    dispatch_resume(_timer);
}

@end
