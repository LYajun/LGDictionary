//
//  LGDicDetailReqService.h
//  LGDictionaryDemo
//
//  Created by 刘亚军 on 2018/9/28.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LGDicHttpProtocol.h"

@interface LGDicDetailReqService : NSObject
- (instancetype)initWithOwnController:(UIViewController<LGDicHttpProtocol> *)ownController;
- (void)startReqWithWord:(NSString *)word;
@end
