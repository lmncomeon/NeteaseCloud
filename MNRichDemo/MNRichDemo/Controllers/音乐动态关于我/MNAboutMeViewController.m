//
//  MNAboutMeViewController.m
//  MNRichDemo
//
//  Created by 栾美娜 on 2017/6/6.
//  Copyright © 2017年 栾美娜. All rights reserved.
//

#import "MNAboutMeViewController.h"

@interface MNAboutMeViewController ()

@end

@implementation MNAboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blueColor];
    
 
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, adaptY(20))];
    header.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:header];
    
    SDKCustomLabel *lab = [SDKCustomLabel setLabelTitle:@"歌单1" setLabelFrame:CGRectMake(adaptX(16), 0, kScreenWidth-2*adaptX(16), adaptY(20)) setLabelColor:[UIColor blackColor] setLabelFont:kFont(10)];
    [header addSubview:lab];
}

#pragma mark - dealloc
- (void)dealloc {
    
}

@end
