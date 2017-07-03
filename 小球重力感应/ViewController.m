//
//  ViewController.m
//  小球重力感应
//
//  Created by Josie on 2017/7/2.
//  Copyright © 2017年 Josie. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreMotion/CoreMotion.h>



@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    CMMotionManager *motionManager = [[CMMotionManager alloc]init];
    if (!motionManager.accelerometerAvailable) {
        // fail code // 检查传感器到底在设备上是否可用
    }
    motionManager.accelerometerUpdateInterval = 0.01; // 告诉manager，更新频率是100Hz
    
    /* 加速度传感器开始采样，每次采样结果在block中处理 */
    // 开始更新，后台线程开始运行。
    [motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
     {
         CMAccelerometerData *newestAccel = motionManager.accelerometerData;
         double accelerationX = newestAccel.acceleration.x;
         double accelerationY = newestAccel.acceleration.y;
         
         
         double ra = atan2(-accelerationY, accelerationX); // 返回值的单位为弧度，atan2(x,y)返回的是点(x,y)与x轴的夹角
         double degree = ra * 180 / M_PI;
         NSLog(@"----- %f ----", degree);
         
         self.arrowImageView.transform = CGAffineTransformMakeRotation(ra + M_PI_2);

         
     }];
    
    
}



@end
