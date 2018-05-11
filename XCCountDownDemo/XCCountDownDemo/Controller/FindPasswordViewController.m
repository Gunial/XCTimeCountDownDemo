//
//  FindPasswordViewController.m
//  XCCountDownDemo
//
//  Created by Junial on 2018/5/10.
//  Copyright © 2018年 Junial. All rights reserved.
//

#import "FindPasswordViewController.h"
#import "ForgetTextField.h"
#import "UIView+XCCore.h"

#import "XCTimerManager.h"
#import "MBProgressHUD.h"

@interface FindPasswordViewController ()<XCTimerManagerDelegate>

/* 号码输入框 */
@property (nonatomic, strong) ForgetTextField *phoneNumTextField;
/* 验证码输入框 */
@property (nonatomic, strong) ForgetTextField *codeTextField;
/* 提交按钮 */
@property (nonatomic, strong) UIButton *nextButton;
/* 获取验证码按钮 */
@property (nonatomic, strong) UIButton *codeButton;
/** 取消倒计时 */
@property (nonatomic, strong) UIButton *cancelButton;

@end

@implementation FindPasswordViewController

#pragma mark - 视图声明周期

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    self.navigationItem.title = @"忘记密码";
    
    [self.view addSubview:self.codeButton];
    [self.view addSubview:self.phoneNumTextField];
    [self.view addSubview:self.codeTextField];
    [self.view addSubview:self.nextButton];
    /* 提供一个取消按钮来取消倒计时,实际开发根据业务要求使用 */
    [self.view addSubview:self.cancelButton];
    
    [XCTimerManager sharedTimerManager].delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /*
     之所以在 viewWillAppear 中添加判断
     因为如果不添加这个判断,剩余秒数通过代理传递给控制器之后,控制器才能控制按钮的状态
     "获取验证码"按钮 会有一个 由"获取验证码" -> "重新发送" 的变化过程
     */
    XCTimerManager *manager = [XCTimerManager sharedTimerManager];
    if (manager.leftTime > 0) {
        self.codeButton.enabled = NO;
        self.codeButton.backgroundColor = [UIColor lightGrayColor];
        [self.codeButton setTitle:[NSString stringWithFormat:@"重新发送(%d]s)", manager.leftTime] forState:UIControlStateNormal];
    }
}

/* 点击获取验证码 */
- (void)clickCodeButton {
    
    /* 这里模拟一下请求后台的过程 */
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:1.0];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            self.codeButton.enabled = NO;
            self.codeButton.backgroundColor = [UIColor lightGrayColor];
            [[XCTimerManager sharedTimerManager] timeCountDown];
//            [[XCTimerManager sharedTimerManager] countDownUseNSTimer];
        });
    });
}


/* 提供一个取消按钮来取消倒计时,实际开发根据业务要求使用 */
- (void)cancelCountDown {
    [[XCTimerManager sharedTimerManager] cancelTimer];
    
    [self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.codeButton.backgroundColor = [UIColor orangeColor];
    self.codeButton.enabled = YES;
}

- (void)dealloc {
    NSLog(@"%@ delloc", [self class]);
}

#pragma mark - XCTimerManagerDelegate

- (void)timerManagerCountDown:(int)timeout {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (timeout > 0) { // 倒计时未结束
            [self.codeButton setTitle:[NSString stringWithFormat:@"重新发送(%ds)", timeout] forState:UIControlStateNormal];
        }else { // 倒计时结束
            [self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
            self.codeButton.backgroundColor = [UIColor orangeColor];
            self.codeButton.enabled = YES;
        }
    });
}

#pragma mark - getter

- (UIButton *)codeButton {
    if (_codeButton == nil) {
        _codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _codeButton.backgroundColor = [UIColor orangeColor];
        [_codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_codeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _codeButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_codeButton addTarget:self action:@selector(clickCodeButton) forControlEvents:UIControlEventTouchUpInside];
        _codeButton.frame = CGRectMake(self.view.bounds.size.width - 100 - 15, 120, 100, 45);
        [_codeButton xc_addRoundedCorners:UIRectCornerTopRight|UIRectCornerBottomRight withRadii:CGSizeMake(7.5f, 7.5f)];
    }
    return _codeButton;
}

- (ForgetTextField *)phoneNumTextField {
    if (_phoneNumTextField == nil) {
        _phoneNumTextField = [[ForgetTextField alloc] init];
        _phoneNumTextField.frame = CGRectMake(15, 120, self.view.bounds.size.width - 2*15 - self.codeButton.frame.size.width, 45);
        [_phoneNumTextField xc_addRoundedCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft withRadii:CGSizeMake(7.5f, 7.5f)];

        _phoneNumTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneNumTextField.placeholder = @"请输入注册时的手机号";
    }
    return _phoneNumTextField;
}

- (ForgetTextField *)codeTextField {
    if (_codeTextField == nil) {
        _codeTextField = [[ForgetTextField alloc] init];
        _codeTextField.frame = CGRectMake(15, CGRectGetMaxY(self.phoneNumTextField.frame) + 10, self.view.bounds.size.width - 2*15, 45);
        _codeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
        _codeTextField.placeholder = @"请输入验证码";
        _codeTextField.layer.cornerRadius = 7.5f;
        _codeTextField.layer.masksToBounds = YES;
    }
    return _codeTextField;
}

- (UIButton *)nextButton {
    if (_nextButton == nil) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextButton.backgroundColor = [UIColor orangeColor];
        [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nextButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _nextButton.frame = CGRectMake(15, CGRectGetMaxY(self.codeTextField.frame) + 25, self.view.bounds.size.width - 2*15, 45);
        _nextButton.layer.cornerRadius = 7.5f;
        _nextButton.layer.masksToBounds = YES;
    }
    return _nextButton;
}

- (UIButton *)cancelButton {
    if (_cancelButton == nil) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"取消倒计时" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_cancelButton sizeToFit];
        _cancelButton.frame = CGRectMake((self.view.bounds.size.width - (_cancelButton.bounds.size.width+10))/2, CGRectGetMaxY(self.nextButton.frame) + 100, _cancelButton.bounds.size.width+10, _cancelButton.bounds.size.height+10);
        [_cancelButton addTarget:self action:@selector(cancelCountDown) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

@end
