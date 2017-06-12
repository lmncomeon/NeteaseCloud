//
//  MNCollectionViewController.m
//  MNRichDemo
//
//  Created by 栾美娜 on 2017/6/9.
//  Copyright © 2017年 栾美娜. All rights reserved.
//

#import "MNCollectionViewController.h"
#import "MNCollectionReusableHeaderView.h"
#import "MNItemCell.h"

@interface MNCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIImageView *bgView;

@property (nonatomic, strong) UIView *navigationView;
@property (nonatomic, strong) SDKCustomLabel *titleLab;

@property (nonatomic, strong) UICollectionView *mainColletionView;

@end

static NSString *const cellID_collection   = @"MNItemCellID";

static NSString *const headerID_collection = @"MNCollectionReusableHeaderViewID";

@implementation MNCollectionViewController

/** 背景图 */
- (UIImageView *)bgView {
    if (!_bgView) {
        _bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, adaptY(136)+64)];
        _bgView.clipsToBounds = YES;
        _bgView.contentMode = UIViewContentModeScaleAspectFill;
        _bgView.image = [UIImage imageNamed:@"bg_big"];
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

- (UICollectionView *)mainColletionView {
    if (!_mainColletionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(kScreenWidth, kScreenHeight-64);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.headerReferenceSize = CGSizeMake(kScreenWidth, adaptY(136));
        
        _mainColletionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationView.frame), kScreenWidth, kScreenHeight-64) collectionViewLayout:layout];
        _mainColletionView.backgroundColor = [UIColor clearColor];
        
        [self.view addSubview:_mainColletionView];
        
        _mainColletionView.dataSource = self;
        _mainColletionView.delegate   = self;
        // register
        [_mainColletionView registerClass:[MNItemCell class] forCellWithReuseIdentifier:cellID_collection];
        [_mainColletionView registerClass:[MNCollectionReusableHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID_collection];

    }
    return _mainColletionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self bgView];
    [self mainColletionView];
    
        
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = true;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = false;
}

#pragma mark - collectionView delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MNItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID_collection forIndexPath:indexPath];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        MNCollectionReusableHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID_collection forIndexPath:indexPath];
        reusableview = headerView;
    }

    return reusableview;
}

#pragma mark - scrollview delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    /***==================== 垂直滑动 ================***/
    if (scrollView == _mainColletionView)
    {
        CGFloat offsetY = scrollView.contentOffset.y; //滚动Y值
        
        //---------- 加图片拉伸动画 -----
        if (offsetY < 0) {
            _bgView.frame = CGRectMake(0, 0, kScreenWidth, adaptY(136)+64-offsetY);
        }
        
        // ----  加导航栏标题动画 -----
        if (offsetY >= adaptY(52)) {
            _titleLab.hidden = false;
        } else {
            _titleLab.hidden = true;
        }
        
        
        // --- 为了切换模式停留(补充) --
        if (offsetY > 2) {
            _mainColletionView.bounces = false;
        } else {
            _mainColletionView.bounces = true;
            
        }
    }

}

#pragma mark - 返回
- (void)backAction {
    [self.navigationController popViewControllerAnimated:true];
}

@end
