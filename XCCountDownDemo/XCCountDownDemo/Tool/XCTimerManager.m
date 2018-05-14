//
//  XCTimerManager.m
//  IntelligentAgriculture
//
//  Created by Junial on 2018/5/9.
//  Copyright © 2018年 RongRui. All rights reserved.
//

#import "XCTimerManager.h"

#define kMaxCountDownTime           30

@implementation XCTimerManager
{
    dispatch_source_t _currentTimer;
    NSTimer *_countdownTimer;
}

/* 单例 */
+ (instancetype)sharedTimerManager {
    static XCTimerManager *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[XCTimerManager alloc] init];
    });
    return _instance;
}

/* 倒计时方法 */
- (void)timeCountDown {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    _currentTimer = _timer;
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    
    NSTimeInterval seconds = kMaxCountDownTime;
    NSDate *endTime = [NSDate dateWithTimeIntervalSinceNow:seconds];
    
    dispatch_source_set_event_handler(_timer, ^{
        int interval = [endTime timeIntervalSinceNow];
        self->_leftTime = interval;
        if (interval > 0) {
            NSLog(@"%@", [NSString stringWithFormat:@"单例倒计时:剩余 %ds", interval]);
        }else {
            dispatch_source_cancel(_timer);
        }
        
        if ([self.delegate respondsToSelector:@selector(timerManagerCountDown:)]) {
            [self.delegate timerManagerCountDown:interval];
        }
    });
    dispatch_resume(_timer);
}

/**** 以下利用NSTimer实现倒计时 (不推荐使用NSTimer, 程序进入后台之后,倒计时就停止了,程序回到前台时,时间是接着停止的时候继续) ********/
- (void)countDownUseNSTimer {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    _countdownTimer = timer;
    _leftTime = kMaxCountDownTime;
}

- (void)countDown {
    if ([self.delegate respondsToSelector:@selector(timerManagerCountDown:)]) {
        [self.delegate timerManagerCountDown:_leftTime];
    }

    if (_leftTime > 0) {
        NSLog(@"%@", [NSString stringWithFormat:@"单例倒计时:剩余 %ds", _leftTime]);
        _leftTime--;
    }else {
        [_countdownTimer invalidate];
        _countdownTimer = nil;
    }
}
/****************************************** 以上利用NSTimer实现倒计时 ****************************************************/


- (void)cancelTimer {
    dispatch_source_cancel(_currentTimer);
    _leftTime = 0;
    NSLog(@"取消倒计时");
}

@end
