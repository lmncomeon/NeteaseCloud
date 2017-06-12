//
//  MNMusicViewController.m
//  MNRichDemo
//
//  Created by 栾美娜 on 2017/6/6.
//  Copyright © 2017年 栾美娜. All rights reserved.
//

#import "MNMusicViewController.h"

@interface MNMusicViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) BOOL canScroll;

@end

static NSString *const cellID = @"UITableViewCellID";

@implementation MNMusicViewController

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _mainTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _mainTableView.dataSource = self;
        _mainTableView.delegate   = self;
        _mainTableView.rowHeight  = adaptY(60);
        [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
        [self.view addSubview:_mainTableView];
    }
    return _mainTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self mainTableView];
    
    
}

- (void)setListArray:(NSArray *)listArray {
    _listArray = listArray;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.mainTableView reloadData];
    });
}

#pragma mark - tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 8;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    cell.imageView.image = [UIImage imageNamed:@"huba"];
    cell.textLabel.text = self.listArray[indexPath.row];
    cell.detailTextLabel.text = @"播放次数";
    
    return cell;
}

#pragma mark - tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return adaptY(20);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, adaptY(20))];
    header.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    SDKCustomLabel *lab = [SDKCustomLabel setLabelTitle:@"歌单1" setLabelFrame:CGRectMake(adaptX(16), 0, kScreenWidth-2*adaptX(16), adaptY(20)) setLabelColor:[UIColor blackColor] setLabelFont:kFont(10)];
    [header addSubview:lab];
    
    return header;
}

#pragma mark - scrollview delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

#pragma mark - dealloc
-(void)dealloc{
    
}

@end
