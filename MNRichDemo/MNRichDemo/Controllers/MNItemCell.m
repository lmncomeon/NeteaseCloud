//
//  MNItemCell.m
//  MNRichDemo
//
//  Created by 栾美娜 on 2017/6/9.
//  Copyright © 2017年 栾美娜. All rights reserved.
//

#import "MNItemCell.h"
#import "SDKProjectHeader.h"
#import "UIView+CustomView.h"
#import "SDKCustomLabel.h"
#import "SDKAboutText.h"

// VC
#import "MNMusicViewController.h"
#import "MNFinderViewController.h"
#import "MNAboutMeViewController.h"

@interface MNItemCell () <UIScrollViewDelegate>

@property (nonatomic, strong) UIView *switchView;
@property (nonatomic, strong) UIView *moveLine;
@property (nonatomic, strong) UIButton *selectedBtn;

@property (nonatomic, strong) UIScrollView *horizontalBox;

@property (nonatomic, strong) NSArray *tmp;
@property (nonatomic, strong) NSMutableArray *switchBtnsArray;


// --------- 音乐 动态 关于我 -------
@property (nonatomic, strong) MNMusicViewController   *musicVC;
@property (nonatomic, strong) MNFinderViewController  *finderVC;
@property (nonatomic, strong) MNAboutMeViewController *aboutMeVC;


@end

@implementation MNItemCell

/** 切换模式 */
- (UIView *)switchView {
    if (!_switchView) {
        _switchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, adaptY(30))];
        _switchView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_switchView];
        
        UIView *divider = [[UIView alloc] initWithFrame:CGRectMake(0, _switchView.height-0.5f, kScreenWidth, 0.5f)];
        divider.backgroundColor = cuttingLineColor;
        [_switchView addSubview:divider];
        
        
        CGFloat btnW = kScreenWidth/self.tmp.count;
        CGFloat btnH = _switchView.height-0.5f;
        
        for (int i = 0; i < self.tmp.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i*btnW, 0, btnW, btnH);
            btn.tag = 1000 + i;// tag
            [self settingTextAndColorWithBtn:btn index:i special:@""];
            [btn addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
            [_switchView addSubview:btn];
            // add
            [self.switchBtnsArray addObject:btn];
            
            // 默认
            if (i == 0) {
                CGFloat lineW = [SDKAboutText calcaulateTextWidth:self.tmp[0] height:btnH font:kFont(12)] + 4;
                _moveLine = [[UIView alloc] initWithFrame:CGRectMake((btnW -lineW)*0.5, _switchView.height-adaptY(2), lineW, adaptY(2))];
                _moveLine.backgroundColor = [UIColor greenColor];
                [_switchView addSubview:_moveLine];
                
                btn.selected = true;
                _selectedBtn = btn;
            }
        }
        
        
    }
    return _switchView;
}

/** 水平容器 */
- (UIScrollView *)horizontalBox {
    if (!_horizontalBox) {
        _horizontalBox = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.switchView.frame), kScreenWidth, kScreenHeight-64-_switchView.height)];
        _horizontalBox.contentSize = CGSizeMake(self.switchBtnsArray.count*kScreenWidth, 0);
        _horizontalBox.bounces = false;
        _horizontalBox.pagingEnabled = true;
        _horizontalBox.delegate = self;
        [self.contentView addSubview:_horizontalBox];
        
        CGFloat itemViewH = _horizontalBox.height;
        
        _musicVC.view.frame   = CGRectMake(0, 0, kScreenWidth, itemViewH);
        _finderVC.view.frame  = CGRectMake(kScreenWidth, 0, kScreenWidth, itemViewH);
        _aboutMeVC.view.frame = CGRectMake(kScreenWidth*2, 0, kScreenWidth, itemViewH);
        
        [_horizontalBox addSubview:_musicVC.view];
        [_horizontalBox addSubview:_finderVC.view];
        [_horizontalBox addSubview:_aboutMeVC.view];

        _musicVC.mainTableView.height = itemViewH*0.5;
    }
    return _horizontalBox;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupChildControllers];
        
        [self horizontalBox];
        
    }
    return self;
}

#pragma mark - 点击切换模式按钮
- (void)switchAction:(UIButton *)sender {
    if (sender == _selectedBtn) return;
    
    // 改变按钮颜色
    [self changeSwitchBtn:sender];
    
    // 滑动线设置
    [self changeMovieLine:sender];
    
    // 切换界面
    [self changeShowView:sender];
    
    if (sender.tag - 1000 == 0) {
        int index = arc4random_uniform(2);
        if (index == 0) {
            _musicVC.listArray = @[@"听歌排行", @"我喜欢的音乐"];
            DLog(@"====0");
        } else {
            _musicVC.listArray = @[@"听歌排3333行", @"我喜欢的音乐"];
            DLog(@"==其他");
        }
    }
    
}

- (void)changeSwitchBtn:(UIButton *)sender {
    sender.selected = true;
    _selectedBtn.selected = false;
    _selectedBtn = sender;
}

- (void)changeMovieLine:(UIButton *)sender {
    __weak __typeof(&*self)weakSelf = self;
    [UIView animateWithDuration:0.5f animations:^{
        
        CGFloat newW = [sender.currentAttributedTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, adaptY(30)) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.width;
        weakSelf.moveLine.width = newW + 4;
        weakSelf.moveLine.centerX = sender.centerX;
    }];
}

- (void)changeShowView:(UIButton *)sender {
    [_horizontalBox setContentOffset:CGPointMake(kScreenWidth*(sender.tag-1000), 0) animated:false];
}


#pragma mark - scrollview delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {

    /***==================== 水平滑动 ================***/
    if (scrollView == _horizontalBox) {
        
        NSInteger page = (scrollView.contentOffset.x+kScreenWidth*0.5) / kScreenWidth;
        
        if (self.switchBtnsArray[page] == _selectedBtn) return;
        
        // 改变按钮颜色
        [self changeSwitchBtn:self.switchBtnsArray[page]];
        
        // 滑动线设置
        [self changeMovieLine:self.switchBtnsArray[page]];
    }
    
}

#pragma mark - other method
- (void)setupChildControllers {
    UIViewController *containerVC = [self findViewController:self];
    
    _musicVC   = [MNMusicViewController new];
    _finderVC  = [MNFinderViewController new];
    _aboutMeVC = [MNAboutMeViewController new];
    
    [containerVC addChildViewController:_musicVC];
    [containerVC addChildViewController:_finderVC];
    [containerVC addChildViewController:_aboutMeVC];
}

- (UIViewController *)findViewController:(UIView *)sourceView

{
    id target=sourceView;
    
    while (target) {
        
        target = ((UIResponder *)target).nextResponder;
        
        if ([target isKindOfClass:[UIViewController class]]) {
            
            break;
            
        }
        
    }
    
    return target;
    
}

#pragma mark - other
- (void)settingTextAndColorWithBtn:(UIButton *)btn index:(int)index special:(NSString *)special {
    
    [btn setAttributedTitle:[self attrWithBaseString:self.tmp[index] baseFont:kFont(12) baseColor:[UIColor blackColor] special:special specialFont:kFont(10) specialColor:[UIColor grayColor]] forState:UIControlStateNormal];
    [btn setAttributedTitle:[self attrWithBaseString:self.tmp[index] baseFont:kFont(12) baseColor:[UIColor greenColor] special:special specialFont:kFont(10) specialColor:[UIColor grayColor]] forState:UIControlStateSelected];
}

// 变色文字
- (NSMutableAttributedString *)attrWithBaseString:(NSString *)base
                                         baseFont:(UIFont *)baseFont
                                        baseColor:(UIColor *)baseColor
                                          special:(NSString *)special
                                      specialFont:(UIFont *)specialFont
                                     specialColor:(UIColor *)specialColor
{
    NSString *total = [NSString stringWithFormat:@"%@%@", base, special];
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:total attributes:@{NSFontAttributeName : baseFont, NSForegroundColorAttributeName : baseColor}];
    [attr addAttribute:NSFontAttributeName value:specialFont range:[total rangeOfString:special]];
    [attr addAttribute:NSForegroundColorAttributeName value:specialColor range:[total rangeOfString:special]];
    
    return attr;
}

#pragma mark - lazy load container
- (NSMutableArray *)switchBtnsArray {
    if (!_switchBtnsArray) {
        _switchBtnsArray = [NSMutableArray array];
    }
    return _switchBtnsArray;
}

- (NSArray *)tmp {
    if (!_tmp) {
        _tmp = @[@"音乐", @"动态", @"关于我"];
    }
    return _tmp;
}


@end
