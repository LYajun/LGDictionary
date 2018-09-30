//
//  LGDicRecorder.m
//  LGDictionaryDemo
//
//  Created by 刘亚军 on 2018/9/28.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import "LGDicRecorder.h"
#import "LGDicConfig.h"
#import "LGDictionaryConst.h"

@implementation LGDicRecorder
+ (LGDicRecorder *)shareInstance{
    static LGDicRecorder * macro = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        macro = [[LGDicRecorder alloc]init];
    });
    return macro;
}
- (NSString *)recordPath{
    NSString *recordBasePath = [NSString stringWithFormat:@"%@/Library/LGDic/%@/",NSHomeDirectory(),[LGDicConfig shareInstance].userID];
    NSString *recordPath = [recordBasePath stringByAppendingString:@"record.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:recordBasePath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:recordBasePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if (![[NSFileManager defaultManager] fileExistsAtPath:recordPath]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        // 在相应的路径创建plist文件
        [dic writeToFile:recordPath atomically:YES];
    }
    return recordPath;
}
- (NSArray *)recordList{
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:self.recordPath];
    if ([dic.allKeys containsObject:[LGDicConfig shareInstance].userID]) {
        NSArray *arr = [dic objectForKey:[LGDicConfig shareInstance].userID];
        return arr;
    }
    return nil;
}
- (NSInteger)recordCount{
    if (LGDictionaryIsArrEmpty(self.recordList)) {
        return 0;
    }
    return self.recordList.count;
}
- (void)deleteRecordAtIndex:(NSInteger)index{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:self.recordPath];
    NSMutableArray *arr = [NSMutableArray arrayWithArray:[dic objectForKey:[LGDicConfig shareInstance].userID]];
    [arr removeObjectAtIndex:index];
    [dic setValue:arr forKey:[LGDicConfig shareInstance].userID];
    [dic writeToFile:self.recordPath atomically:YES];
}
- (void)deleteAllRecord{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:self.recordPath];
    NSMutableArray *arr = [NSMutableArray arrayWithArray:[dic objectForKey:[LGDicConfig shareInstance].userID]];
    [arr removeAllObjects];
    [dic setValue:arr forKey:[LGDicConfig shareInstance].userID];
    [dic writeToFile:self.recordPath atomically:YES];
}
- (void)addRecordWithWord:(NSString *)word meaning:(NSString *)meaning{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:self.recordPath];
    NSMutableArray *arr;
    if ([dic.allKeys containsObject:[LGDicConfig shareInstance].userID]) {
        arr = [NSMutableArray arrayWithArray:[dic objectForKey:[LGDicConfig shareInstance].userID]];
    }else{
        arr = [NSMutableArray array];
    }
    if (arr.count <= 20) {
        BOOL contain = NO;
        for (NSDictionary *wordD in arr) {
            if ([[wordD objectForKey:@"word"] isEqualToString:word]) {
                contain = YES;
                break;
            }
        }
        if (!contain) {
            [arr insertObject:@{@"word":word,@"meaning":meaning} atIndex:0];
            [dic setValue:arr forKey:[LGDicConfig shareInstance].userID];
            [dic writeToFile:self.recordPath atomically:YES];
        }
    }
}
@end
