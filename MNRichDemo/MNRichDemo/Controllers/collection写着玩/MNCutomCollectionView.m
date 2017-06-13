//
//  MNCutomCollectionView.m
//  MNRichDemo
//
//  Created by 栾美娜 on 2017/6/12.
//  Copyright © 2017年 栾美娜. All rights reserved.
//

#import "MNCutomCollectionView.h"

@implementation MNCutomCollectionView

/**
 同时识别多个手势
 
 @param gestureRecognizer gestureRecognizer description
 @param otherGestureRecognizer otherGestureRecognizer description
 @return return value description
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end


