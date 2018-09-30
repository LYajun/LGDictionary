//
//  LGDicDetailHeaderView.h
//  LGDictionaryDemo
//
//  Created by 刘亚军 on 2018/9/29.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LGDicCategoryModel;
@interface LGDicDetailCategoryHeaderView : UITableViewHeaderFooterView
- (void)setCategoryTitle:(NSString *)title;
- (void)setCategoryExpand:(BOOL)expand;
/** 展开/折叠回调 */
@property (nonatomic,copy) void (^expandBlock) (void);
@end


@interface LGDicDetailHeaderView : UITableViewHeaderFooterView
/** 全部展开/折叠回调 */
@property (nonatomic,copy) void (^allExpandBlock) (BOOL isAllExpand);
@property (nonatomic,strong) LGDicCategoryModel *categoryModel;
@end
