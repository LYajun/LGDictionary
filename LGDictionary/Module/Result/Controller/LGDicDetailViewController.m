//
//  LGDicDetailViewController.m
//  LGDictionaryDemo
//
//  Created by 刘亚军 on 2018/9/27.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import "LGDicDetailViewController.h"
#import "LGDictionaryConst.h"
#import "LGDicDetailReqService.h"
#import "LGDicDetailTableView.h"
#import <Masonry/Masonry.h>
#import "UIViewController+LGDictionary.h"

@interface LGDicDetailViewController ()<LGDicHttpProtocol>
/** 请求服务 */
@property (nonatomic,strong) LGDicDetailReqService *reqService;
@property (nonatomic,strong) LGDicDetailTableView *tableView;
@property (nonatomic,copy) NSString *selectWord;
@end

@implementation LGDicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LGDictionaryColorHex(0xEDEDED);
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    __weak typeof(self) weakSelf = self;
    self.updateDateBlock = ^{
        [weakSelf startReqWithWord:weakSelf.selectWord];
    };
    
}
- (void)dealloc{
    NSLog(@"LGDicRecordViewController dealloc");
}

- (void)startReqWithWord:(NSString *)word{
    self.selectWord = word;
    [self.reqService startReqWithWord:word];
}
- (void)parseDataToModelArr:(NSArray *)modelArr{
    self.tableView.dataArr = modelArr;
}
#pragma mark getter
- (LGDicDetailReqService *)reqService{
    if (!_reqService) {
        _reqService = [[LGDicDetailReqService alloc] initWithOwnController:self];
    }
    return _reqService;
}
- (LGDicDetailTableView *)tableView{
    if (!_tableView) {
        _tableView = [[LGDicDetailTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.bounces = NO;
    }
    return _tableView;
}
@end
