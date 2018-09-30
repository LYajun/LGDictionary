//
//  NSMutableAttributedString+LGDictionary.h
//  LGDictionaryDemo
//
//  Created by 刘亚军 on 2018/9/27.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (LGDictionary)
+ (NSMutableAttributedString *)lg_AttributeWithHtmlStr:(NSString *) htmlStr font:(CGFloat)font;
@end
