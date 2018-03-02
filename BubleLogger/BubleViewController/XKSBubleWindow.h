//
//  XKSBubleWindow.h
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/22.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ManagerWindowDelegate <NSObject>

- (BOOL)isPointEvent:(CGPoint)point;

@end

@interface XKSBubleWindow : UIWindow

@property (nonatomic, weak) id<ManagerWindowDelegate> delegate;

@end
