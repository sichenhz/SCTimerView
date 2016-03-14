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

@property (nonatomic, strong) NSTimer *timer;

// SCTimerViewStyleDefault
@property (nonatomic, strong) UILabel *timerLabel;

// SCTimerViewStyleValue1
@property (nonatomic, strong) UIButton *hourTensButton;
@property (nonatomic, strong) UIButton *hourOnesButton;
@property (nonatomic, strong) UIButton *minuteTensButton;
@property (nonatomic, strong) UIButton *minuteOnesButton;
@property (nonatomic, strong) UIButton *secondTensButton;
@property (nonatomic, strong) UIButton *secondOnesButton;
@property (nonatomic, strong) UILabel *leftColonLabel;
@property (nonatomic, strong) UILabel *rightColonLabel;

@end

@implementation SCTimerView

#pragma mark - <Life Cycle>

- (instancetype)initWithStyle:(SCTimerViewStyle)style {
    return [self initWithFrame:CGRectZero style:style];
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame style:SCTimerViewStyleDefault];
}

- (instancetype)initWithFrame:(CGRect)frame style:(SCTimerViewStyle)style {
    if (self = [super initWithFrame:frame]) {
        [self setUpStyle:style];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    switch (self.style) {
        case SCTimerViewStyleDefault:
            self.timerLabel.frame = self.bounds;
            break;
        case SCTimerViewStyleValue1:
        {
            CGFloat margin = 3;
            self.hourTensButton.x = 0;
            self.hourOnesButton.x = CGRectGetMaxX(self.hourTensButton.frame) + margin;
            self.leftColonLabel.x = CGRectGetMaxX(self.hourOnesButton.frame);
            self.minuteTensButton.x = CGRectGetMaxX(self.leftColonLabel.frame);
            self.minuteOnesButton.x = CGRectGetMaxX(self.minuteTensButton.frame) + margin;
            self.rightColonLabel.x = CGRectGetMaxX(self.minuteOnesButton.frame);
            self.secondTensButton.x = CGRectGetMaxX(self.rightColonLabel.frame);
            self.secondOnesButton.x = CGRectGetMaxX(self.secondTensButton.frame) + margin;
        }
            break;
    }
}

#pragma mark - <Private Method>

- (void)setUpStyle:(SCTimerViewStyle)style {
    _style = style;
    switch (_style) {
        case SCTimerViewStyleDefault:
            self.timerLabel = [self createTimerLabel];
            break;
        case SCTimerViewStyleValue1:
            self.hourTensButton = [self createItemLabel];
            self.hourOnesButton = [self createItemLabel];
            self.minuteTensButton = [self createItemLabel];
            self.minuteOnesButton = [self createItemLabel];
            self.secondTensButton = [self createItemLabel];
            self.secondOnesButton = [self createItemLabel];
            self.leftColonLabel = [self createColonLabel];
            self.rightColonLabel = [self createColonLabel];
            break;
    }
}

- (void)setStyle:(SCTimerViewStyle)style {
    [self setUpStyle:style];
}

- (UILabel *)createTimerLabel {
    UILabel *label = [[UILabel alloc] init];
    label.text = @"";
    label.font = [UIFont systemFontOfSize:14];
    [self addSubview:label];
    return label;
}

- (UIButton *)createItemLabel {
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

- (void)updateTime {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.timeInterval >= 0) {
            NSInteger second = (NSInteger)self.timeInterval % 60;
            NSInteger minute = ((NSInteger)self.timeInterval / 60) % 60;
            NSInteger hour = ((NSInteger)self.timeInterval / 3600) % 24;
            NSInteger day = self.timeInterval / 86400;
            switch (_style) {
                case SCTimerViewStyleDefault:
                {
                    NSString *title = @"付尾款剩余时间：";
                    if (day) {
                        self.timerLabel.text = [NSString stringWithFormat:@"%@%zd天%zd时%zd分%zd秒", title, day, hour % 24, minute % 60, second % 60];
                    } else if (hour) {
                        self.timerLabel.text = [NSString stringWithFormat:@"%@%zd时%zd分%zd秒", title, hour % 24, minute % 60, second % 60];
                    } else if (minute) {
                        self.timerLabel.text = [NSString stringWithFormat:@"%@%zd分%zd秒", title, minute % 60, second % 60];
                    } else if (second) {
                        self.timerLabel.text = [NSString stringWithFormat:@"%@%zd秒", title, second % 60];
                    } else {
                        self.timerLabel.text = [NSString stringWithFormat:@"付尾款时间已结束"];
                    }
                }
                    break;
                case SCTimerViewStyleValue1:
                {
                    [self.secondOnesButton setTitle:[NSString stringWithFormat:@"%zd", second % 10] forState:UIControlStateNormal];
                    [self.secondTensButton setTitle:[NSString stringWithFormat:@"%zd", second / 10] forState:UIControlStateNormal];
                    [self.minuteOnesButton setTitle:[NSString stringWithFormat:@"%zd", minute % 10] forState:UIControlStateNormal];
                    [self.minuteTensButton setTitle:[NSString stringWithFormat:@"%zd", minute / 10] forState:UIControlStateNormal];
                    [self.hourOnesButton setTitle:[NSString stringWithFormat:@"%zd", hour % 10] forState:UIControlStateNormal];
                    [self.hourTensButton setTitle:[NSString stringWithFormat:@"%zd", hour / 10] forState:UIControlStateNormal];
                }
                    break;
            }
            if ([self.delegate respondsToSelector:@selector(timerView:didUpdateTimeInterval:)]) {
                [self.delegate timerView:self didUpdateTimeInterval:self.timeInterval];
            }
            self.timeInterval--;
        } else {
            [self stopTimer];
        }
    });
}

#pragma mark - <Public Method>

- (void)startTimer {
    if (self.timeInterval <= 0){
        return;
    }
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    [self updateTime];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
