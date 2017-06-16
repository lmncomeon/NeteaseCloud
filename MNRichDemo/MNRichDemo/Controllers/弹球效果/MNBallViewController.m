//
//  MNBallViewController.m
//  MNRichDemo
//
//  Created by 栾美娜 on 2017/6/16.
//  Copyright © 2017年 栾美娜. All rights reserved.
//

#import "MNBallViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface MNBallViewController ()

@property (nonatomic, strong) UIDynamicAnimator *dynamicAnimator;
@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, strong) UIGravityBehavior *gravityBehavior;

@property (nonatomic, strong) NSMutableArray *imgArr;

@end

@implementation MNBallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _motionManager = [CMMotionManager new];
    _motionManager.accelerometerUpdateInterval = 1/60;
    self.gravityBehavior = [UIGravityBehavior new];
    
    if([_motionManager isAccelerometerAvailable])
    {
        
        [_motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            
            double rotation = atan2(motion.attitude.pitch, motion.attitude.roll);
            
            self.gravityBehavior.angle = rotation;
            
        }];
        
        
    }
    
    _imgArr = [NSMutableArray arrayWithCapacity:5];
    for (int i = 0; i < 20; i++) {
        int a = i /4;
        int b = i %4;
        
        UIImageView *imageb = [[UIImageView alloc] initWithFrame:CGRectMake(10+b*50, 20+a*50, 50, 50)];
        imageb.image = [UIImage imageNamed:@"smiley"];
        [self.view addSubview:imageb];
        
        [_imgArr addObject:imageb];
    }
    
    
    _dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    [self testfunc];
    
    
}

- (void)testfunc {
    //创建并添加重力行为
    self.gravityBehavior = [[UIGravityBehavior alloc] initWithItems:_imgArr];
    [self.dynamicAnimator addBehavior:self.gravityBehavior];
    
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:self.imgArr];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = true;
    [self.dynamicAnimator addBehavior:collisionBehavior];
    
}

@end
