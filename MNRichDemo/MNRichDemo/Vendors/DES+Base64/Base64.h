//
//  Base64.h
//  LesDo
//
//  Created by xindaoapp on 13-8-29.
//  Copyright (c) 2013年 xin wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Base64 : NSObject
+(NSString *)encode:(NSData *)data;
+(NSData *)decode:(NSString *)data;

+ (NSString *)encodeToString:(NSString *)string;
+ (NSString *)decodeForNSString:(NSString *)data;
@end
