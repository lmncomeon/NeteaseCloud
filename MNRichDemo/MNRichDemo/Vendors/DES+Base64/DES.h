//
//  DES.h
//  LesDo
//
//  Created by xindaoapp on 13-8-28.
//  Copyright (c) 2013年 xin wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

@interface DES : NSObject
/**
 DES加密 
 */
//+(NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;
+ (NSString*)encrypt:(NSString*)plainText key:(NSString *)key;
//
///**
// DES解密
// */
//+(NSString *) decryptUseDES:(NSString *)cipherText key:(NSString *)key;
+ (NSString*)decrypt:(NSString*)encryptText key:(NSString *)key;

@end
