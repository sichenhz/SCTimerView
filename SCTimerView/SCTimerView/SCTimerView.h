//
//  SCTimerView.h
//  SCTimerView
//
//  Created by sichenwang on 16/1/13.
//  Copyright © 2016年 sichenwang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SCTimerView;

typedef NS_ENUM(NSInteger, SCTimerViewStyle) {
    SCTimerViewStyleDefault,       // regular timer view
    SCTimerViewStyleValue1         // preferences style timer view
};

@protocol SCTimerViewDelegate <NSObject>
@optional
- (void)timerView:(SCTimerView *)timerView didUpdateTimeInterval:(NSTimeInterval)timeInterval;

@end

@interface SCTimerView : UIView

- (instancetype)initWithStyle:(SCTimerViewStyle)style; // must specify style at creation. -init: calls this with SCTimerViewStyleDefault
- (instancetype)initWithFrame:(CGRect)frame style:(SCTimerViewStyle)style NS_DESIGNATED_INITIALIZER; // must specify style at creation. -initWithFrame: calls this with SCTimerViewStyleDefault
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

#if TARGET_INTERFACE_BUILDER
@property (nonatomic, assign) IBInspectable NSInteger style;
#else
@property (nonatomic, assign, readonly) SCTimerViewStyle style;
#endif

@property (nonatomic, weak) id<SCTimerViewDelegate> delegate;
@property (nonatomic, assign) NSTimeInterval timeInterval;

- (void)startTimer;
- (void)stopTimer;

@end