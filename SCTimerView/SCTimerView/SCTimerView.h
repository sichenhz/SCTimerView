//
//  SCTimerView.h
//  SCTimerView
//
//  Created by sichenwang on 16/1/13.
//  Copyright © 2016年 sichenwang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SCTimerView;

@protocol SCTimerViewDelegate <NSObject>
@optional
- (void)timerView:(SCTimerView *)timerView didUpdateTimeInterval:(NSTimeInterval)timeInterval;

@end

@interface SCTimerView : UIView

@property (nonatomic, weak) id<SCTimerViewDelegate> delegate;
@property (nonatomic, assign) NSTimeInterval timeInterval;

- (void)startTimer;
- (void)stopTimer;

@end