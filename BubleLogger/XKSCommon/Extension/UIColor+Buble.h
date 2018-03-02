//
//  UIColor+Buble.h
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/22.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct ColorGradient {
    CGColorRef first_color;
    CGColorRef second_color;
} ColorGradient;

@interface UIColor (Buble)

+ (ColorGradient)colorGradientHead;

+ (UIColor *)mainColor;

@end
