//
//  LGDictionaryConst.h
//  LGDictionaryDemo
//
//  Created by 刘亚军 on 2018/9/26.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define LGDictionaryColorHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define LGDictionaryColorHexA(rgbValue,aValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:aValue]

#define LGDictionaryScreenW [UIScreen mainScreen].bounds.size.width
#define LGDictionaryScreenH [UIScreen mainScreen].bounds.size.height

#define LGDictionaryIsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))
#define LGDictionaryIsArrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))


UIKIT_EXTERN NSString *const LGDictionaryNoDataText;
UIKIT_EXTERN NSString *const LGDictionaryLoadErrorText;

UIKIT_EXTERN NSString *const LGDictionaryPlayerDidFinishPlayNotification;
