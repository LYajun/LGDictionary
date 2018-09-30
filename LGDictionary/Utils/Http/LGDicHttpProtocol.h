//
//  LGDicHttpProtocol.h
//  LGDictionaryDemo
//
//  Created by 刘亚军 on 2018/9/27.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LGDicHttpProtocol <NSObject>

@optional
/** 请求响应 */
- (void)success:(id)responseObject;
- (void)failure:(NSError *)error;

/** 数据转模型 */
- (void)parseDataToModelArr:(NSArray *) modelArr;
@end
