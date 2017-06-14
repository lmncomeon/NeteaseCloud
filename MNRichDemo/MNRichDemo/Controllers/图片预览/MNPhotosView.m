//
//  MNPhotosView.m
//  MNRichDemo
//
//  Created by 栾美娜 on 2017/6/13.
//  Copyright © 2017年 栾美娜. All rights reserved.
//

#import "MNPhotosView.h"
#import "SDKProjectHeader.h"
#import "UIView+CustomView.h"

@interface MNPhotosView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIScrollView *mainView;
@property (nonatomic, strong) UIPageControl *pageIndicator;


@property (nonatomic, strong) NSMutableArray <UIImageView *> *imgviewsArr;
@property (nonatomic, strong) NSMutableArray <UIImageView *> *previewArray;

@property (nonatomic, strong) NSMutableArray *originArray;
@property (nonatomic, strong) NSMutableArray *lastArray;

@end

static NSInteger const num = 4;
static NSString *const cellID_collection = @"UICollectionViewCellID";

@implementation MNPhotosView

- (UIScrollView *)mainView {
    if (!_mainView) {
        _mainView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _mainView.pagingEnabled   = true;
        _mainView.bounces         = false;
        _mainView.delegate   = self;
    }
    return _mainView;
}

- (UIPageControl *)pageIndicator {
    if (!_pageIndicator) {
        _pageIndicator = [[UIPageControl alloc] initWithFrame:CGRectMake(0, kScreenHeight-adaptY(40), self.frame.size.width, adaptY(30))];
        _pageIndicator.pageIndicatorTintColor = [UIColor grayColor];
        _pageIndicator.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageIndicator.userInteractionEnabled = false;
    }
    return _pageIndicator;
}

- (instancetype)initWithFrame:(CGRect)frame list:(NSArray <NSString *> *)list {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat padding = adaptX(15);
        CGFloat itemWH  = (frame.size.width - (num+1)*padding) / num;
        
        for (int i = 0; i < list.count; i++) {
            int row = i / num;
            int col = i % num;
            
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(padding +col*(itemWH+padding), row*(itemWH+padding), itemWH, itemWH)];
            imgView.image = [UIImage imageNamed:list[i]];
            imgView.userInteractionEnabled = true;
            [imgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
            imgView.tag = 1000 + i; // tag
            [self addSubview:imgView];
            [self.imgviewsArr addObject:imgView];
            
            // 求坐标
            CGRect transformFrame = [imgView convertRect:imgView.bounds toView:kKeyWindow];
            [self.originArray addObject:[NSValue valueWithCGRect:transformFrame]];
        }
        
        self.height = CGRectGetMaxY(self.subviews.lastObject.frame);
    }
    return self;
}

- (void)tap:(UITapGestureRecognizer *)sender {
    [self scanBigImageWithCurrentIndex:sender.view.tag-1000];
}

- (void)scanBigImageWithCurrentIndex:(NSInteger)currentIndex {
    // removeAll
    [self.previewArray removeAllObjects];
    [self.lastArray removeAllObjects];
    
    // 背景
    _backView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    _backView.backgroundColor = [UIColor blackColor];
    _backView.backgroundColor = [UIColor whiteColor];
    [kKeyWindow addSubview:_backView];
    
    
    // scrollview
    
    CGFloat iconW = kScreenWidth-adaptX(20);
    CGFloat iconH = 0;
    
    
    [_backView addSubview:self.mainView];
    for (int i = 0; i < self.imgviewsArr.count; i++) {
        UIView *item = [[UIView alloc] initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, kScreenHeight)];
        item.backgroundColor = krandomColorAlpha(0.8f);
        [item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideAction:)]];
        item.tag = 2000 + i; // tag;
        [self.mainView addSubview:item];
        
        UIImage *img = self.imgviewsArr[i].image;
        iconH = img.size.height/img.size.width *iconW;
        
        UIImageView *icon = [[UIImageView alloc] init];
        icon.image = img;
        icon.frame = CGRectMake((kScreenWidth-iconW)*0.5, (kScreenHeight-iconH)*0.5, iconW, iconH);
        [item addSubview:icon];
        
        
        [self.previewArray addObject:icon];
        [self.lastArray addObject:[NSValue valueWithCGRect:icon.frame]];
        
    }
    
    self.mainView.contentSize = CGSizeMake(kScreenWidth*self.imgviewsArr.count, 0);
    [self.mainView setContentOffset:CGPointMake(kScreenWidth*currentIndex, 0) animated:false];
    
    // pagecontrol
    [_backView addSubview:self.pageIndicator];
    self.pageIndicator.numberOfPages = self.imgviewsArr.count;
    self.pageIndicator.currentPage = currentIndex;

    // 动画
    UIImageView *animationImgView = self.previewArray[currentIndex];
    animationImgView.frame = [self.originArray[currentIndex] CGRectValue];
    
    [UIView animateWithDuration:0.4f animations:^{
        
        animationImgView.frame = [self.lastArray[currentIndex] CGRectValue];
    }];
}

- (void)hideAction:(UITapGestureRecognizer *)sender {
    
    NSInteger currentIndex = sender.view.tag-2000;
    
    [UIView animateWithDuration:0.4f animations:^{
        
        UIImageView *animationImgView = self.previewArray[currentIndex];
        animationImgView.frame = [self.originArray[currentIndex] CGRectValue];
    } completion:^(BOOL finished) {
        [_mainView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [_backView removeFromSuperview];

    }];
    
}

#pragma mark - scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger page = (scrollView.contentOffset.x + kScreenWidth*0.5) / kScreenWidth;
    
    _pageIndicator.currentPage = page;
}

#pragma mark - lazy load
- (NSMutableArray <UIImageView *> *)imgviewsArr {
    if (!_imgviewsArr) {
        _imgviewsArr = [NSMutableArray arrayWithCapacity:5];
    }
    return _imgviewsArr;
}

- (NSMutableArray <UIImageView *> *)previewArray {
    if (!_previewArray) {
        _previewArray = [NSMutableArray arrayWithCapacity:5];
    }
    return _previewArray;
}

- (NSMutableArray *)originArray {
    if (!_originArray) {
        _originArray = [NSMutableArray arrayWithCapacity:5];
    }
    return _originArray;
}

- (NSMutableArray *)lastArray {
    if (!_lastArray) {
        _lastArray = [NSMutableArray arrayWithCapacity:5];
    }
    return _lastArray;
}

@end

