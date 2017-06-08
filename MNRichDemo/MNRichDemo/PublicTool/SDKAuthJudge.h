//
//  SDKAuthJudge.h
//  handheldCredit
//
//  Created by 栾美娜 on 2017/4/21.
//  Copyright © 2017年 liguiwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDKAuthJudge : NSObject

// iOS是否越狱
+ (BOOL)isJailBreak;

// 获取通讯录权限
+ (void)getAddressAuthWithResult:(void(^)(BOOL res))result;

// 检查通讯权限
+ (void)checkAddressAuthWithResult:(void(^)(BOOL res))result;

// 获取相册权限
+ (void)getAlbumAuthWithResult:(void(^)(BOOL res))result;

// 检查相册权限
+ (void)checkoutAlbumAuthWithResult:(void(^)(BOOL res))result;


@end
