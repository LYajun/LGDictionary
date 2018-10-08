//
//  NSBundle+LGDictionary.h
//  LGDictionaryDemo
//
//  Created by 刘亚军 on 2018/9/26.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSBundle (LGDictionary)
+ (instancetype)lg_dictionaryBundle;
+ (NSString *)lg_bundlePathWithName:(NSString *)name;
+ (UIImage *)lg_imageName:(NSString *)name;
+ (UIImage *)lg_imagePathName:(NSString *)name;
+ (NSArray *)lg_imageVoiceGifs;
@end
