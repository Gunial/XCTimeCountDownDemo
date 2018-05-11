//
//  UIView+XCCore.h
//  IntelligentAgriculture
//
//  Created by Junial on 2018/5/9.
//  Copyright © 2018年 RongRui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XCCore)

/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)xc_addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii;

@end
