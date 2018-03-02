//
//  XKSBubleViewController.m
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/22.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import "XKSBubleViewController.h"
#import "XKSBubleManager.h"
#import "XKSBubleView.h"
#import "XKSBubleMacro.h"
#import "XKSBubleFunction.h"
#import "XKSBubleManager.h"
#import "XKSTabbarViewController.h"

@interface XKSBubleViewController ()<BubleViewDelegate>

@property (nonatomic, strong) XKSBubleView *buble;

@end

@implementation XKSBubleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self parameterInit];
    self.buble.delegate = self;
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)parameterInit {
    CGPoint origin = XKSBubleView.originalPosition;
    CGSize size = XKSBubleView.size;
    self.buble = [[XKSBubleView alloc] initWithFrame: CGRectMake(origin.x, origin.y, size.width, size.height)];
    SEL selector = @selector(panDidFireWithPanner:);
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:selector];
    [self.buble addGestureRecognizer:panGesture];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    XKSBubleManager.sharedManager.displayedList = NO;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.view addSubview:self.buble];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [self.buble updateOrientation:size];
}

#pragma mark - BubleViewDelegate
- (void)didTapBuble {
    XKSBubleManager.sharedManager.displayedList = YES;
    UIStoryboard *storyBoard = bubleExternalStoryBoard(BubleBundleName, @"XKSMainBuble");
    XKSTabbarViewController *tabbarViewController = [storyBoard instantiateInitialViewController];
    [self presentViewController:tabbarViewController animated:YES completion:NULL];
}

#pragma mark - func
- (BOOL)shouldReceiveAtPoint:(CGPoint)point {
    if ([XKSBubleManager sharedManager].displayedList) {
        return YES;
    }
    return CGRectContainsPoint(self.buble.frame, point);
}

- (void)panDidFireWithPanner:(UIPanGestureRecognizer*)panner {
    if (panner.state == UIGestureRecognizerStateBegan) {
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            [self.buble setTransform:CGAffineTransformMakeScale(0.8, 0.8)];
        } completion:nil];
    }
    CGPoint offset = [panner translationInView:self.view];
    [panner setTranslation:CGPointZero inView:self.view];
    CGPoint center = self.buble.center;
    center.x += offset.x;
    center.y += offset.y;
    self.buble.center = center;
    
    if (panner.state == UIGestureRecognizerStateEnded || panner.state == UIGestureRecognizerStateCancelled) {
        
        CGPoint location = [panner locationInView:self.view];
        CGPoint velocity = [panner velocityInView:self.view];
        
        CGFloat finalX = 30;
        CGFloat finalY = location.y;
        
        if (location.x > kScreenWidth / 2) {
            finalX = kScreenWidth - 30.0;
            [self.buble changeSideDisplayLeft:NO];
        } else {
            [self.buble changeSideDisplayLeft:YES];
        }
        
        double horizentalVelocity = fabs(velocity.x);
        double positionX = fabs(finalX - location.x);
        double velocityForce = sqrt(pow(velocity.x, 2) * pow(velocity.y, 2));
        
        CGFloat durationAnimation = (velocityForce > 1000.0) ? MIN(0.3, positionX / horizentalVelocity) : 0.3;
        
        if (velocityForce > 1000.0) {
            finalY += velocity.y * durationAnimation;
        }
        
        if (finalY > kScreenHeight - 50) {
            finalY = kScreenHeight - 50;
        } else if (finalY < 50) {
            finalY = 50;
        }
        
        [UIView animateWithDuration:durationAnimation delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:6 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            
            self.buble.center = CGPointMake(finalX, finalY);
            self.buble.transform = CGAffineTransformIdentity;
            
        } completion:nil];
    }
}

@end
