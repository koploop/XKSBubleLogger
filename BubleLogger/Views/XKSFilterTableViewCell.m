//
//  XKSFilterTableViewCell.m
//  XKSBubleLogger
//
//  Created by SuperMario@lvhan on 2018/1/29.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import "XKSFilterTableViewCell.h"

@implementation XKSFilterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.viewLogType.layer.cornerRadius = 4;
}

- (void)configureCellWithIndexPath:(NSIndexPath* )indexPath taped:(void(^)(BOOL tap))tapBlock {
    NSArray *colorArray = @[[UIColor redColor],
                            [UIColor yellowColor],
                            [UIColor cyanColor],
                            [UIColor lightGrayColor]
                            ];
    NSArray *textArray = @[@"ERROR",
                           @"WARNNING",
                           @"INFO",
                           @"VERBOSE"
                           ];
    self.viewLogType.backgroundColor = colorArray[indexPath.row];
    self.labelLogType.text = textArray[indexPath.row];
}

@end
