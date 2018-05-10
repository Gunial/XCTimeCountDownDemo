//
//  XCTimerManager.h
//  IntelligentAgriculture
//
//  Created by Junial on 2018/5/9.
//  Copyright © 2018年 RongRui. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol XCTimerManagerDelegate<NSObject>

- (void)xc_timeCountDown:(int)timeout;

@end

@interface XCTimerManager : NSObject

/* 倒计时剩余的时间 */
@property (nonatomic, assign) __block int timeout;
/* 代理 */
@property (nonatomic, weak) id<XCTimerManagerDelegate> delegate;
/* 单例 */
+ (instancetype)sharedTimerManager;
/* 倒计时方法 */
- (void)countDown;

@end
