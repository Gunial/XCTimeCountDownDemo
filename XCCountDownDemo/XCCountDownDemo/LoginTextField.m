//
//  LoginTextField.m
//  IntelligentAgriculture
//
//  Created by admin on 2017/6/15.
//  Copyright © 2017年 RongRui. All rights reserved.
//

#import "LoginTextField.h"

@implementation LoginTextField

- (instancetype)initWithIcon:(NSString *)iconName {
    self = [super init];
    if (self) {
        UIImageView *iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconName]];
        self.leftView = iconImageView;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.font = [UIFont systemFontOfSize:14];
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.tintColor = [UIColor colorWithWhite:0 alpha:0.46];
        self.autocapitalizationType = UITextAutocapitalizationTypeNone;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self setValue:[UIColor colorWithWhite:0 alpha:0.46] forKeyPath:@"_placeholderLabel.textColor"];
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect textRect = [super textRectForBounds:bounds];
    textRect.origin.x += 15;
    return textRect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect editingRect = [super editingRectForBounds:bounds];
    editingRect.origin.x += 15;
    return editingRect;
}

/** 利用绘图 绘制下划线 */
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, CGRectMake(0, CGRectGetHeight(self.frame) - 1, CGRectGetWidth(self.frame), 1));
}

@end
