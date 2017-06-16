//
//  MNListViewController.m
//  MNRichDemo
//
//  Created by 栾美娜 on 2017/6/16.
//  Copyright © 2017年 栾美娜. All rights reserved.
//

#import "MNListViewController.h"
#import "SDKAboutText.h"

@interface MNListViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *upView;
@property (nonatomic, strong) UIScrollView *bottomView;

@property (nonatomic, strong) UIButton *selectedBtn;

@property (nonatomic, strong) NSArray *titlesArray;

@end

static NSInteger const titleBtnTag = 1000;

@implementation MNListViewController

- (UIScrollView *)upView {
    if (!_upView) {
        _upView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, adaptY(30))];
        _upView.bounces = false;
        _upView.showsHorizontalScrollIndicator = false;
        [self.view addSubview:_upView];
        
        // 按钮
        CGFloat btnW = 0.00;
        CGFloat btnH = adaptY(30)-1;
        CGFloat btnX = 0.00;
        for (int i = 0; i < self.titlesArray.count; i++) {
            btnW = [SDKAboutText calcaulateTextWidth:self.titlesArray[i] height:btnH font:kFont(12)] + adaptX(10);

            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(btnX, 0, btnW, btnH);
            btn.titleLabel.font = kFont(12);
            [btn setTitle:self.titlesArray[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = titleBtnTag+i;// tag;
            [_upView addSubview:btn];
            
            btnX += btnW;
            
            // default
            if (i == 0) {
                btn.selected = true;
                _selectedBtn = btn;
            }
        }
        
        _upView.contentSize = CGSizeMake(btnX, 0);
    }
    return _upView;
}

- (UIScrollView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.upView.frame), kScreenWidth, kScreenHeight-CGRectGetMaxY(self.upView.frame))];
        _bottomView.showsHorizontalScrollIndicator = false;
        _bottomView.pagingEnabled = true;
        _bottomView.delegate = self;
        _bottomView.bounces  = false;
        [self.view addSubview:_bottomView];
        
        //
        for (int i = 0; i < self.titlesArray.count; i++) {
            UIView *pageView = [[UIView alloc] initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, _bottomView.height)];
            pageView.backgroundColor = krandomColorAlpha(0.8);
            [_bottomView addSubview:pageView];
            
            SDKCustomLabel *lab = [SDKCustomLabel setLabelTitle:self.titlesArray[i] setLabelFrame:CGRectMake(0, adaptY(100), kScreenWidth, adaptY(30)) setLabelColor:[UIColor blackColor] setLabelFont:kFont(12)];
            [pageView addSubview:lab];
        }
        
        _bottomView.contentSize = CGSizeMake(kScreenWidth*self.titlesArray.count, 0);
    }
    return _bottomView;
        
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    [self bottomView];
    
}

- (void)btnAction:(UIButton *)sender {
    
    [self settingButtonProperty:sender];
    
    [self offsetUpView:sender];
    
    NSInteger index = sender.tag-titleBtnTag;
    _bottomView.contentOffset = CGPointMake(index*kScreenWidth, 0);
    
}

- (void)settingButtonProperty:(UIButton *)sender {
    if (sender == _selectedBtn) return;
    
    sender.selected = true;
    _selectedBtn.selected = false;
    _selectedBtn = sender;
}

- (void)offsetUpView:(UIButton *)sender {
    CGFloat del = sender.centerX - kScreenWidth*0.5;
    if (del > 0) {
        
        if (del +_upView.width <= _upView.contentSize.width)
        {
            _upView.contentOffset = CGPointMake(del, 0);
        } else {
            _upView.contentOffset = CGPointMake(_upView.contentSize.width-_upView.width, 0);
        }
    } else {
        _upView.contentOffset = CGPointZero;
    }
}

#pragma mark - scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _bottomView) {
        
        NSInteger index = (scrollView.contentOffset.x + kScreenWidth*0.5) /kScreenWidth;
        
        UIButton *btn = [_upView viewWithTag:titleBtnTag+index];
        [self settingButtonProperty:btn];
        
        [self offsetUpView:btn];
    }
    
}

#pragma mark - lazy load
- (NSArray *)titlesArray {
    if (!_titlesArray) {
        _titlesArray = @[@"音乐", @"我的最爱", @"饮食", @"兴趣爱好", @"绘画", @"战绩", @"我们的口号是", @"凑数据", @"够了吧"];
    }
    return _titlesArray;
}


@end
