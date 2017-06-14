//
//  MNControllerModel.m
//  MNRichDemo
//
//  Created by 栾美娜 on 2017/6/8.
//  Copyright © 2017年 栾美娜. All rights reserved.
//

#import "MNControllerModel.h"

@implementation MNControllerModel

+ (MNControllerModel *)modelWithClassName:(NSString *)className text:(NSString *)text {
    MNControllerModel *model = [MNControllerModel new];
    model.className = className;
    model.text      = text;
    
    return model;
}

+ (NSArray *)getListDataSource {
    NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:5];
    [tmp addObject:[MNControllerModel modelWithClassName:@"MNViewController0" text:@"网易云写着玩"]];
    [tmp addObject:[MNControllerModel modelWithClassName:@"MNViewController1" text:@"网易云复杂页面"]];
    [tmp addObject:[MNControllerModel modelWithClassName:@"MNCollectionViewController" text:@"collection写着玩"]];
    [tmp addObject:[MNControllerModel modelWithClassName:@"MNPhotosViewController" text:@"图片预览"]];
    [tmp addObject:[MNControllerModel modelWithClassName:@"MNAppListViewController" text:@"获取所有app"]];
    
    
    return tmp.copy;
}

@end
