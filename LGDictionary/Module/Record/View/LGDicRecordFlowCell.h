//
//  LGDicRecordFlowCell.h
//  LGDictionaryDemo
//
//  Created by 刘亚军 on 2018/9/28.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGDicRecordFlowCell : UICollectionViewCell
@property (nonatomic,copy) NSString *text;
@property (nonatomic,strong) UIColor *textBgColor;
@property (nonatomic,strong) UIColor *textColor;
@property (nonatomic,strong) UIColor *borderColor;
@property (nonatomic,assign) BOOL isChoice;
@end
