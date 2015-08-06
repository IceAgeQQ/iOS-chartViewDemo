//
//  ViewController.h
//  iOS-Chart-Demo
//
//  Created by Chao Xu on 15/8/1.
//  Copyright (c) 2015年 Chao Xu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TelerikUI/TelerikUI.h>
#import <QuartzCore/QuartzCore.h>
#import "DLPieChart.h"

@interface ViewController : UIViewController

@property (strong,nonatomic) IBOutlet TKChart *chartView;
@property (strong,nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (strong,nonatomic) IBOutlet DLPieChart *pieView;
@end

