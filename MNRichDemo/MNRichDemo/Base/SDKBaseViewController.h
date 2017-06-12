//
//  SDKBaseViewController.h
//  RiskControlSDK
//
//  Created by 栾美娜 on 2017/2/15.
//  Copyright © 2017年 栾美娜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDKProjectHeader.h"
#import "SDKCommonService.h"
#import "NSArray+Log.h"
#import "Header.h"

#import "SDKnetwork.h"
#import "SDKNetworkState.h"
#import "SDKNavigationController.h"

// tool
#import "SDKJWTextField.h"
#import "SDKCustomLabel.h"
#import "UIView+CustomView.h"
#import "UIImage+ColorImage.h"
#import "SDKCustomRoundedButton.h"
#import "SDKFormatJudge.h"
#import "SDKJWAlertView.h"
#import "SDKAboutText.h"


// 三方
#import "UIViewController+KeyboardCorver.h"
#import "MBProgressHUD.h"
#import "customHUD.h"
#import "YYModel.h"
#import "UIImageView+WebCache.h"


typedef NS_ENUM(NSInteger, BaseBtnTypeStyle) {
    BaseBtnRightType,
    BaseBtnLeftType
};

@interface SDKBaseViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) customHUD *hud;

#pragma mark  - 失败处理
- (void)errorDispose:(NSInteger)errorCode judgeMent:(NSString *)judgement;
#pragma mark  - 无网络的统一处理
- (void)errorRemind:(NSString *)judgement;

- (void)createTitleBarButtonItemStyle:(BaseBtnTypeStyle)btnStyle title:(NSString *)title TapEvent:(void(^)(void))event;

- (void)createImageBarButtonItemStyle:(BaseBtnTypeStyle)btnStyle Image:(NSString *)image TapEvent:(void(^)(void))event;

- (void)setupNavWithTitle:(NSString *)title;

- (UIBarButtonItem *)createBackButton:(SEL)action;


// 字典转json
- (NSString*)dictionaryToJson:(NSDictionary *)dic;




@end













