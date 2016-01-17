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
    
    [self createTimerView1];
    [self createTimerView2];
}

- (void)createTimerView1 {
    SCTimerView *timerView = [[SCTimerView alloc] initWithFrame:CGRectMake(50, 250, 210, 21) style:SCTimerViewStyleDefault];
    timerView.delegate = self;
    timerView.timeInterval = 7200;
    [timerView startTimer];
    [self.contentView addSubview:timerView];
}

- (void)createTimerView2 {
    SCTimerView *timerView = [[SCTimerView alloc] initWithFrame:CGRectMake(50, 300, 111, 21) style:SCTimerViewStyleValue1];
    timerView.delegate = self;
    timerView.timeInterval = 7200;
    [timerView startTimer];
    [self.contentView addSubview:timerView];
}

- (void)timerView:(SCTimerView *)timerView didUpdateTimeInterval:(NSTimeInterval)timeInterval {
    NSLog(@"%f",timeInterval);
}
@end
