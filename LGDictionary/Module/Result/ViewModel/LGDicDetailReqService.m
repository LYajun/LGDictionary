//
//  LGDicDetailReqService.m
//  LGDictionaryDemo
//
//  Created by 刘亚军 on 2018/9/28.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import "LGDicDetailReqService.h"
#import "LGDicHttpReq.h"
#import "LGDicConfig.h"
#import "UIViewController+LGDictionary.h"
#import "LGDicCategoryModel.h"
#import "LGDicRecorder.h"
#import "LGDicModel.h"
#import "LGDictionaryConst.h"

@interface LGDicDetailReqService ()<LGDicHttpProtocol>
/** 当前控制器 */
@property (nonatomic,weak) UIViewController<LGDicHttpProtocol> *ownController;
/** 请求类 */
@property (nonatomic,strong) LGDicHttpReq *httpReq;
@end
@implementation LGDicDetailReqService
- (instancetype)initWithOwnController:(UIViewController<LGDicHttpProtocol> *)ownController{
    if (self = [super init]) {
        self.ownController = ownController;
    }
    return self;
}
- (void)startReqWithWord:(NSString *)word{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[LGDicConfig shareInstance].parameters];
    [dic setValue:word forKey:[LGDicConfig shareInstance].wordKey];
    [self.ownController lg_setLoadingViewShow:YES];
    switch ([LGDicConfig shareInstance].reqType) {
        case LGDicReqTypeGET:
            [self.httpReq get:[LGDicConfig shareInstance].dicUrl parameters:dic];
            break;
        case LGDicReqTypePOST:
            [self.httpReq post:[LGDicConfig shareInstance].dicUrl parameters:dic];
            break;
        case LGDicReqTypeOther:
            [self.httpReq other:[LGDicConfig shareInstance].dicUrl parameters:dic];
            break;
        default:
            break;
    }
}
- (void)success:(LGDicModel *)responseObject{
    [[LGDicRecorder shareInstance] addRecordWithWord:responseObject.cwName.lowercaseString meaning:responseObject.wordChineseMean];
    [self.ownController lg_setLoadingViewShow:NO];
    [self startParseWithWordModel:responseObject];
}
- (void)failure:(NSError *)error{
    if (error.code == 10010) {
        self.ownController.noDataText = @"当前所查知识点不存在";
        [self.ownController lg_setNoDataViewShow:YES];
    }else{
        [self.ownController lg_setLoadErrorViewShow:YES];
    }
}
- (void)startParseWithWordModel:(LGDicModel *)wordModel{
    NSMutableArray *coltArr = [NSMutableArray array];
    NSMutableArray *rltArr = [NSMutableArray array];
    NSMutableArray *senArr = [NSMutableArray array];
    NSMutableArray *classicArr = [NSMutableArray array];
    NSMutableArray *meanArr = [NSMutableArray array];
    for (CxCollectionModel *cxModel in wordModel.cxCollection) {
        [meanArr addObjectsFromArray:cxModel.meanCollection];
        for (MeanCollectionModel *meanModel in cxModel.meanCollection) {
            if (!LGDictionaryIsArrEmpty(meanModel.senCollection)) {
                [senArr addObjectsFromArray:meanModel.senCollection];
            }
            if (!LGDictionaryIsArrEmpty(meanModel.coltCollection)) {
                for (ColtCollectionModel *coltModel in meanModel.coltCollection) {
                    if (!LGDictionaryIsArrEmpty(coltModel.senCollection)) {
                        [coltArr addObjectsFromArray:coltModel.senCollection];
                    }
                }
            }
            if (!LGDictionaryIsArrEmpty(meanModel.classicCollection)) {
                [classicArr addObjectsFromArray:meanModel.classicCollection];
            }
            if (!LGDictionaryIsArrEmpty(meanModel.rltCollection)) {
                [rltArr addObjectsFromArray:meanModel.rltCollection];
            }
        }
    }
    NSMutableArray *dataArr = [NSMutableArray array];
    [dataArr addObject:[self categoryModelWithType:LGDicCategoryTypeWord list:@[wordModel]]];
    if (senArr.count > 0) {
        [dataArr addObject:[self categoryModelWithType:LGDicCategoryTypeSen list:senArr]];
    }
    if (coltArr.count > 0) {
        [dataArr addObject:[self categoryModelWithType:LGDicCategoryTypeColt list:coltArr]];
    }
    if (classicArr.count > 0) {
        [dataArr addObject:[self categoryModelWithType:LGDicCategoryTypeClassic list:classicArr]];
    }
    if (rltArr.count > 0) {
        [dataArr addObject:[self categoryModelWithType:LGDicCategoryTypeRlt list:rltArr]];
    }
    [dataArr addObject:[self categoryModelWithType:LGDicCategoryTypeEnglish list:meanArr]];
    
    if ([self.ownController respondsToSelector:@selector(parseDataToModelArr:)]) {
        [self.ownController parseDataToModelArr:dataArr];
    }
}
- (LGDicCategoryModel *)categoryModelWithType:(LGDicCategoryType) type list:(NSArray *) list{
    LGDicCategoryModel *model = [[LGDicCategoryModel alloc] init];
    model.categoryType = type;
    model.categoryList = list;
    model.expand = YES;
    if (type == LGDicCategoryTypeWord) {
        model.foldEnable = YES;
    }
    return model;
}

- (LGDicHttpReq *)httpReq{
    if (!_httpReq) {
        _httpReq = [[LGDicHttpReq alloc] initWithResponder:self];
    }
    return _httpReq;
}
@end
