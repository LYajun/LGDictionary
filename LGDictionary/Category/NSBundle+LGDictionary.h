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
+ (instancetype)lgd_dictionaryBundle;
+ (NSString *)lgd_bundlePathWithName:(NSString *)name;
+ (UIImage *)lgd_imageName:(NSString *)name;
+ (UIImage *)lgd_imagePathName:(NSString *)name;
+ (NSArray *)lgd_imageVoiceGifs;
@end
