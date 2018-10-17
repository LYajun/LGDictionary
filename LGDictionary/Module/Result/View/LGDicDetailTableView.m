//
//  LGDicDetailTableView.m
//  LGDictionaryDemo
//
//  Created by 刘亚军 on 2018/9/30.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import "LGDicDetailTableView.h"
#import "LGDicDetailHeaderView.h"
#import "LGDicDetailTextCell.h"
#import "LGDicDetailVoiceCell.h"
#import "LGDicCategoryModel.h"
#import "LGDicModel.h"
#import "LGDictionaryConst.h"

@interface LGDicDetailTableView ()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation LGDicDetailTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.backgroundColor = [UIColor clearColor];
        self.dataSource = self;
        self.delegate = self;
        self.rowHeight = UITableViewAutomaticDimension;
        self.estimatedRowHeight = 80;
        self.sectionHeaderHeight = UITableViewAutomaticDimension;
        self.estimatedSectionHeaderHeight = 100;
        self.sectionFooterHeight = 10;
        
        [self registerClass:[LGDicDetailTextCell class] forCellReuseIdentifier:NSStringFromClass([LGDicDetailTextCell class])];
        [self registerClass:[LGDicDetailVoiceCell class] forCellReuseIdentifier:NSStringFromClass([LGDicDetailVoiceCell class])];
        [self registerClass:[LGDicDetailHeaderView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([LGDicDetailHeaderView class])];
        [self registerClass:[LGDicDetailCategoryHeaderView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([LGDicDetailCategoryHeaderView class])];
    }
    return self;
}
- (void)setDataArr:(NSArray *)dataArr{
    self.contentOffset = CGPointZero;
    _dataArr = dataArr;
    [self reloadData];
}
- (void)expandOrFoldEnable{
    NSInteger expandCount = 0;
    NSInteger foldCount = 0;
    for (LGDicCategoryModel *model in self.dataArr) {
        if (model.categoryType != LGDicCategoryTypeWord) {
            if (model.expand) {
                expandCount++;
            }else{
                foldCount++;
            }
        }
    }
    LGDicCategoryModel *categoryModel = [self.dataArr firstObject];
    if (foldCount == 0) {
        categoryModel.expandEnable = NO;
    }else{
        categoryModel.expandEnable = YES;
    }
    if (expandCount == 0) {
        categoryModel.foldEnable = NO;
    }else{
        categoryModel.foldEnable = YES;
    }
}
#pragma mark delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    LGDicCategoryModel *categoryModel = self.dataArr[section];
    if (categoryModel.categoryType == LGDicCategoryTypeWord) {
        return 0;
    }else{
        if (categoryModel.expand) {
            return categoryModel.categoryList.count;
        }else{
            return 0;
        }
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    __block LGDicCategoryModel *categoryModel = self.dataArr[section];
    __weak typeof(self) weakSelf = self;
    if (categoryModel.categoryType == LGDicCategoryTypeWord) {
        LGDicDetailHeaderView *mainHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([LGDicDetailHeaderView class])];
        mainHeader.allExpandBlock = ^(BOOL isAllExpand) {
            for (LGDicCategoryModel *model in self.dataArr) {
                model.expandEnable = !isAllExpand;
                model.foldEnable = isAllExpand;
                model.expand = isAllExpand;
            }
            [weakSelf reloadData];
        };
        mainHeader.categoryModel = categoryModel;
        return mainHeader;
    }else{
        LGDicDetailCategoryHeaderView *categoryHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([LGDicDetailCategoryHeaderView class])];
        categoryHeader.expandBlock = ^{
            categoryModel.expand = !categoryModel.expand;
            [weakSelf expandOrFoldEnable];
            [weakSelf reloadData];
        };
        [categoryHeader setCategoryTitle:categoryModel.categoryTitle];
        [categoryHeader setCategoryExpand:categoryModel.expand];
        return categoryHeader;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LGDicCategoryModel *categoryModel = self.dataArr[indexPath.section];
    if (categoryModel.categoryType == LGDicCategoryTypeWord) {
        return nil;
    }else{
        if (categoryModel.categoryType == LGDicCategoryTypeSen) {
            LGDicDetailVoiceCell *voiceCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LGDicDetailVoiceCell class]) forIndexPath:indexPath];
            [voiceCell setTextModel:categoryModel adIndexPath:indexPath];
            return voiceCell;
        }else if (categoryModel.categoryType == LGDicCategoryTypeEnglish){
            LGDicDetailTextCell *textCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LGDicDetailTextCell class]) forIndexPath:indexPath];
            MeanCollectionModel *meanModel = categoryModel.categoryList[indexPath.row];
            NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithAttributedString:meanModel.chineseMeaning_attr];
            [att appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
            [att appendAttributedString:meanModel.englishMeaning_attr];
            [att addAttribute:NSForegroundColorAttributeName value:LGDictionaryColorHex(0x282828) range:NSMakeRange(0, att.length)];
            [textCell setText:att];
            return textCell;
        }else{
            LGDicDetailTextCell *textCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LGDicDetailTextCell class]) forIndexPath:indexPath];
            [textCell setTextModel:categoryModel adIndexPath:indexPath];
            return textCell;
        }
    }
}
@end
