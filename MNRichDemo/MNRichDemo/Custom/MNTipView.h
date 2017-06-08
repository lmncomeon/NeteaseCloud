//
//  MNTipView.h
//  MNRichDemo
//
//  Created by 栾美娜 on 2017/6/5.
//  Copyright © 2017年 栾美娜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MNTipView : UILabel

+ (instancetype)tipViewWithText:(NSString *)text;

- (void)tipViewShow;

- (void)settingText:(NSString *)text;

@end
