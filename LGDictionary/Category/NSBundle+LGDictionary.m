//
//  NSBundle+LGDictionary.m
//  LGDictionaryDemo
//
//  Created by 刘亚军 on 2018/9/26.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import "NSBundle+LGDictionary.h"

@implementation NSBundle (LGDictionary)
+ (instancetype)lg_dictionaryBundle{
    static NSBundle *dictionaryBundle = nil;
    if (!dictionaryBundle) {
        NSString *bundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Frameworks/LGDictionary.framework/LGDictionary.bundle"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:bundlePath]) {
            bundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"LGDictionary.bundle"];
        }
        dictionaryBundle = [NSBundle bundleWithPath:bundlePath];
    }
    return dictionaryBundle;
}
+ (NSString *)lg_bundlePathWithName:(NSString *)name{
    return [[[NSBundle lg_dictionaryBundle] resourcePath] stringByAppendingPathComponent:name];
}
+ (UIImage *)lg_imageName:(NSString *)name{
    return [UIImage imageNamed:[NSBundle lg_bundlePathWithName:name]];
}
+ (UIImage *)lg_imagePathName:(NSString *)name{
    return [UIImage imageWithContentsOfFile:[NSBundle lg_bundlePathWithName:name]];
}
+ (NSArray *)lg_imageVoiceGifs{
    return @[[NSBundle lg_imageName:@"record_animate-1"],[NSBundle lg_imageName:@"record_animate-2"],[NSBundle lg_imageName:@"record_animate-3"],[NSBundle lg_imageName:@"record_animate-4"]];
}
@end
