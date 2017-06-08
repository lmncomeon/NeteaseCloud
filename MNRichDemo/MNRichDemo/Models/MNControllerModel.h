//
//  MNControllerModel.h
//  MNRichDemo
//
//  Created by 栾美娜 on 2017/6/8.
//  Copyright © 2017年 栾美娜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MNControllerModel : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *className;

+ (MNControllerModel *)modelWithClassName:(NSString *)className text:(NSString *)text;

+ (NSArray *)getListDataSource;

@end
