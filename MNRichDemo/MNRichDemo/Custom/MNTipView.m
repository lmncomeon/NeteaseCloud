//
//  MNTipView.m
//  MNRichDemo
//
//  Created by 栾美娜 on 2017/6/5.
//  Copyright © 2017年 栾美娜. All rights reserved.
//

#import "MNTipView.h"
#import "SDKAboutText.h"
#import "SDKProjectHeader.h"
#import "UIView+CustomView.h"

@implementation MNTipView

+ (instancetype)tipViewWithText:(NSString *)text {
    if (!text) {
        return [MNTipView new];
    }
    
    MNTipView *tip = [[MNTipView alloc] init];
    tip.text = text;
    tip.font = [UIFont systemFontOfSize:adaptX(12) weight:1];
    tip.textColor = [UIColor whiteColor];
    tip.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3f];
    tip.layer.masksToBounds = true;
    tip.layer.cornerRadius = adaptX(5);
    tip.textAlignment = 1;

    
    
    CGFloat tipH = adaptY(25);
    CGFloat tipW = [SDKAboutText calcaulateTextWidth:text height:tipH font:[UIFont systemFontOfSize:adaptX(12) weight:1]] + adaptX(10);
    tip.size = CGSizeMake(tipW, tipH);
    tip.center = CGPointMake(kScreenWidth*0.5, kScreenHeight*0.5);
    
    return tip;
}

- (void)tipViewShow {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [self shakeToShow:self];
}

- (void)settingText:(NSString *)text {
    self.text = text;
    
    [self changeFrameWithText:text];
}

- (void)changeFrameWithText:(NSString *)text {
    CGFloat tipH = adaptY(25);
    CGFloat tipW = [SDKAboutText calcaulateTextWidth:text height:tipH font:[UIFont systemFontOfSize:adaptX(12) weight:1]] + adaptX(10);
    self.size = CGSizeMake(tipW, tipH);
    self.center = CGPointMake(kScreenWidth*0.5, kScreenHeight*0.5);
}

- (void)shakeToShow:(UIView*)aView {
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = 0.5;// 动画时间
    
    NSMutableArray *values = [NSMutableArray array];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    
    [aView.layer addAnimation:animation forKey:nil];
    
}

@end
