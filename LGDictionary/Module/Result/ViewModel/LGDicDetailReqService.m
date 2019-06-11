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
#import <XMLDictionary/XMLDictionary.h>

@interface LGDicDetailReqService ()<LGDicHttpProtocol>
/** 当前控制器 */
@property (nonatomic,weak) UIViewController<LGDicHttpProtocol> *ownController;
/** 请求类 */
@property (nonatomic,strong) LGDicHttpReq *httpReq;
@property (nonatomic,strong) NSString *apiUrl;
@end
@implementation LGDicDetailReqService
- (instancetype)initWithOwnController:(UIViewController<LGDicHttpProtocol> *)ownController{
    if (self = [super init]) {
        self.ownController = ownController;
    }
    return self;
}
- (void)startReqWithWord:(NSString *)word{
    if (LGDictionaryIsStrEmpty(self.apiUrl)) {
        [self loadDicConfigWithWord:word];
    }else{
        [self reqWithWord:word];
    }
}
- (void)reqWithWord:(NSString *)word{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[LGDicConfig shareInstance].parameters];
    [dic setValue:word forKey:[LGDicConfig shareInstance].wordKey];
    [self.ownController lg_setLoadingViewShow:YES];
    NSString *url = [self.apiUrl stringByAppendingString:@"/API/Resources/GetCourseware"];
    switch ([LGDicConfig shareInstance].reqType) {
        case LGDicReqTypeGET:
            [self.httpReq get:url parameters:dic];
            break;
        case LGDicReqTypePOST:
            [self.httpReq post:url parameters:dic];
            break;
        case LGDicReqTypeOther:
            [self.httpReq other:url parameters:dic];
            break;
        default:
            break;
    }
    
}
- (void)loadDicConfigWithWord:(NSString *)word{
    NSString *urlStr = [[LGDicConfig shareInstance].dicUrl stringByAppendingFormat:@"/Base/WS/Service_Basic.asmx/WS_G_GetSubSystemServerInfoForAllSubject?sysID=%@",@"629"];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *requestUrl = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    request.timeoutInterval = 15;
    NSURLSession *session = [NSURLSession sharedSession];
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                [weakSelf failure:error];
            }else{
                NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSDictionary *dic = [NSDictionary dictionaryWithXMLString:str];
                NSArray<NSDictionary *> *sysInfoList = [dic arrayValueForKeyPath:@"anyType"];
                if (!LGDictionaryIsArrEmpty(sysInfoList)) {
                    NSDictionary *sysInfo = sysInfoList.firstObject;
                    weakSelf.apiUrl = [sysInfo objectForKey:@"WsSvrAddr"];
                    [weakSelf reqWithWord:word];
                }else{
                    [weakSelf failure:[NSError errorWithDomain:@"LGDicErrorDamain" code:10000 userInfo:@{NSLocalizedDescriptionKey:@"获取配置信息失败"}]];
                }
            }
        });
    }];
    [dataTask resume];
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
