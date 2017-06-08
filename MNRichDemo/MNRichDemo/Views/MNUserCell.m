//
//  MNUserCell.m
//  MNRichDemo
//
//  Created by 栾美娜 on 2017/6/5.
//  Copyright © 2017年 栾美娜. All rights reserved.
//

#import "MNUserCell.h"

static NSString *const cellID = @"MNUserCell";

@implementation MNUserCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    MNUserCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[MNUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

@end
