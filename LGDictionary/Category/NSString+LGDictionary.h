//
//  NSString+LGDictionary.h
//  LGDictionaryDemo
//
//  Created by 刘亚军 on 2018/10/17.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (LGDictionary)
- (NSString *)lg_appendFontAttibuteWithSize:(CGFloat) size;
- (NSMutableAttributedString *)lg_toMutableAttributedString;
- (NSMutableAttributedString *)lg_toHtmlMutableAttributedString;
@end
