//
//  XKSLogTableViewCell.h
//  XKSBubleLogger
//
//  Created by SuperMario@lvhan on 2018/1/26.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKSGeneralLog.h"

@interface XKSLogTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *viewLogType;
@property (weak, nonatomic) IBOutlet UITextView *textViewDetail;

- (void)configureCell:(XKSGeneralLog *)log;

@end
