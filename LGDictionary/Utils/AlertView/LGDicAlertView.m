//
//  LGDicAlertView.m
//  LGDictionaryDemo
//
//  Created by 刘亚军 on 2018/9/27.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import "LGDicAlertView.h"

@interface LGDicAlertView ()
@property (nonatomic,strong) UILabel *contentL;
@end
@implementation LGDicAlertView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.contentL];
        self.contentL.frame = self.bounds;
        self.contentL.center = self.center;
        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor darkGrayColor];
    }
    return self;
}
+ (void)showWithText:(NSString *)text{
    LGDicAlertView *alertView = [[LGDicAlertView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width*0.6, 44)];
    alertView.contentL.text = text;
    [alertView show];
}
- (void)show{
    __weak typeof(self) weakSelf = self;
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    self.center = rootWindow.center;
    self.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        weakSelf.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [weakSelf hide];
        });
    }];
}
- (void)hide{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}
- (UILabel *)contentL{
    if (!_contentL) {
        _contentL = [UILabel new];
        _contentL.font = [UIFont systemFontOfSize:17];
        _contentL.textAlignment = NSTextAlignmentCenter;
        _contentL.textColor = [UIColor whiteColor];
    }
    return _contentL;
}
@end
