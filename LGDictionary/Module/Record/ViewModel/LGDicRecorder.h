//
//  LGDicRecorder.h
//  LGDictionaryDemo
//
//  Created by 刘亚军 on 2018/9/28.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LGDicRecorder : NSObject
+ (LGDicRecorder *)shareInstance;
- (NSInteger)recordCount;
- (NSArray *)recordList;
- (void)deleteRecordAtIndex:(NSInteger) index;
- (void)deleteAllRecord;
- (void)addRecordWithWord:(NSString *) word meaning:(NSString *) meaning;
@end
