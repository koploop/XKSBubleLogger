//
//  XKSBubleView.h
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/22.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol BubleViewDelegate <NSObject>

- (void)didTapBuble;
    
@end

@interface XKSBubleView : UIView

@property (nonatomic, assign, readonly, class) CGPoint originalPosition;
@property (nonatomic, assign, readonly, class) CGSize size;
@property (nonatomic, weak) id<BubleViewDelegate> delegate;


- (void)changeSideDisplayLeft:(BOOL)display;

- (void)updateOrientation:(CGSize)newSize;
    
@end
