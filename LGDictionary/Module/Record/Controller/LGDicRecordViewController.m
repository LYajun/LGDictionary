//
//  LGDicRecordViewController.m
//  LGDictionaryDemo
//
//  Created by 刘亚军 on 2018/9/27.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import "LGDicRecordViewController.h"
#import "LGDictionaryConst.h"
#import "LGDicRecordClearView.h"
#import "LGDicRecordFlowLayout.h"
#import "LGDicRecordFlowCell.h"
#import "LGDicRecorder.h"
#import <Masonry/Masonry.h>
#import "LGDictionaryConst.h"
#import "UIViewController+LGDictionary.h"

@interface LGDicRecordViewController ()<LGDicRecordFlowLayoutDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) LGDicRecordClearView *clearView;
@property (nonatomic,strong) UICollectionView *collectionView;
@end

@implementation LGDicRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LGDictionaryColorHex(0xEDEDED);
    [self layoutUI];
}
- (void)layoutUI{
    [self.view addSubview:self.clearView];
    [self.clearView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.top.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.clearView.mas_bottom);
        make.centerX.left.bottom.equalTo(self.view);
    }];
    self.noDataText = @"暂无搜索记录";
    [self updateData];
}
- (void)dealloc{
    NSLog(@"LGDicRecordViewController dealloc");
}
- (void)updateData{
    [self.collectionView reloadData];
    if (LGDictionaryIsArrEmpty(self.recordList)) {
        [self lg_setNoDataViewShow:YES];
    }else{
        [self lg_setNoDataViewShow:NO];
    }
}
#pragma mark UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.recordList.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LGDicRecordFlowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LGDicRecordFlowCell class]) forIndexPath:indexPath];
    NSDictionary *info = self.recordList[indexPath.row];
    cell.text = [info objectForKey:@"word"];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *info = self.recordList[indexPath.row];
    NSString *word = [info objectForKey:@"word"];
    if (self.clickRecordBlock) {
        self.clickRecordBlock(word);
    }
}
#pragma mark LGDicRecordFlowLayoutDelegate
- (CGFloat)lg_layout:(LGDicRecordFlowLayout *)layout widthForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *info = self.recordList[indexPath.row];
    NSString *str = [info objectForKey:@"word"];
    CGSize stringSize = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, 35) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    return stringSize.width+16;
}

#pragma mark getter
- (NSArray *)recordList{
    return [[LGDicRecorder shareInstance] recordList];
}
- (LGDicRecordClearView *)clearView{
    if (!_clearView) {
        _clearView = [[LGDicRecordClearView alloc] initWithFrame:CGRectZero];
        __weak typeof(self) weakSelf = self;
        _clearView.clearBlock = ^{
            [[LGDicRecorder shareInstance] deleteAllRecord];
            [weakSelf updateData];
        };
    }
    return _clearView;
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        LGDicRecordFlowLayout *layout = [[LGDicRecordFlowLayout alloc] init];
        layout.itemHeight = 35;
        layout.topInset = 1;
        layout.delegate = self;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[LGDicRecordFlowCell class] forCellWithReuseIdentifier:NSStringFromClass([LGDicRecordFlowCell class])];
    }
    return _collectionView;
}
@end
