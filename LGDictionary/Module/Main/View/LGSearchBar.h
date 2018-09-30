//
//  LGSearchBar.h
//  LGDictionaryDemo
//
//  Created by 刘亚军 on 2018/9/27.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LGSearchBar;

@protocol LGSearchBarDelegate <NSObject>
- (void)lg_searchBar:(LGSearchBar *)searchBar didSearchWord:(NSString *)word;
@end

@interface LGSearchBar : UITextField
@property (nonatomic,assign) id<LGSearchBarDelegate> lgDelegate;
- (void)clearText;
@end
