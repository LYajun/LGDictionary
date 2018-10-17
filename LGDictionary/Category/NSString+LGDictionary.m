//
//  NSString+LGDictionary.m
//  LGDictionaryDemo
//
//  Created by 刘亚军 on 2018/10/17.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import "NSString+LGDictionary.h"

@implementation NSString (LGDictionary)
- (NSString *)lg_appendFontAttibuteWithSize:(CGFloat)size{
    return [NSString stringWithFormat:@"<font size=\"%f\">%@</font>",size,self];
}
- (NSMutableAttributedString *)lg_toMutableAttributedString{
    return [[NSMutableAttributedString alloc] initWithString:self];
}
- (NSMutableAttributedString *)lg_toHtmlMutableAttributedString{
    NSData *htmlData = [self dataUsingEncoding:NSUnicodeStringEncoding];
    return [[NSMutableAttributedString alloc] initWithData:htmlData options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
}
@end
