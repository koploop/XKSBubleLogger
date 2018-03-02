//
//  XKSNetworkListCell.h
//  XKSBubleLogger
//
//  Created by SuperMario@lvhan on 2018/1/26.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKSNetworkLog.h"

@interface XKSNetworkListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *viewStatus;
@property (weak, nonatomic) IBOutlet UITextView *textVeiwDetail;
@property (weak, nonatomic) IBOutlet UILabel *labelLogDate;

- (void)configureCell:(XKSNetworkLog *)log;

@end
