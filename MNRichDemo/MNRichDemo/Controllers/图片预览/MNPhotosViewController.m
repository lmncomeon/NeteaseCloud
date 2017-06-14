//
//  MNPhotosViewController.m
//  MNRichDemo
//
//  Created by 栾美娜 on 2017/6/13.
//  Copyright © 2017年 栾美娜. All rights reserved.
//

#import "MNPhotosViewController.h"
#import "MNPhotosView.h"

@interface MNPhotosViewController ()

@property (nonatomic, strong) MNPhotosView *photos;

@end

@implementation MNPhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *namesArr = [NSMutableArray arrayWithCapacity:5];
    
    for (int i = 0; i < 8; i++) {
        [namesArr addObject:[NSString stringWithFormat:@"photo_%d", i%8]];
    }
    
    
    _photos = [[MNPhotosView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 0) list:namesArr];
    [self.view addSubview:_photos];
}

@end
