//
//  SDKAuthJudge.m
//  handheldCredit
//
//  Created by 栾美娜 on 2017/4/21.
//  Copyright © 2017年 liguiwen. All rights reserved.
//

#import "SDKAuthJudge.h"
#import "SDKProjectHeader.h"
// address
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <ContactsUI/ContactsUI.h>
// album
#import <Photos/Photos.h>

#define ARRAY_SIZE(a) sizeof(a)/sizeof(a[0])

@implementation SDKAuthJudge

// iOS是否越狱
+ (BOOL)isJailBreak
{
    for (int i=0; i<ARRAY_SIZE(jailbreak_tool_pathes); i++) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithUTF8String:jailbreak_tool_pathes[i]]]) {
            NSLog(@"The device is jail broken!");
            return YES;
        }
    }
    NSLog(@"The device is NOT jail broken!");
    return NO;
}

const char* jailbreak_tool_pathes[] = {
    "/Applications/Cydia.app",
    "/Library/MobileSubstrate/MobileSubstrate.dylib",
    "/bin/bash",
    "/usr/sbin/sshd",
    "/etc/apt"
};

// 获取通讯录权限
+ (void)getAddressAuthWithResult:(void(^)(BOOL res))result {
    if (iOS9)
    {
        // 获取通讯录权限
        CNContactStore * contactStore = [[CNContactStore alloc]init];
        
        [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                
                if (result) {
                    result(true);
                }
                
            }else{
                if (result) {
                    result(false);
                }
            }
        }];
        
    }
    else
    {
        // 获取通讯录权限
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            if (granted) {
                CFRelease(addressBook);
                
                if (result) {
                    result(true);
                }
            }else{
                if (result) {
                    result(false);
                }
            }
        });
        
    }


}

// 检查通讯权限
+ (void)checkAddressAuthWithResult:(void(^)(BOOL res))result {
    if (iOS9)
    {
        // 检查是否有通讯录权限
        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        if (status == CNAuthorizationStatusAuthorized) {
            if (result) {
                result(true);
            }
        }
        else
        {
            if (result) {
                result(false);
            }
        }
        
        
    }
    else
    {
        // 检查是否有通讯录权限
        ABAuthorizationStatus ABstatus = ABAddressBookGetAuthorizationStatus();
        if (ABstatus == kABAuthorizationStatusAuthorized) {
            if (result) {
                result(true);
            }
        }
        else
        {
            if (result) {
                result(false);
            }
        }
        
        
    }
}

// 获取相册权限
+ (void)getAlbumAuthWithResult:(void(^)(BOOL res))result {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            if (result) {
                result(true);
            }
        }else{
            if (result) {
                result(false);
            }
        }
    }];

}

// 检查相册权限
+ (void)checkoutAlbumAuthWithResult:(void(^)(BOOL res))result {
    if (iOS8) {
        PHAuthorizationStatus photoAuthorStatus = [PHPhotoLibrary authorizationStatus];
        if (photoAuthorStatus == PHAuthorizationStatusAuthorized) {
            if (result) {
                result(true);
            }
        }else{
            if (result) {
                result(false);
            }
        }
    }
}

@end
