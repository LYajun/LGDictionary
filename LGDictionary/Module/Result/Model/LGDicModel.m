//
//  LGDicModel.m
//  LGDictionaryDemo
//
//  Created by 刘亚军 on 2018/9/27.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import "LGDicModel.h"
#import "NSMutableAttributedString+LGDictionary.h"
#import "LGDictionaryConst.h"
#import "NSString+LGDictionary.h"

@implementation SenCollectionModel
-(void)setSentenceEn:(NSString *)sentenceEn{
    _sentenceEn = sentenceEn;
    _sentenceEn_attr = [sentenceEn lg_appendFontAttibuteWithSize:5.95].lg_toHtmlMutableAttributedString;
}
-(void)setSTranslation:(NSString *)sTranslation{
    _sTranslation = sTranslation;
    _sTranslation_attr = [sTranslation lg_appendFontAttibuteWithSize:4].lg_toHtmlMutableAttributedString;
}
@end

@implementation ColtCollectionModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"senCollection":[SenCollectionModel class]};
}
//-(void)setColtEn:(NSString *)coltEn{
//    _coltEn = coltEn;
//    _coltEn_attr = [NSMutableAttributedString lg_AttributeWithHtmlStr:coltEn font:15];
//    
//}
//-(void)setColtCn:(NSString *)coltCn{
//    _coltCn = coltCn;
//    _coltCn_attr = [NSMutableAttributedString lg_AttributeWithHtmlStr:coltCn font:14];
//}
@end

@implementation RltCollectionModel
-(void)setTitle:(NSString *)title{
    _title = title;
    _title_attr = [title lg_appendFontAttibuteWithSize:5.95].lg_toHtmlMutableAttributedString;
}
-(void)setContent:(NSString *)content{
    _content = content;
    _content_attr = [content lg_appendFontAttibuteWithSize:4].lg_toHtmlMutableAttributedString;
}
@end

@implementation ClassicCollectionModel
-(void)setTitle:(NSString *)title{
    _title = title;
    _title_attr = [title lg_appendFontAttibuteWithSize:5.95].lg_toHtmlMutableAttributedString;
}
-(void)setContent:(NSString *)content{
    _content = content;
    _content_attr = [content lg_appendFontAttibuteWithSize:4].lg_toHtmlMutableAttributedString;
}
@end

@implementation MeanCollectionModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"coltCollection":[ColtCollectionModel class],
             @"rltCollection":[RltCollectionModel class],
             @"senCollection":[SenCollectionModel class],
             @"classicCollection":[ClassicCollectionModel class]
             };
}
-(void)setChineseMeaning:(NSString *)chineseMeaning{
    _chineseMeaning = chineseMeaning;
    _chineseMeaning_attr = [chineseMeaning lg_appendFontAttibuteWithSize:4].lg_toHtmlMutableAttributedString;
}
-(void)setEnglishMeaning:(NSString *)englishMeaning{
    _englishMeaning = englishMeaning;
    _englishMeaning_attr = [englishMeaning lg_appendFontAttibuteWithSize:5.95].lg_toHtmlMutableAttributedString;
}
@end

@implementation CxCollectionModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"meanCollection":[MeanCollectionModel class]};
}
- (void)setCxEnglish:(NSString *)cxEnglish{
    _cxEnglish = cxEnglish;
    _cxEnglish_attr = [cxEnglish lg_appendFontAttibuteWithSize:4].lg_toHtmlMutableAttributedString;
}
@end
@implementation LGDicModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"cxCollection":[CxCollectionModel class]};
}

- (NSString *)wordChineseMean{
    NSString *meaning = @"";
    int i = 0;
    for (CxCollectionModel *cxModel in self.cxCollection) {
        if (i!=0) {
            meaning = [meaning stringByAppendingString:@"\n"];
        }
        meaning = [meaning stringByAppendingString:cxModel.cxEnglish];
        for (MeanCollectionModel *meanModel in cxModel.meanCollection) {
            meaning = [meaning stringByAppendingString:meanModel.chineseMeaning_attr.string];
        }
        i++;
    }
    return meaning;
}
- (NSAttributedString *)wordChineseMeanAttr{
    NSMutableAttributedString *meaningAttr = [[NSMutableAttributedString alloc] init];
    int i = 0;
    for (CxCollectionModel *cxModel in self.cxCollection) {
        if (i!=0) {
            [meaningAttr appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
        }
        [meaningAttr appendAttributedString:cxModel.cxEnglish_attr];
        for (MeanCollectionModel *meanModel in cxModel.meanCollection) {
            [meaningAttr appendAttributedString:meanModel.chineseMeaning_attr];
        }
        i++;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    [meaningAttr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, meaningAttr.length)];
    [meaningAttr addAttribute:NSForegroundColorAttributeName value:LGDictionaryColorHex(0x282828) range:NSMakeRange(0, meaningAttr.length)];
    [meaningAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, meaningAttr.length)];
    return meaningAttr;
}
@end
