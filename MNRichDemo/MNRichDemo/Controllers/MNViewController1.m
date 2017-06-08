//
//  MNViewController1.m
//  MNRichDemo
//
//  Created by 栾美娜 on 2017/6/6.
//  Copyright © 2017年 栾美娜. All rights reserved.
//

#import "MNViewController1.h"

#import "MNMusicViewController.h"
#import "MNFinderViewController.h"
#import "MNAboutMeViewController.h"

@interface MNViewController1 () <UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *bgView;

@property (nonatomic, strong) UIView *navigationView;
@property (nonatomic, strong) SDKCustomLabel *titleLab;

@property (nonatomic, strong) UIScrollView *container;

@property (nonatomic, strong) UIView *userView;
@property (nonatomic, strong) SDKCustomLabel *nameLab;

@property (nonatomic, strong) UIView *switchView;
@property (nonatomic, strong) UIView *moveLine;
@property (nonatomic, strong) NSMutableArray *switchBtnsArray;
@property (nonatomic, strong) NSArray *tmp;
@property (nonatomic, strong) UIButton *selectedBtn;

@property (nonatomic, strong) UIScrollView *horizontalBox;


// --------- 音乐 动态 关于我 -------
@property (nonatomic, strong) MNMusicViewController  *musicVC;
@property (nonatomic, strong) MNFinderViewController *finderVC;
@property (nonatomic, strong) MNAboutMeViewController *aboutMeVC;

@end

@implementation MNViewController1

/** 背景图 */
- (UIImageView *)bgView {
    if (!_bgView) {
        _bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, adaptY(136)+64)];
        _bgView.clipsToBounds = YES;
        _bgView.contentMode = UIViewContentModeScaleAspectFill;
        [_bgView sd_setImageWithURL:[NSURL URLWithString:@"http://or4gkwj4o.bkt.clouddn.com/bg_big.png"]];
        [self.view addSubview:_bgView];
    }
    return _bgView;
}

/** 导航条 */
- (UIView *)navigationView {
    if (!_navigationView) {
        _navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
        [self.view addSubview:_navigationView];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(3, 0, 44, 44);
        [btn setImage:[UIImage imageNamed:@"common-back"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [_navigationView addSubview:btn];
        
        _titleLab = [SDKCustomLabel setLabelTitle:@"娜娜的世界哈哈" setLabelFrame:CGRectMake(0, 0, kScreenWidth, 44) setLabelColor:[UIColor whiteColor] setLabelFont:[UIFont systemFontOfSize:14 weight:2] setAlignment:1];
        _titleLab.hidden = true;
        [_navigationView addSubview:_titleLab];
    }
    return _navigationView;
}


/** 垂直容器 */
- (UIScrollView *)container {
    if (!_container) {
        _container = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationView.frame), kScreenWidth, kScreenHeight-64+adaptY(136))];
        _container.contentSize = CGSizeMake(0, _container.height + adaptY(136));
        _container.delegate = self;
        [self.view addSubview:_container];
    }
    return _container;
}

/** 用户view */
- (UIView *)userView {
    if (!_userView) {
        _userView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, adaptY(136))];
        [self.container addSubview:_userView];
        
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

/** 切换模式 */
- (UIView *)switchView {
    if (!_switchView) {
        _switchView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.userView.frame), kScreenWidth, adaptY(30))];
        _switchView.backgroundColor = [UIColor whiteColor];
        [self.container addSubview:_switchView];
        
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
        _horizontalBox = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.switchView.frame), kScreenWidth, _container.height-CGRectGetMaxY(_switchView.frame))];
        _horizontalBox.contentSize = CGSizeMake(self.switchBtnsArray.count*kScreenWidth, 0);
        _horizontalBox.bounces = false;
        _horizontalBox.pagingEnabled = true;
        _horizontalBox.delegate = self;
        [_container addSubview:_horizontalBox];
        
        CGFloat itemViewH = _horizontalBox.height;
        
        _musicVC.view.frame   = CGRectMake(0, 0, kScreenWidth, itemViewH);
        _finderVC.view.frame  = CGRectMake(kScreenWidth, 0, kScreenWidth, itemViewH);
        _aboutMeVC.view.frame = CGRectMake(kScreenWidth*2, 0, kScreenWidth, itemViewH);
        
        
        [_horizontalBox addSubview:_musicVC.view];
        [_horizontalBox addSubview:_finderVC.view];
        [_horizontalBox addSubview:_aboutMeVC.view];
        
        
    }
    return _horizontalBox;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupChildControllers];

    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self horizontalBox];
    
    __weak __typeof(&*self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (int i = 0; i < self.switchBtnsArray.count; i++) {
            UIButton *btn = self.switchBtnsArray[i];
            
            [weakSelf settingTextAndColorWithBtn:btn index:i special:@" 2"];
            
            weakSelf.musicVC.listArray = @[@"听歌排行", @"我喜欢的音乐"];
        }
    });
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = true;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    self.navigationController.navigationBarHidden = false;
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

#pragma mark - 返回
- (void)backAction {
    [self.navigationController popViewControllerAnimated:true];
    
    [_musicVC.view removeFromSuperview];
    [_finderVC.view removeFromSuperview];
    [_aboutMeVC.view removeFromSuperview];
    
    [_musicVC removeFromParentViewController];
    [_finderVC removeFromParentViewController];
    [_aboutMeVC removeFromParentViewController];
    
}

#pragma mark - other method
- (void)setupChildControllers {
    _musicVC   = [MNMusicViewController new];
    _finderVC  = [MNFinderViewController new];
    _aboutMeVC = [MNAboutMeViewController new];
    
    [self addChildViewController:_musicVC];
    [self addChildViewController:_finderVC];
    [self addChildViewController:_aboutMeVC];
}

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
#pragma mark - scrollview delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    /***==================== 垂直滑动 ================***/
    if (scrollView == _container)
    {
        CGFloat offsetY = scrollView.contentOffset.y; //滚动Y值
        
        //---------- 加图片拉伸动画 -----
        if (offsetY < 0) {
            _bgView.frame = CGRectMake(0, 0, kScreenWidth, adaptY(136)+64-offsetY);
        }
        
        
        // ----  加导航栏标题动画 -----
        if (offsetY >= CGRectGetMaxY(_nameLab.frame)) {
            _titleLab.hidden = false;
        } else {
            _titleLab.hidden = true;
        }
        
        // --- 为了切换模式停留(补充) --
        if (offsetY >= self.userView.height-20) {
            _container.bounces = false;
        } else {
            _container.bounces = true;
            
        }
        
    }
    
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

#pragma mark - dealloc
- (void)dealloc {
    
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
