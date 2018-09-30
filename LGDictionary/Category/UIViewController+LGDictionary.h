//
//  UIViewController+LGDictionary.h
//  LGDictionaryDemo
//
//  Created by 刘亚军 on 2018/9/27.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (LGDictionary)
/** 加载中 */
@property (strong, nonatomic) UIView *loadingView;
- (void)lg_setLoadingViewShow:(BOOL)show;
/** 没有数据 */
@property (strong, nonatomic) UIView *noDataView;
@property (copy, nonatomic) NSString *noDataText;
- (void)lg_setNoDataViewShow:(BOOL)show;
/** 发生错误 */
@property (strong, nonatomic) UIView *loadErrorView;
@property (copy, nonatomic) NSString *loadErrorText;
- (void)lg_setLoadErrorViewShow:(BOOL)show;
/** 刷新回调 */
@property (nonatomic,copy) void (^updateDateBlock) (void);

- (CGFloat)lg_navigationBarHeight;
@end
