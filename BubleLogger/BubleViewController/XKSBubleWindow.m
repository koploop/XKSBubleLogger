//
//  XKSBubleWindow.m
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/22.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKSBubleWindow.h"

@implementation XKSBubleWindow

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = [UIColor clearColor];
        self.windowLevel = UIWindowLevelStatusBar - 1;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSAssert(1, @"init should not be with coder");
    self = [super initWithCoder:aDecoder];
    return self;
}

// override UIView func
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if(self.delegate && [self.delegate respondsToSelector:@selector(isPointEvent:)]) {
        return [self.delegate isPointEvent:point];
    }
    return NO;
}


@end
