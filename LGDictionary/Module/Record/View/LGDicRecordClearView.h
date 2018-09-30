//
//  LGDicRecordClearView.h
//  LGDictionaryDemo
//
//  Created by 刘亚军 on 2018/9/28.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGDicRecordClearView : UIView
/** 清除回调 */
@property (nonatomic,copy) void (^clearBlock) (void);
/** 清除按钮是否显示 */
@property (nonatomic,assign) BOOL isHideClearBtn;
@end
