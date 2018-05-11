//
//  XCTimerManager.h
//  IntelligentAgriculture
//
//  Created by Junial on 2018/5/9.
//  Copyright © 2018年 RongRui. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol XCTimerManagerDelegate<NSObject>

/* 返回剩余时间 */
- (void)timerManagerCountDown:(int)timeout;

@end

@interface XCTimerManager : NSObject

/* 代理 */
@property (nonatomic, weak) id<XCTimerManagerDelegate> delegate;
/* 倒计时剩余的时间 */
@property (nonatomic, assign) int leftTime;
/* 单例 */
+ (instancetype)sharedTimerManager;

/* 倒计时方法 */
- (void)timeCountDown;

/* 使用NSTimer测试 (不推荐使用NSTimer) */
- (void)countDownUseNSTimer;

/* 取消倒计时 */
- (void)cancelTimer;

@end
