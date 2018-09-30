//
//  LGDicDetailHeaderView.m
//  LGDictionaryDemo
//
//  Created by 刘亚军 on 2018/9/29.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import "LGDicDetailHeaderView.h"
#import <Masonry/Masonry.h>
#import "LGDicButton.h"
#import "NSBundle+LGDictionary.h"
#import "LGDicPlayer.h"
#import "LGDicConfig.h"
#import "LGDicModel.h"
#import "LGDicCategoryModel.h"
#import "LGDictionaryConst.h"
#import "NSMutableAttributedString+LGDictionary.h"

@interface LGDicDetailCategoryHeaderView ()
@property (strong, nonatomic) LGDicTIButton *expandBtn;
@property (strong, nonatomic) UIView *line;
@end
@implementation LGDicDetailCategoryHeaderView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self layoutUI];
    }
    return self;
}
- (void)layoutUI{
     self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.expandBtn];
    [self.expandBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.centerY.equalTo(self.contentView).offset(1);
        make.left.equalTo(self.contentView).offset(10);
        make.height.mas_greaterThanOrEqualTo(40);
    }];
    [self.contentView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerX.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
}
- (void)expandAction:(UIButton *) btn{
    if (self.expandBlock) {
        self.expandBlock();
    }
}
- (void)setCategoryTitle:(NSString *)title{
    [self.expandBtn setTitle:title forState:UIControlStateNormal];
}
- (void)setCategoryExpand:(BOOL)expand{
    if (expand) {
        self.expandBtn.imageView.transform = CGAffineTransformMakeRotation(-M_PI);
    }else{
        self.expandBtn.imageView.transform = CGAffineTransformIdentity;
    }
    self.line.hidden = !expand;
}
- (UIView *)line{
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = LGDictionaryColorHex(0xEDEDED);
    }
    return _line;
}
- (LGDicTIButton *)expandBtn{
    if (!_expandBtn) {
        _expandBtn = [LGDicTIButton buttonWithType:UIButtonTypeCustom];
 
        _expandBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        _expandBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_expandBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_expandBtn addTarget:self action:@selector(expandAction:) forControlEvents:UIControlEventTouchUpInside];
        [_expandBtn setImage:[NSBundle lg_imageName:@"lg_expand_cell"] forState:UIControlStateNormal];
        [_expandBtn setTitle:@"例句详解" forState:UIControlStateNormal];
    }
    return _expandBtn;
}
@end


@interface LGDicDetailHeaderView ()
@property (strong, nonatomic) UIButton *enVoiceBtn;
@property (strong,nonatomic) UIButton *usVoiceBtn;
@property (strong,nonatomic) UIButton *allExpandBtn;
@property (strong,nonatomic) UIButton *allFoldBtn;
@property (strong, nonatomic) UILabel *wordL;
@property (strong, nonatomic) UILabel *textL;
@end
@implementation LGDicDetailHeaderView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self layoutUI];
    }
    return self;
}
- (void)layoutUI{
    self.contentView.backgroundColor = [UIColor whiteColor];
    UIView *botView = [UIView new];
    botView.backgroundColor = LGDictionaryColorHex(0xEDEDED);
    [self.contentView addSubview:botView];
    [botView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerX.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(30);
    }];
    [botView addSubview:self.allFoldBtn];
    [self.allFoldBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(botView).offset(5);
        make.height.mas_equalTo(20);
    }];
    [botView addSubview:self.allExpandBtn];
    [self.allExpandBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.equalTo(self.allFoldBtn);
        make.right.equalTo(self.allFoldBtn.mas_left).offset(-10);
    }];
    [self.contentView addSubview:self.wordL];
    [self.wordL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(20);
        make.left.equalTo(self.contentView).offset(20);
        make.centerX.equalTo(self.contentView);
        make.height.mas_equalTo(35);
    }];
    [self.contentView addSubview:self.enVoiceBtn];
    [self.enVoiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.wordL);
        make.top.equalTo(self.wordL.mas_bottom).offset(10);
        make.height.mas_equalTo(26);
    }];
    [self.contentView addSubview:self.usVoiceBtn];
    [self.usVoiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(self.enVoiceBtn);
        make.left.equalTo(self.enVoiceBtn.mas_right).offset(30);
    }];
    [self.contentView addSubview:self.textL];
    [self.textL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.centerX.equalTo(self.wordL);
        make.top.equalTo(self.enVoiceBtn.mas_bottom).offset(5);
        make.bottom.equalTo(botView.mas_top).offset(-10);
    }];
}
- (void)setCategoryModel:(LGDicCategoryModel *)categoryModel{
    _categoryModel = categoryModel;
    LGDicModel *wordModel = [categoryModel.categoryList firstObject];
    self.wordL.text = wordModel.cwName;
    self.textL.text = [wordModel wordChineseMean];
    [self.enVoiceBtn setTitle:[@" 英" stringByAppendingString:[NSMutableAttributedString lg_AttributeWithHtmlStr:wordModel.unPText font:14].string] forState:UIControlStateNormal];
    [self.usVoiceBtn setTitle:[@" 美" stringByAppendingString:[NSMutableAttributedString lg_AttributeWithHtmlStr:wordModel.usPText font:14].string] forState:UIControlStateNormal];
    self.allFoldBtn.selected = !categoryModel.foldEnable;
    self.allFoldBtn.userInteractionEnabled = categoryModel.foldEnable;
    self.allExpandBtn.selected = !categoryModel.expandEnable;
    self.allExpandBtn.userInteractionEnabled = categoryModel.expandEnable;
}
- (void)enVoiceAction{
    LGDicModel *wordModel = [self.categoryModel.categoryList firstObject];
    [[LGDicPlayer shareInstance] stop];
    if ([LGDicConfig shareInstance].appendDomain) {
        [[LGDicPlayer shareInstance] startPlayWithUrl:[[LGDicConfig shareInstance].voiceUrl stringByAppendingString:wordModel.unPVoice]];
    }else{
        [[LGDicPlayer shareInstance] startPlayWithUrl:wordModel.unPVoice];
    }
    [[LGDicPlayer shareInstance] play];
}
- (void)usVoiceAction{
    LGDicModel *wordModel = [self.categoryModel.categoryList firstObject];
    [[LGDicPlayer shareInstance] stop];
    if ([LGDicConfig shareInstance].appendDomain) {
        [[LGDicPlayer shareInstance] startPlayWithUrl:[[LGDicConfig shareInstance].voiceUrl stringByAppendingString:wordModel.usPVoice]];
    }else{
        [[LGDicPlayer shareInstance] startPlayWithUrl:wordModel.usPVoice];
    }
    [[LGDicPlayer shareInstance] play];
}
- (void)allExpandAction{
    if (self.allExpandBlock) {
        self.allExpandBlock(YES);
    }
}
- (void)allFoldAction{
    if (self.allExpandBlock) {
        self.allExpandBlock(NO);
    }
}
#pragma mark getter
- (UILabel *)wordL{
    if (!_wordL) {
        _wordL = [UILabel new];
        _wordL.textColor = LGDictionaryColorHex(0xFC6000);
        _wordL.font = [UIFont systemFontOfSize:30];
    }
    return _wordL;
}
- (UILabel *)textL{
    if (!_textL) {
        _textL = [UILabel new];
        _textL.backgroundColor = [UIColor whiteColor];
        _textL.textColor = [UIColor darkGrayColor];
        _textL.font = [UIFont systemFontOfSize:15];
        _textL.numberOfLines = 0;
    }
    return _textL;
}
- (UIButton *)enVoiceBtn{
    if (!_enVoiceBtn) {
        _enVoiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _enVoiceBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_enVoiceBtn setImage:[NSBundle lg_imageName:@"lg_voice"] forState:UIControlStateNormal];
        [_enVoiceBtn setTitle:@" 英['steibI]" forState:UIControlStateNormal];
        [_enVoiceBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_enVoiceBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
        [_enVoiceBtn addTarget:self action:@selector(enVoiceAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _enVoiceBtn;
}
- (UIButton *)usVoiceBtn{
    if (!_usVoiceBtn) {
        _usVoiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _usVoiceBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_usVoiceBtn setImage:[NSBundle lg_imageName:@"lg_voice"] forState:UIControlStateNormal];
        [_usVoiceBtn setTitle:@" 美['steibI]" forState:UIControlStateNormal];
        [_usVoiceBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_usVoiceBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
        [_usVoiceBtn addTarget:self action:@selector(usVoiceAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _usVoiceBtn;
}
- (UIButton *)allExpandBtn{
    if (!_allExpandBtn) {
        _allExpandBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _allExpandBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_allExpandBtn setImage:[NSBundle lg_imageName:@"lg_expand_n"] forState:UIControlStateNormal];
        [_allExpandBtn setImage:[NSBundle lg_imageName:@"lg_expand_s"] forState:UIControlStateSelected];
        [_allExpandBtn setTitle:@" 全部展开" forState:UIControlStateNormal];
        [_allExpandBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_allExpandBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
        [_allExpandBtn addTarget:self action:@selector(allExpandAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allExpandBtn;
}
- (UIButton *)allFoldBtn{
    if (!_allFoldBtn) {
        _allFoldBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _allFoldBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_allFoldBtn setImage:[NSBundle lg_imageName:@"lg_fold_n"] forState:UIControlStateNormal];
        [_allFoldBtn setImage:[NSBundle lg_imageName:@"lg_fold_s"] forState:UIControlStateSelected];
        [_allFoldBtn setTitle:@" 全部折叠" forState:UIControlStateNormal];
        [_allFoldBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_allFoldBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
        [_allFoldBtn addTarget:self action:@selector(allFoldAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allFoldBtn;
}
@end