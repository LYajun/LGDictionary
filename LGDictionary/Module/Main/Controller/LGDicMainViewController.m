//
//  LGDicMainViewController.m
//  LGDictionaryDemo
//
//  Created by 刘亚军 on 2018/9/26.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import "LGDicMainViewController.h"
#import "NSBundle+LGDictionary.h"
#import "UIViewController+LGDictionary.h"
#import "LGDictionaryConst.h"
#import "LGSearchBar.h"
#import "LGDicRecordViewController.h"
#import "LGDicDetailViewController.h"
#import "LGDicAlertView.h"
#import "LGDicPlayer.h"

@interface LGDicMainViewController ()<LGSearchBarDelegate>
@property (nonatomic,assign) BOOL naviBarTranslucent;
@property (nonatomic,strong) UIButton *searchBtn;
@property (nonatomic,strong) LGSearchBar *searchBar;
@property (nonatomic,strong) LGDicRecordViewController *recordVC;
@property (nonatomic,strong) LGDicDetailViewController *detailVC;
@property (nonatomic,strong) UIScrollView *mainScrollView;
@end

@implementation LGDicMainViewController
- (void)dealloc{
    NSLog(@"LGDicMainViewController dealloc");
    [[LGDicPlayer shareInstance] stop];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavBar];
    [self initUI];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (LGDictionaryIsStrEmpty(self.config.word)) {
        [self.searchBar becomeFirstResponder];
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.naviBarTranslucent) {
        self.navigationController.navigationBar.translucent = YES;
    }
}
- (void)initNavBar{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[NSBundle lgd_imageName:@"lg_back"] style:UIBarButtonItemStylePlain target:self action:@selector(navBar_leftItemPressed)];
    self.naviBarTranslucent = self.navigationController.navigationBar.translucent;
    if (self.naviBarTranslucent) {
        self.navigationController.navigationBar.translucent = NO;
    }
}
- (void)initUI{
    self.view.backgroundColor = LGDictionaryColorHex(0xEDEDED);
    self.navigationItem.titleView = self.searchBar;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.searchBtn];
    [self.view addSubview:self.mainScrollView];
    [self addSubController:self.recordVC atIndex:0];
    [self addSubController:self.detailVC atIndex:1];

    if (!LGDictionaryIsStrEmpty(self.config.word)) {
        [self startReqWithWord:self.config.word];
        self.config.word = @"";
    }
}
- (void)navBar_leftItemPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBtnAction:(UIButton *) btn{
    [self.searchBar resignFirstResponder];
    if (self.mainScrollView.contentOffset.x/LGDictionaryScreenW > 0) {
        self.mainScrollView.contentOffset = CGPointMake(0, 0);
        [self.searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        [self.searchBar clearText];
        [self.recordVC updateData];
        [[LGDicPlayer shareInstance] stop];
    }else{
        if (LGDictionaryIsStrEmpty(self.searchBar.text)) {
            [LGDicAlertView showWithText:@"输入不能为空!"];
        }else{
            [self startReqWithWord:self.searchBar.text];
        }
    }
}

- (void)addSubController:(UIViewController *) subController atIndex:(NSInteger) index{
    subController.view.frame = CGRectMake(LGDictionaryScreenW * index, 0, LGDictionaryScreenW, self.mainScrollView.frame.size.height);
    [self.mainScrollView addSubview:subController.view];
    [self addChildViewController:subController];
}

- (LGDicConfig *)config{
    return [LGDicConfig shareInstance];
}

- (void)lg_searchBar:(LGSearchBar *)searchBar didSearchWord:(NSString *)word{
    [self startReqWithWord:word];
}
- (void)startReqWithWord:(NSString *)word{
    self.searchBar.text = word;
    if ([LGDicConfig shareInstance].queryBlock) {
        [LGDicConfig shareInstance].queryBlock(word);
    }
    self.mainScrollView.contentOffset = CGPointMake(LGDictionaryScreenW, 0);
    [self.searchBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.searchBar resignFirstResponder];
    [self.detailVC startReqWithWord:word];
}
#pragma mark getter
- (UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, LGDictionaryScreenW, LGDictionaryScreenH - self.lg_navigationBarHeight)];
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.scrollEnabled = NO;
        _mainScrollView.contentSize = CGSizeMake(LGDictionaryScreenW * 2, 0);
    }
    return _mainScrollView;
}
- (LGDicRecordViewController *)recordVC{
    if (!_recordVC) {
        _recordVC = [[LGDicRecordViewController alloc] init];
        __weak typeof(self) weakSelf = self;
        _recordVC.clickRecordBlock = ^(NSString *word) {
             [weakSelf startReqWithWord:word];
        };
    }
    return _recordVC;
}
- (LGDicDetailViewController *)detailVC{
    if (!_detailVC) {
        _detailVC = [[LGDicDetailViewController alloc] init];
    }
    return _detailVC;
}
- (LGSearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[LGSearchBar alloc] initWithFrame:CGRectMake(0, 0, LGDictionaryScreenW * 4 / 5, 26)];
        _searchBar.lgDelegate = self;
    }
    return _searchBar;
}
- (UIButton *)searchBtn{
    if (!_searchBtn) {
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchBtn.frame = CGRectMake(0, 0, 40, 28);
        [_searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        _searchBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_searchBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
        [_searchBtn addTarget:self action:@selector(searchBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchBtn;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}
@end
