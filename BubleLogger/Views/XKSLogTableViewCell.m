//
//  XKSLogTableViewCell.m
//  XKSBubleLogger
//
//  Created by SuperMario@lvhan on 2018/1/26.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import "XKSLogTableViewCell.h"
#import "XKSFormatter.h"

@implementation XKSLogTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.viewLogType.layer.cornerRadius = 4;
    
    // 设置cell自适应TextView高度,需要将textView做以下设置, tableView高度设置为Automatic
    self.textViewDetail.scrollEnabled = NO;
    self.textViewDetail.editable = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configureCell:(XKSGeneralLog *)log {
    self.viewLogType.backgroundColor = [XKSGeneralLog colorOfLoglevel:log.level];
    NSAttributedString *content = [XKSFormatter formatLog:log];
    self.textViewDetail.text = content.string;
    self.textViewDetail.attributedText = content;
}

@end
