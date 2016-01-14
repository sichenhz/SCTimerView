//
//  SCTimerView.m
//  SCTimerView
//
//  Created by sichenwang on 16/1/13.
//  Copyright © 2016年 sichenwang. All rights reserved.
//

#import "SCTimerView.h"

@interface UIView (Extension)

- (void)setX:(CGFloat)x;

@end

@implementation UIView (Extension)

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

@end

@interface SCTimerView()

@property (nonatomic, strong) UIButton *hourTensButton;
@property (nonatomic, strong) UIButton *hourOnesButton;
@property (nonatomic, strong) UIButton *minuteTensButton;
@property (nonatomic, strong) UIButton *minuteOnesButton;
@property (nonatomic, strong) UIButton *secondTensButton;
@property (nonatomic, strong) UIButton *secondOnesButton;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation SCTimerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 111, 21)]) {
        _hourTensButton = [self createTimerLabel];
        _hourOnesButton = [self createTimerLabel];
        _minuteTensButton = [self createTimerLabel];
        _minuteOnesButton = [self createTimerLabel];
        _secondTensButton = [self createTimerLabel];
        _secondOnesButton = [self createTimerLabel];
        UILabel *leftColonLabel = [self createColonLabel];
        UILabel *rightColonLabel = [self createColonLabel];
        
        CGFloat margin = 3;
        _hourTensButton.x = 0;
        _hourOnesButton.x = CGRectGetMaxX(_hourTensButton.frame) + margin;
        leftColonLabel.x = CGRectGetMaxX(_hourOnesButton.frame);
        _minuteTensButton.x = CGRectGetMaxX(leftColonLabel.frame);
        _minuteOnesButton.x = CGRectGetMaxX(_minuteTensButton.frame) + margin;
        rightColonLabel.x = CGRectGetMaxX(_minuteOnesButton.frame);
        _secondTensButton.x = CGRectGetMaxX(rightColonLabel.frame);
        _secondOnesButton.x = CGRectGetMaxX(_secondTensButton.frame) + margin;
    }
    return self;
}

- (UIButton *)createTimerLabel {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 15, 21)];
    button.userInteractionEnabled = NO;
    [button setTitle:@"" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:button];
    return button;
}

- (UILabel *)createColonLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 6, 21)];
    label.text = @":";
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [self addSubview:label];
    return label;
}

- (void)startTimer {
    if (self.timeInterval <= 0){
        return;
    }
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    [self updateTime];
    NSThread *timerThread = [[NSThread alloc] initWithTarget:self selector:@selector(timerStart) object:nil];
    [timerThread start];
}

- (void)stopTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)timerStart {
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    [runLoop run];
}

- (void)updateTime {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.timeInterval >= 0) {
            NSInteger second = (NSInteger)self.timeInterval % 60;
            [self.secondOnesButton setTitle:[NSString stringWithFormat:@"%zd", second % 10] forState:UIControlStateNormal];
            [self.secondTensButton setTitle:[NSString stringWithFormat:@"%zd", second / 10] forState:UIControlStateNormal];
            NSInteger minute = ((NSInteger)self.timeInterval / 60) % 60;
            [self.minuteOnesButton setTitle:[NSString stringWithFormat:@"%zd", minute % 10] forState:UIControlStateNormal];
            [self.minuteTensButton setTitle:[NSString stringWithFormat:@"%zd", minute / 10] forState:UIControlStateNormal];
            NSInteger hour = self.timeInterval / 3600;
            [self.hourOnesButton setTitle:[NSString stringWithFormat:@"%zd", hour % 10] forState:UIControlStateNormal];
            [self.hourTensButton setTitle:[NSString stringWithFormat:@"%zd", hour / 10] forState:UIControlStateNormal];
            if ([self.delegate respondsToSelector:@selector(timerView:didUpdateTimeInterval:)]) {
                [self.delegate timerView:self didUpdateTimeInterval:self.timeInterval];
            }
            self.timeInterval--;
        } else {
            [self stopTimer];
        }
    });
}

@end
