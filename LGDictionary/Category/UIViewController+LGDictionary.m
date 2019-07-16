//
//  UIViewController+LGDictionary.m
//  LGDictionaryDemo
//
//  Created by 刘亚军 on 2018/9/27.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import "UIViewController+LGDictionary.h"
#import <objc/runtime.h>
#import <Masonry/Masonry.h>
#import <YJActivityIndicatorView/YJActivityIndicatorView.h>
#import "LGDictionaryConst.h"
#import "NSBundle+LGDictionary.h"

static char *loadingViewKey = "loadingView";
static char *noDataViewKey = "noDataView";
static char *noDataTextKey = "noDataText";
static char *loadErrorViewKey = "loadErrorView";
static char *loadErrorTextKey = "loadErrorText";
static char *updateDateBlockKey = "updateDateBlock";

@implementation UIViewController (LGDictionary)

- (void)lg_setLoadingViewShow:(BOOL)show{
    [self initLoadingView];
    [self.noDataView removeFromSuperview];
    [self.loadErrorView removeFromSuperview];
    [self setShowOnBackgroundView:self.loadingView show:show];
}
- (void)lg_setNoDataViewShow:(BOOL)show{
    [self initNoDataView];
    [self.loadingView removeFromSuperview];
    [self.loadErrorView removeFromSuperview];
    [self setShowOnBackgroundView:self.noDataView show:show];
}
- (void)lg_setLoadErrorViewShow:(BOOL)show{
    [self initLoadErrorView];
    [self.loadingView removeFromSuperview];
    [self.noDataView removeFromSuperview];
    [self setShowOnBackgroundView:self.loadErrorView show:show];
}
- (void)setShowOnBackgroundView:(UIView *)aView show:(BOOL)show {
    if (!aView) {
        return;
    }
    if (show) {
        if (aView.superview) {
            [aView removeFromSuperview];
        }
        [self.view addSubview:aView];
        [aView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    else {
        [aView removeFromSuperview];
    }
}
- (void)initLoadingView{
    if (!self.loadingView) {
        self.loadingView = [[UIView alloc] init];
        self.loadingView.backgroundColor = LGDictionaryColorHex(0xEDEDED);
        YJActivityIndicatorView *activityIndicatorView = [[YJActivityIndicatorView alloc] initWithType:YJActivityIndicatorAnimationTypeBallPulse tintColor:LGDictionaryColorHex(0x989898)];
        [self.loadingView addSubview:activityIndicatorView];
        [activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.loadingView);
            make.width.height.mas_equalTo(100);
        }];
        [activityIndicatorView startAnimating];
    }
}
- (void)initNoDataView{
    if (!self.noDataView) {
        self.noDataView = [[UIView alloc]init];
        self.noDataView.backgroundColor = LGDictionaryColorHex(0xEDEDED);
        UIImageView *img = [[UIImageView alloc] initWithImage:[NSBundle lgd_imageName:@"lg_statusView_empty"]];
        [ self.noDataView addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.noDataView);
            make.centerY.equalTo(self.noDataView).offset(-10);
        }];
        UILabel *lab = [[UILabel alloc] init];
        lab.tag = 11;
        lab.font = [UIFont systemFontOfSize:14];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor =  LGDictionaryColorHex(0x989898);
        if (self.noDataText && self.noDataText.length > 0) {
            lab.text = self.noDataText;
        }else{
            lab.text = LGDictionaryNoDataText;
        }
        [ self.noDataView addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.width.equalTo(self.noDataView);
            make.top.equalTo(img.mas_bottom).offset(18);
        }];
    }else{
        UILabel *lab = [self.noDataView viewWithTag:11];
        if (lab) {
            if (self.noDataText && self.noDataText.length > 0) {
                lab.text = self.noDataText;
            }else{
                lab.text = LGDictionaryNoDataText;
            }
        }
    }
}
- (void)initLoadErrorView{
    if (!self.loadErrorView) {
        self.loadErrorView = [[UIView alloc]init];
        self.loadErrorView.backgroundColor = LGDictionaryColorHex(0xEDEDED);
        UIImageView *img = [[UIImageView alloc]initWithImage:[NSBundle lgd_imageName:@"lg_statusView_error"]];
        [self.loadErrorView addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.loadErrorView);
            make.centerY.equalTo(self.loadErrorView).offset(-10);
        }];
        UILabel *lab = [[UILabel alloc]init];
        lab.tag = 11;
        lab.font = [UIFont systemFontOfSize:14];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = LGDictionaryColorHex(0x989898);
        if (self.loadErrorText && self.loadErrorText.length > 0) {
            lab.text = self.loadErrorText;
        }else{
            lab.text = LGDictionaryLoadErrorText;
        }
        [self.loadErrorView addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.width.equalTo(self.loadErrorView);
            make.top.equalTo(img.mas_bottom).offset(18);
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loadErrorUpdate)];
        [self.loadErrorView addGestureRecognizer:tap];
    }else{
        UILabel *lab = [self.loadErrorView viewWithTag:11];
        if (lab) {
            if (self.loadErrorText && self.loadErrorText.length > 0) {
                lab.text = self.loadErrorText;
            }else{
                lab.text = LGDictionaryLoadErrorText;
            }
        }
    }
}
- (void)loadErrorUpdate{
    if (self.updateDateBlock) {
        self.updateDateBlock();
    }
}
- (CGFloat)lg_navigationBarHeight{
    if ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO) {
        return 64 + 24;
    }
    return 64;
}
#pragma mark runtime
- (void)setLoadingView:(UIView *)loadingView{
    objc_setAssociatedObject(self, loadingViewKey, loadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)loadingView{
    return objc_getAssociatedObject(self, loadingViewKey);
}
- (void)setNoDataView:(UIView *)noDataView{
    objc_setAssociatedObject(self, noDataViewKey, noDataView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)noDataView{
    return objc_getAssociatedObject(self, noDataViewKey);
}
- (void)setNoDataText:(NSString *)noDataText{
    objc_setAssociatedObject(self, noDataTextKey, noDataText, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)noDataText{
    return objc_getAssociatedObject(self, noDataTextKey);
}
- (void)setLoadErrorView:(UIView *)loadErrorView{
    objc_setAssociatedObject(self, loadErrorViewKey, loadErrorView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)loadErrorView{
    return objc_getAssociatedObject(self, loadErrorViewKey);
}
- (void)setLoadErrorText:(NSString *)loadErrorText{
    objc_setAssociatedObject(self, loadErrorTextKey, loadErrorText, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)loadErrorText{
    return objc_getAssociatedObject(self, loadErrorTextKey);
}
- (void)setUpdateDateBlock:(void (^)(void))updateDateBlock{
    objc_setAssociatedObject(self, updateDateBlockKey, updateDateBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void (^)(void))updateDateBlock{
    return objc_getAssociatedObject(self, updateDateBlockKey);
}
@end
