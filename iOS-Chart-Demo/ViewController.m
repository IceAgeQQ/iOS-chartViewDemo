//
//  ViewController.m
//  iOS-Chart-Demo
//
//  Created by Chao Xu on 15/8/1.
//  Copyright (c) 2015年 Chao Xu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController{
    UIDynamicAnimator *_animator;
    NSMutableArray *_points,*dataArray;
}

@synthesize segmentControl;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadChartView];
    self.pieView.hidden = YES;

}
- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (IBAction)segmentValueChanged:(id)sender {
    if (segmentControl.selectedSegmentIndex == 0) {
        [_chartView reloadData];
        [NSTimer scheduledTimerWithTimeInterval:4.0
                                         target:self
                                       selector:@selector(applyGravityEffectAfterTimer)
                                       userInfo:nil
                                        repeats:NO];
        _chartView.hidden = NO;
        _pieView.hidden = YES;
    }else if (segmentControl.selectedSegmentIndex == 1){
        [self pieChart];
        _pieView.hidden = NO;
        _chartView.hidden = YES;
    }else{
        NSLog(@"hello world");
    }
}
- (void)pieChart {
    dataArray = [[NSMutableArray alloc] init];
    for (int i =0; i<5; i++) {
        //random number generator
        NSNumber *number = [NSNumber numberWithInt:rand()%60+20];
        //add number to array
        [dataArray addObject:number];
    }
    //call DLPiechart method
    [self.pieView renderInLayer:_pieView dataArray:dataArray];
}

- (void)loadChartView {
    [NSTimer scheduledTimerWithTimeInterval:4.0
                                     target:self
                                   selector:@selector(applyGravityEffectAfterTimer)
                                   userInfo:nil
                                    repeats:NO];
    
    _points = [[NSMutableArray alloc] init];
    for (int i=0; i<10; i++) {
        [_points addObject:[[TKChartDataPoint alloc] initWithX:@(i) Y:@(arc4random()%300)]];
    }
    
    TKChartLineSeries *lineSeries = [[TKChartLineSeries alloc] initWithItems:_points];
    lineSeries.selectionMode = TKChartSeriesSelectionModeDataPoint;
    lineSeries.style.pointShape = [[TKPredefinedShape alloc] initWithType:TKShapeTypeCircle andSize:CGSizeMake(15, 15)];
    lineSeries.style.shapeMode = TKChartSeriesStyleShapeModeAlwaysShow;
    [_chartView addSeries: lineSeries];
    
    _chartView.yAxis.style.labelStyle.textHidden = YES;
    _chartView.allowAnimations = YES;
    
//    [_chartView reloadData];

}

- (void) applyGravityEffectAfterTimer {
    
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:_chartView.plotView];
    
    NSArray *points = [_chartView visualPointsForSeries:_chartView.series[0]];
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:points];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:points];
    gravity.gravityDirection = CGVectorMake(0.f, 2.f);
    
    UIDynamicItemBehavior *dynamic = [[UIDynamicItemBehavior alloc] initWithItems:points];
    dynamic.elasticity = 0.5f;
    
    [_animator addBehavior:dynamic];
    [_animator addBehavior:gravity];
    [_animator addBehavior:collision];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
