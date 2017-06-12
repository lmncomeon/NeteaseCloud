//
//  MNCollectionReusableHeaderView.m
//  MNRichDemo
//
//  Created by 栾美娜 on 2017/6/9.
//  Copyright © 2017年 栾美娜. All rights reserved.
//

#import "MNCollectionReusableHeaderView.h"
#import "SDKProjectHeader.h"
#import "UIView+CustomView.h"
#import "SDKCustomRoundedButton.h"
#import "SDKCustomLabel.h"

@interface MNCollectionReusableHeaderView ()

@property (nonatomic, strong) UIView *userView;

@property (nonatomic, strong) SDKCustomLabel *nameLab;

@end

@implementation MNCollectionReusableHeaderView

/** 用户view */
- (UIView *)userView {
    if (!_userView) {
        _userView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, adaptY(136))];
        [self addSubview:_userView];
        
        CGFloat avatorWH = adaptX(50);
        SDKCustomLabel *avator = [SDKCustomLabel setLabelTitle:@"上传\n头像" setLabelFrame:CGRectMake((kScreenWidth-avatorWH)*0.5, adaptY(2), avatorWH, avatorWH) setLabelColor:[UIColor whiteColor] setLabelFont:[UIFont systemFontOfSize:15 weight:2] setAlignment:1];
        avator.numberOfLines = 0;
        avator.backgroundColor = [UIColor redColor];
        avator.layer.masksToBounds = true;
        avator.layer.cornerRadius = avatorWH*0.5;
        [_userView addSubview:avator];
        
        _nameLab = [SDKCustomLabel setLabelTitle:@"娜娜的世界哈哈" setLabelFrame:CGRectMake(0, CGRectGetMaxY(avator.frame), kScreenWidth, adaptY(30)) setLabelColor:[UIColor whiteColor] setLabelFont:[UIFont systemFontOfSize:12 weight:2] setAlignment:1];
        [_userView addSubview:_nameLab];
        
        SDKCustomRoundedButton *editBtn = [SDKCustomRoundedButton roundedBtnWithTitle:@"编辑" font:kFont(12) titleColor:[UIColor whiteColor] backgroundColor:[UIColor clearColor]];
        [editBtn sizeToFit];
        editBtn.width += adaptX(10);
        editBtn.height += adaptY(8);
        editBtn.center = CGPointMake(kScreenWidth*0.5, CGRectGetMaxY(_nameLab.frame) + adaptY(30));
        editBtn.layer.borderWidth = 0.5f;
        editBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        [_userView addSubview:editBtn];
    }
    return _userView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self userView];
    }
    return self;
}

@end
