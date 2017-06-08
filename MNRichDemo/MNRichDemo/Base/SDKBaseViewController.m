//
//  SDKBaseViewController.m
//  RiskControlSDK
//
//  Created by 栾美娜 on 2017/2/15.
//  Copyright © 2017年 栾美娜. All rights reserved.
//

#import "SDKBaseViewController.h"
#import "SDKTTooltipView.h"


@interface SDKBaseViewController () <SDKJWAlertViewDelegate>

@property (nonatomic, copy) dispatch_block_t tapleftBarButtonItemEvent;

@property (nonatomic, copy) dispatch_block_t taprightBarButtonItemEvent;

@property (nonatomic, copy) dispatch_block_t tapimageleftBarButtonItemEvent;

@property (nonatomic, copy) dispatch_block_t tapimagerightBarButtonItemEvent;

@property (nonatomic, strong) SDKJWAlertView *backAlert;

@end

@implementation SDKBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark  - 失败处理
- (void)errorDispose:(NSInteger)errorCode judgeMent:(NSString *)judgement{
    
    DLog(@"\n错误代码：%ld\n错误信息：%@", (long)errorCode, judgement);
    if (errorCode == 401) { // token 失效
        
        
//        //请求新token
//        [SDKCommonService requestAccesstokenWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//            if ([[responseObject objectForKey:@"errorCode"] integerValue] == 0) {
//                // 存储
//                [[NSUserDefaults standardUserDefaults] setObject:[responseObject objectForKey:@"data"] forKey:keyName_token];
////                [[NSUserDefaults standardUserDefaults] setObject:@0 forKey:kUIDName];
//            }else{
//            }
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            
//        }];
        [self dismissViewControllerAnimated:true completion:nil];
        
        UINavigationController * nav  = self.navigationController;
        [nav popToRootViewControllerAnimated:true];
    }else if (errorCode >= 500 && errorCode <= 599) {
        showTip(@"服务器出现故障，我们正在全力抢修，请您稍后");
    }else{

    }
}
#pragma mark  - 无网络的统一处理
- (void)errorRemind:(NSString *)judgement{
    // judgement -> 防止产品汪要做的其他特殊处理。
    showTip(@"请检查您的网络情况！");
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}


- (void)createTitleBarButtonItemStyle:(BaseBtnTypeStyle)btnStyle title:(NSString *)title TapEvent:(void(^)(void))event{
    UIBarButtonItem *buttonItem;
    [buttonItem setTintColor:UIColorFromRGB(0x646563)];
    if (btnStyle==BaseBtnRightType) {
        buttonItem= [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(titleTapRightBar)];
        self.navigationItem.rightBarButtonItem = buttonItem;
        self.taprightBarButtonItemEvent = event;
    }else if (btnStyle==BaseBtnLeftType){
        buttonItem= [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(titleTapLeftBar)];
        self.navigationItem.leftBarButtonItem = buttonItem;
        self.tapleftBarButtonItemEvent = event;
    }
}
- (void)createImageBarButtonItemStyle:(BaseBtnTypeStyle)btnStyle Image:(NSString *)image TapEvent:(void(^)(void))event{
    UIButton * settingButton = [UIButton buttonWithType:UIButtonTypeSystem];
    if (kScreenWidth <= 320) {
        settingButton.frame = CGRectMake(280, 10, 24, 24);
    }else if (kScreenWidth > 320) {
        settingButton.frame = CGRectMake(280, 7.6, 28.8, 28.8);
    }
    [settingButton setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:settingButton];
    if (btnStyle==BaseBtnRightType) {
        self.navigationItem.rightBarButtonItem = buttonItem;
        self.tapimagerightBarButtonItemEvent = event;
        [settingButton addTarget:self action:@selector(tapimagerightBar) forControlEvents:UIControlEventTouchUpInside];
    }else if (btnStyle==BaseBtnLeftType){
        self.tapimageleftBarButtonItemEvent  = event;
        [settingButton addTarget:self action:@selector(tapimageleftBar) forControlEvents:UIControlEventTouchUpInside];
    }
}
-(void)titleTapRightBar{!self.taprightBarButtonItemEvent ? nil:self.taprightBarButtonItemEvent();}
-(void)titleTapLeftBar{!self.tapleftBarButtonItemEvent ? nil:self.tapleftBarButtonItemEvent();}
-(void)tapimagerightBar{!self.tapimagerightBarButtonItemEvent ? nil:self.tapimagerightBarButtonItemEvent();}
-(void)tapimageleftBar{!self.tapimageleftBarButtonItemEvent ? nil:self.tapimageleftBarButtonItemEvent();}

- (void)setupNavWithTitle:(NSString *)title {
    self.navigationItem.titleView = ({
        UILabel *titleLab = [UILabel new];
        titleLab.frame = CGRectMake(0, 0, 80, 30);
        titleLab.text = title;
        titleLab.textAlignment = 1;
        titleLab.font = kFont(17);
        titleLab.textColor = kNavTitleColor;
        titleLab;
    });
}

- (UIBarButtonItem *)createBackButton:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setImage:[UIImage imageNamed:@"RiskControlBundle.bundle/arrow_back_white"]
            forState:UIControlStateNormal];
    button.tintColor = commonBlackColor;
    [button addTarget:self action:action
     forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, (44-adaptX(18))*0.5, adaptX(18), adaptX(18));
    
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return menuButton;
}

// 字典转json
- (NSString*)dictionaryToJson:(NSDictionary *)dic{
    if (dic == nil) {
        return nil;
    }
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];

    if ([jsonData length] > 0 && parseError == nil){
        DLog(@"Successfully serialized the dictionary into data.");
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    return nil;

}


@end













