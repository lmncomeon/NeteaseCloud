//
//  ViewController.m
//  MNRichDemo
//
//  Created by 栾美娜 on 2017/6/5.
//  Copyright © 2017年 栾美娜. All rights reserved.
//

#import "ViewController.h"
#import "MNControllerModel.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *maintTableview;

@property (nonatomic, strong) NSArray <MNControllerModel *> *controllersArray;

@end

static NSString *const UITableViewCellID = @"UITableViewCell";

@implementation ViewController



- (UITableView *)maintTableview {
    if (!_maintTableview) {
        _maintTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _maintTableview.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _maintTableview.dataSource      = self;
        _maintTableview.delegate  = self;
        _maintTableview.rowHeight = adaptY(45);
        [self.view addSubview:_maintTableview];
        
    }
    return _maintTableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self maintTableview];
    
}

#pragma mark - tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.controllersArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UITableViewCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:UITableViewCellID];
    }
    
    cell.textLabel.text = self.controllersArray[indexPath.row].text;
    
    return cell;
}

#pragma mark - tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Class class = NSClassFromString(self.controllersArray[indexPath.row].className);
    
    if (class && [class isSubclassOfClass:[UIViewController class]]) {
        [self.navigationController pushViewController:[class new] animated:true];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

#pragma mark - setup array
- (NSArray <MNControllerModel *> *)controllersArray {
    if (!_controllersArray) {
        _controllersArray = [MNControllerModel getListDataSource];
    }
    return _controllersArray;
}
@end
