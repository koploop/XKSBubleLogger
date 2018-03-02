//
//  XKSNetworkListCell.m
//  XKSBubleLogger
//
//  Created by SuperMario@lvhan on 2018/1/26.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import "XKSNetworkListCell.h"
#import "XKSFormatter.h"

@implementation XKSNetworkListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.viewStatus.layer.cornerRadius = 4;
    self.textVeiwDetail.userInteractionEnabled = NO;
    
    self.textVeiwDetail.scrollEnabled = NO;
    self.textVeiwDetail.editable = NO;
}

- (void)configureCell:(XKSNetworkLog *)log {
    self.labelLogDate.text = [XKSFormatter formatterDate:log.date];
    self.viewStatus.backgroundColor = log.codeColor;
    self.textVeiwDetail.text = log.url;
    self.textVeiwDetail.attributedText = [XKSFormatter formatNetLog:log];
}


@end
