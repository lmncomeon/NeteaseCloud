//
//  MNAppListViewController.m
//  MNRichDemo
//
//  Created by 栾美娜 on 2017/6/14.
//  Copyright © 2017年 栾美娜. All rights reserved.
//

#import "MNAppListViewController.h"
#import "LMAppController.h"

@interface MNAppListViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSArray <LMApp *> *dataSource;

@end

static NSInteger const num_H = 4;
static NSInteger const num_V = 4;

@implementation MNAppListViewController

- (UIImageView *)bgView {
    if (!_bgView) {
        _bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight)];
        _bgView.image = [UIImage imageNamed:@"cat"];
        [self.view addSubview:_bgView];
    }
    return _bgView;
}

- (UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc]initWithFrame:self.bgView.frame];
        _mainScrollView.pagingEnabled = true;
        _mainScrollView.delegate      = self;
        [self.view addSubview:_mainScrollView];
    }
    return _mainScrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, kScreenHeight-adaptY(50), kScreenWidth, adaptY(20))];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPage   = 0;
        [self.view addSubview:_pageControl];
    }
    return _pageControl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self mainScrollView];
    
    
    NSInteger countA = (num_H * num_V);
    NSInteger pageCount = self.dataSource.count / countA;
    if (self.dataSource.count % countA != 0) {
        pageCount += 1;
    }
    
    
    for (int i = 0; i < pageCount; i++) {
        NSRange range = NSMakeRange(i*countA, countA);
        
        if (i+1 == pageCount) {
            if (self.dataSource.count % countA != 0) {
                range = NSMakeRange(i*countA, self.dataSource.count % countA);
            }
        }
        
        UIView *pageView = [self createPageViewWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, self.mainScrollView.height) list:[self.dataSource subarrayWithRange:range]];
        [self.mainScrollView addSubview:pageView];
    }
    self.mainScrollView.contentSize = CGSizeMake(kScreenWidth*pageCount, 0);
    
    self.pageControl.numberOfPages = pageCount;
    
    
}

- (UIView *)createPageViewWithFrame:(CGRect)frame list:(NSArray <LMApp *> *)list {
    UIView *pageView = [[UIView alloc] initWithFrame:frame];
    
    CGFloat padding = adaptX(18);
    CGFloat iconWH  = (kScreenWidth-(num_H+1)*padding)/num_H;
    for (int i = 0; i < list.count; i++) {
        int row = i / num_H;
        int col = i % num_H;
        
        UIView *item = [UIView new];
        item.frame = CGRectMake(padding+col*(iconWH+padding), padding+row*(iconWH+adaptY(20)+padding), iconWH, iconWH+adaptY(20));
        [pageView addSubview:item];
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iconWH, iconWH)];
        icon.image = list[i].icon;
        
        [item addSingleTapEvent:^{
            [[LMAppController sharedInstance] openAppWithBundleIdentifier:list[i].bundleIdentifier];
        }];
        [item addSubview:icon];
        
        SDKCustomLabel *lab = [SDKCustomLabel setLabelTitle:list[i].name setLabelFrame:CGRectMake(0, CGRectGetMaxY(icon.frame), iconWH, adaptY(20)) setLabelColor:[UIColor blackColor] setLabelFont:kFont(10) setAlignment:1];
        [item addSubview:lab];
    }
    
    
    return pageView;
}

#pragma mark - scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger page = (scrollView.contentOffset.x + kScreenWidth*0.5) / kScreenWidth;
    
    self.pageControl.currentPage = page;
}

#pragma mark - lazy load
- (NSArray <LMApp *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [LMAppController sharedInstance].installedApplications;
    }
    return _dataSource;
}

@end
