//
//  LGDicHttpReq.h
//  LGDictionaryDemo
//
//  Created by 刘亚军 on 2018/9/27.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGDicHttpProtocol.h"

@interface LGDicHttpReq : NSObject
- (instancetype)initWithResponder:(id<LGDicHttpProtocol>)responder;
- (void)get:(NSString *)urlStr parameters:(NSDictionary *)parameters;
- (void)post:(NSString *)urlStr parameters:(NSDictionary *)parameters;
- (void)other:(NSString *)urlStr parameters:(NSDictionary *)parameters;
@end
