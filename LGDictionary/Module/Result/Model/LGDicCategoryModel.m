//
//  DLGWordCategoryModel.m
//  LGDicDemo
//
//  Created by 刘亚军 on 2018/4/8.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import "LGDicCategoryModel.h"

@implementation LGDicCategoryModel
- (NSString *)categoryTitle{
    switch (self.categoryType) {
        case LGDicCategoryTypeSen:
            return @"例句详解";
            break;
        case LGDicCategoryTypeColt:
            return @"常用搭配";
            break;
        case LGDicCategoryTypeClassic:
            return @"经典应用";
            break;
        case LGDicCategoryTypeRlt:
            return @"相关词汇";
            break;
        case LGDicCategoryTypeEnglish:
            return @"英英释义";
            break;
        default:
            return @"";
            break;
    }
}
@end
