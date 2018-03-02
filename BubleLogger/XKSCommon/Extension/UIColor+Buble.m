//
//  UIColor+Buble.m
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/22.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import "UIColor+Buble.h"

@implementation UIColor (Buble)

+ (ColorGradient)colorGradientHead {
    ColorGradient color;
    color.first_color = [UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1.00].CGColor;
    color.second_color = [UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1.00].CGColor;
    return color;
}

+ (UIColor *)mainColor {
    return [UIColor colorWithRed:0.26 green:0.83 blue:0.35 alpha:1.00];
}

@end
