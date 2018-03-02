//
//  XKSBubleView.m
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/22.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XKSBubleView.h"
#import "UIColor+Buble.h"
#import "XKSLogBadgeView.h"
#import "XKSNotificationPoster.h"
#import "XKSNotificationObserver.h"
#import "XKSBubleFunction.h"

@interface XKSBubleView ()

@property (nonatomic, assign, readwrite, class) CGPoint originalPosition;
@property (nonatomic, assign, readwrite, class) CGSize size;

@property (nonatomic, strong) XKSNotificationObserver* obsLog;
@property (nonatomic, strong) XKSNotificationObserver* obsNetwork;
@property (nonatomic, strong) XKSLogBadgeView* badge;
@property (nonatomic, strong) UIImageView* imageView;


@end

@implementation XKSBubleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self initLayer];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self initLayer];
    }
    return self;
}

- (void)updateOrientation:(CGSize)newSize {
    CGSize oldSize = CGSizeMake(newSize.width, newSize.height);
    CGFloat percent = self.center.y / oldSize.height * 100;
    CGFloat newOrigin = newSize.height * percent / 100;
    CGFloat originX = self.frame.origin.x < newSize.height / 2 ? 30 : newSize.width - 30;
    self.center = CGPointMake(originX, newOrigin);
}

- (void)changeSideDisplayLeft:(BOOL)display {
    if(display) {
        __block CGRect frame = self.badge.frame;
        [UIView animateWithDuration:0.5 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            frame.origin.x = 60;
            self.badge.frame = frame;
        } completion:nil];
    } else {
        __block CGRect frame = self.badge.frame;
        [UIView animateWithDuration:0.5 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            frame.origin.x = 20 - self.badge.frame.size.width;
            self.badge.frame = frame;
        } completion:nil];
    }
}

#pragma mark - Subviews
- (void)initLayer {
    self.backgroundColor = [UIColor blackColor];
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.8;
    self.layer.cornerRadius = 40;
    self.layer.shadowOffset = CGSizeZero;
    [self sizeToFit];
    self.layer.masksToBounds = true;
    
    CAGradientLayer *gradientLayer = [CAGradientLayer new];
    gradientLayer.frame = self.bounds;
    gradientLayer.cornerRadius = 40;
    gradientLayer.colors = @[(__bridge id)UIColor.colorGradientHead.first_color,
                             (__bridge id)UIColor.colorGradientHead.second_color];
    [self.layer addSublayer:gradientLayer];
     
     [self addSubview:self.imageView];
     [self initBadgeView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self addGestureRecognizer:tapGesture];

    
     // 监听日志事件
    XKSNotificationPoster *logPoster = [XKSNotificationPoster posterWithNotificationType:XKSNotiType_NewLog];
    self.obsLog = [XKSNotificationObserver observerWithMessageType:XKSMessageType_UserInfo notification:logPoster notificationBlock:^(NSString * _Nullable content) {
        // ❌ ⚠️ 🛠
        if(content) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self initLabelEvent:content];
            });
        }
    }];
    
    XKSNotificationPoster *networkPoster = [XKSNotificationPoster posterWithNotificationType:XKSNotiType_NewRequest];
    self.obsNetwork = [XKSNotificationObserver observerWithMessageType:XKSMessageType_Void notification:networkPoster notificationBlock:^(NSString * _Nullable content) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self initLabelEvent:@"🚀"];
        });
    }];
    
}

#pragma mark - Actions
- (void)tap {
    if(self.delegate && [self.delegate respondsToSelector:@selector(didTapBuble)]) {
        [self.delegate didTapBuble];
    }
}

#pragma mark - BadgeView
- (void)initBadgeView {
    self.clipsToBounds = false;
    self.badge = [[XKSLogBadgeView alloc] initWithFrame:CGRectMake(60, 0, 30, 20)];
    [self addSubview:self.badge];
}

- (void)initLabelEvent:(NSString *)content {
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(self.frame.size.width / 2 - 12.5, self.frame.size.height / 2 - 25, 25, 25);
    label.text = content;
    [self addSubview:label];
    
    __block CGRect frame = label.frame;
    [UIView animateWithDuration:0.8 animations:^{
        frame.origin.y = -100;
        label.frame = frame;
        label.alpha = 0;
    } completion:^(BOOL finished) {
        [label removeFromSuperview];
    }];
}

#pragma mark - Getter
// setter 方法无用 只读即可 这里的setter是为了消除警告
+ (void)setOriginalPosition:(CGPoint)originalPosition {
    self.originalPosition = originalPosition;
}
+ (CGPoint)originalPosition {
    return CGPointMake(-10, UIScreen.mainScreen.bounds.size.height / 2);
}
+ (void)setSize:(CGSize)size {
    self.size = size;
}
+ (CGSize)size {
    return CGSizeMake(80, 80);
}

- (UIImageView *)imageView {
    if(!_imageView) {
        CGRect frame = CGRectMake(20, 20, 40, 40);
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        UIImage *image = bubleExternalBundleImage(BubleBundleName, @"xks_logo");
        imageView.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        imageView.tintColor = UIColor.mainColor;
        imageView.layer.cornerRadius = 40;
        _imageView = imageView;
    }
    return _imageView;
}

@end
