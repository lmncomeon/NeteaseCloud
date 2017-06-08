//
//  MNViewController0.m
//  MNRichDemo
//
//  Created by 栾美娜 on 2017/6/5.
//  Copyright © 2017年 栾美娜. All rights reserved.
//

#import "MNViewController0.h"
#import "MNTipView.h"
#import "MNUserCell.h"

@interface MNViewController0 ()

@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) NSArray *iconsArr;
@property (nonatomic, strong) NSArray *tipsArr;
@property (nonatomic, strong) MNTipView *tip;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation MNViewController0

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat btnWH = adaptX(16);
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame = CGRectMake(20, 100, btnWH, btnWH);
    [_btn setBackgroundImage:[UIImage imageNamed:self.iconsArr[_btnIndex]] forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
    
}

- (void)btnAction {
    _btnIndex++;
    
    if (_btnIndex > self.tipsArr.count-1) {
        _btnIndex = 0;
    }
    
    // post request
    
    [_btn setBackgroundImage:[UIImage imageNamed:self.iconsArr[_btnIndex]] forState:UIControlStateNormal];
    
    // 显示文字
    if (_tip) {
        [_tip settingText:self.tipsArr[_btnIndex]];
        
        [self killTimer:self.timer];
        
        [self startTimerTask];
        
    } else {
        _tip = [MNTipView tipViewWithText:self.tipsArr[_btnIndex]];
        [self.tip tipViewShow];
        
        [self startTimerTask];
    }
    
}

- (void)killTimer:(NSTimer *)timer {
    [timer invalidate];
    timer = nil;
}

- (void)startTimerTask {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:false block:^(NSTimer * _Nonnull timer) {
        _tip.hidden = true;
        
        [_tip removeFromSuperview];
        _tip = nil;
    }];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

#pragma mark - lazy load
- (NSArray *)iconsArr {
    if (!_iconsArr) {
        _iconsArr = @[@"back_alt-1", @"back_alt", @"smiley_sad", @"smiley", @"star"];
    }
    return _iconsArr;
}

- (NSArray *)tipsArr {
    if (!_tipsArr) {
        _tipsArr = @[@"向左", @"向右", @"悲伤", @"开心", @"星星"];
    }
    return _tipsArr;
}

#pragma mark - dealloc
- (void)dealloc {

}

@end
