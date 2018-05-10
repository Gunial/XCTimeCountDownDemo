//
//  ForgetTextField.m
//  IntelligentAgriculture
//
//  Created by admin on 2017/6/15.
//  Copyright © 2017年 RongRui. All rights reserved.
//

#import "ForgetTextField.h"

@implementation ForgetTextField

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.font = [UIFont systemFontOfSize:16];
        self.tintColor = [UIColor lightGrayColor];
        
        self.returnKeyType = UIReturnKeyNext;
        self.autocapitalizationType = UITextAutocapitalizationTypeNone;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
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


@end
