//
//  NSMutableAttributedString+LGDictionary.m
//  LGDictionaryDemo
//
//  Created by 刘亚军 on 2018/9/27.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import "NSMutableAttributedString+LGDictionary.h"

@implementation NSMutableAttributedString (LGDictionary)
+ (NSMutableAttributedString *)lg_AttributeWithHtmlStr:(NSString *)htmlStr font:(CGFloat)font{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithData:[htmlStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font]range:NSMakeRange(0,attrStr.length)];
    return attrStr;
}
@end
