//
//  LGDicModel.m
//  LGDictionaryDemo
//
//  Created by 刘亚军 on 2018/9/27.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import "LGDicModel.h"
#import "NSMutableAttributedString+LGDictionary.h"

@implementation SenCollectionModel
-(void)setSentenceEn:(NSString *)sentenceEn{
    _sentenceEn = sentenceEn;
    _sentenceEn_attr = [NSMutableAttributedString lg_AttributeWithHtmlStr:sentenceEn font:15];
}
-(void)setSTranslation:(NSString *)sTranslation{
    _sTranslation = sTranslation;
    _sTranslation_attr = [NSMutableAttributedString lg_AttributeWithHtmlStr:sTranslation font:14];
}
@end

@implementation ColtCollectionModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"senCollection":[SenCollectionModel class]};
}
-(void)setColtEn:(NSString *)coltEn{
    _coltEn = coltEn;
    _coltEn_attr = [NSMutableAttributedString lg_AttributeWithHtmlStr:coltEn font:15];
    
}
-(void)setColtCn:(NSString *)coltCn{
    _coltCn = coltCn;
    _coltCn_attr = [NSMutableAttributedString lg_AttributeWithHtmlStr:coltCn font:14];
}
@end

@implementation RltCollectionModel
-(void)setTitle:(NSString *)title{
    _title = title;
    _title_attr = [NSMutableAttributedString lg_AttributeWithHtmlStr:title font:15];
}
-(void)setContent:(NSString *)content{
    _content = content;
    _content_attr = [NSMutableAttributedString lg_AttributeWithHtmlStr:content font:14];
}
@end

@implementation ClassicCollectionModel
-(void)setTitle:(NSString *)title{
    _title = title;
    _title_attr = [NSMutableAttributedString lg_AttributeWithHtmlStr:title font:15];
}
-(void)setContent:(NSString *)content{
    _content = content;
    _content_attr = [NSMutableAttributedString lg_AttributeWithHtmlStr:content font:14];
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
    _chineseMeaning_attr = [NSMutableAttributedString lg_AttributeWithHtmlStr:chineseMeaning font:15];
}
-(void)setEnglishMeaning:(NSString *)englishMeaning{
    _englishMeaning = englishMeaning;
    _englishMeaning_attr = [NSMutableAttributedString lg_AttributeWithHtmlStr:englishMeaning font:14];
}
@end

@implementation CxCollectionModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"meanCollection":[MeanCollectionModel class]};
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
@end
