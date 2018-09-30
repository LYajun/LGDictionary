//
//  LGDicConfig.m
//  LGDictionaryDemo
//
//  Created by 刘亚军 on 2018/9/27.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import "LGDicConfig.h"

@implementation LGDicConfig
+ (LGDicConfig *)shareInstance{
    static LGDicConfig * macro = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        macro = [[LGDicConfig alloc]init];
    });
    return macro;
}
- (void)setWord:(NSString *)word{
   _word = [[word lowercaseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}
@end
