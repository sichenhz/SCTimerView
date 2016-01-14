//
//  ViewController.m
//  SCTimerView
//
//  Created by sichenwang on 16/1/13.
//  Copyright © 2016年 sichenwang. All rights reserved.
//

#import "ViewController.h"
#import "SCTimerView.h"

@interface ViewController ()<SCTimerViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    SCTimerView *timerView = [[SCTimerView alloc] init];
    timerView.delegate = self;
    timerView.timeInterval = 10;
    [timerView startTimer];
    
    timerView.center = self.view.center;
    [self.contentView addSubview:timerView];
}

- (void)timerView:(SCTimerView *)timerView didUpdateTimeInterval:(NSTimeInterval)timeInterval {
    NSLog(@"%f",timeInterval);
}
@end
