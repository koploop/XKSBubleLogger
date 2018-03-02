//
//  XKSFilterTableViewCell.h
//  XKSBubleLogger
//
//  Created by SuperMario@lvhan on 2018/1/29.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XKSFilterTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *viewLogType;
@property (weak, nonatomic) IBOutlet UILabel *labelLogType;
@property (weak, nonatomic) IBOutlet UISwitch *logSwitch;

- (void)configureCellWithIndexPath:(NSIndexPath* )indexPath taped:(void(^)(BOOL tap))tapBlock;

@end
