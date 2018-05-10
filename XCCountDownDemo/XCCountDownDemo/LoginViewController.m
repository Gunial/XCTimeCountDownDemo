//
//  LoginViewController.m
//  XCCountDownDemo
//
//  Created by Junial on 2018/5/10.
//  Copyright © 2018年 Junial. All rights reserved.
//

#import "LoginViewController.h"
#import "FindPasswordViewController.h"

#import "LoginTextField.h"

@interface LoginViewController ()

@property (nonatomic, strong) UIImageView *bgImageView; // 登录页背景图片
@property (nonatomic, strong) LoginTextField *accountTextField; // 用户名输入框
@property (nonatomic, strong) LoginTextField *pswTextField; // 密码输入框
@property (nonatomic, strong) UIButton *loginButton; // 登录按钮
@property (nonatomic, strong) UIButton *forgetButton; // 忘记密码

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"登录";
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.accountTextField];
    [self.view addSubview:self.pswTextField];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.forgetButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)resetPasswordAction {
    FindPasswordViewController *findVc = [[FindPasswordViewController alloc] init];
    [self.navigationController pushViewController:findVc animated:YES];
}


#pragma mark - getter

- (UIImageView *)bgImageView {
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_bg"]];
        _bgImageView.frame = self.view.bounds;
    }
    return _bgImageView;
}

- (LoginTextField *)accountTextField {
    if (_accountTextField == nil) {
        _accountTextField = [[LoginTextField alloc] initWithIcon:@"username_icon"];
        _accountTextField.frame = CGRectMake(60, 220, self.view.bounds.size.width - 120, 45);
        _accountTextField.placeholder = @"请输入用户名";
    }
    return _accountTextField;
}

- (LoginTextField *)pswTextField {
    if (_pswTextField == nil) {
        _pswTextField = [[LoginTextField alloc] initWithIcon:@"psw_icon"];
        _pswTextField.frame = CGRectMake(60, 300, self.view.bounds.size.width - 120, 45);
        _pswTextField.placeholder = @"请输入密码";
        _pswTextField.secureTextEntry = YES;
    }
    return _pswTextField;
}

- (UIButton *)loginButton {
    if (_loginButton == nil) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.frame = CGRectMake(60, 400, self.view.bounds.size.width - 120, 45);
        _loginButton.backgroundColor = [UIColor whiteColor];
        [_loginButton setTitle:@"登 录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        _loginButton.layer.cornerRadius = 7.5f;
        _loginButton.layer.masksToBounds = YES;
    }
    return _loginButton;
}

- (UIButton *)forgetButton {
    if (_forgetButton == nil) {
        _forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetButton setTitle:@"忘记密码? " forState:UIControlStateNormal];
        [_forgetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _forgetButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_forgetButton sizeToFit];
        _forgetButton.frame = CGRectMake(self.view.bounds.size.width - _forgetButton.bounds.size.width - 60, 480, _forgetButton.bounds.size.width, _forgetButton.bounds.size.height);
        [_forgetButton addTarget:self action:@selector(resetPasswordAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetButton;
}

@end
