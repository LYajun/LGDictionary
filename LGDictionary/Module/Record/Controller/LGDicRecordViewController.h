//
//  LGDicRecordViewController.h
//  LGDictionaryDemo
//
//  Created by 刘亚军 on 2018/9/27.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGDicRecordViewController : UIViewController
/** 点击搜索历史回调 */
@property (nonatomic,copy) void (^clickRecordBlock) (NSString *word);
- (void)updateData;
@end
