//
//  NSBundle+LGDictionary.m
//  LGDictionaryDemo
//
//  Created by 刘亚军 on 2018/9/26.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import "NSBundle+LGDictionary.h"
#import "LGDicDetailHeaderView.h"

@implementation NSBundle (LGDictionary)
+ (instancetype)lgd_dictionaryBundle{
    static NSBundle *dictionaryBundle = nil;
    if (!dictionaryBundle) {
        // 这里不使用mainBundle是为了适配pod 1.x和0.x
        dictionaryBundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[LGDicDetailHeaderView class]] pathForResource:@"LGDictionary" ofType:@"bundle"]];
    }
    return dictionaryBundle;
}
+ (NSString *)lgd_bundlePathWithName:(NSString *)name{
    return [[[NSBundle lgd_dictionaryBundle] resourcePath] stringByAppendingPathComponent:name];
}
+ (UIImage *)lgd_imageName:(NSString *)name{
    return [UIImage imageNamed:[NSBundle lgd_bundlePathWithName:name]];
}
+ (UIImage *)lgd_imagePathName:(NSString *)name{
    return [UIImage imageWithContentsOfFile:[NSBundle lgd_bundlePathWithName:name]];
}
+ (NSArray *)lgd_imageVoiceGifs{
    return @[[NSBundle lgd_imageName:@"record_animate-1"],[NSBundle lgd_imageName:@"record_animate-2"],[NSBundle lgd_imageName:@"record_animate-3"],[NSBundle lgd_imageName:@"record_animate-4"]];
}
@end
