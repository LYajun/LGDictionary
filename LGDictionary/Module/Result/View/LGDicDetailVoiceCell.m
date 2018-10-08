//
//  LGDicDetailVoiceCell.m
//  LGDictionaryDemo
//
//  Created by 刘亚军 on 2018/9/30.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import "LGDicDetailVoiceCell.h"
#import <Masonry/Masonry.h>
#import "LGDicCategoryModel.h"
#import "LGDicModel.h"
#import "NSBundle+LGDictionary.h"
#import "LGDicPlayer.h"
#import "LGDicConfig.h"
#import "LGDictionaryConst.h"

@interface LGDicDetailVoiceCell ()
@property (strong, nonatomic) UILabel *titleL;
@property (strong, nonatomic) UIButton *voiceBtn;
@property (nonatomic,copy) NSString *voiceUrl;
@end
@implementation LGDicDetailVoiceCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self layoutUI];
    }
    return self;
}
- (void)layoutUI{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.voiceBtn];
    [self.voiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView);
        make.width.height.mas_equalTo(40);
    }];
    [self.contentView addSubview:self.titleL];
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.voiceBtn.mas_right);
        make.top.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_greaterThanOrEqualTo(30);
    }];
}

- (void)setTextModel:(LGDicCategoryModel *)textModel adIndexPath:(NSIndexPath *)indexPath{
    SenCollectionModel *senModel = textModel.categoryList[indexPath.row];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithAttributedString:senModel.sentenceEn_attr];
    [att appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
    [att appendAttributedString:senModel.sTranslation_attr];
    self.titleL.attributedText = att;
    self.voiceUrl = senModel.sViocePath;
}
- (void)setVoiceUrl:(NSString *)voiceUrl{
    _voiceUrl = voiceUrl;
    self.voiceBtn.hidden = (LGDictionaryIsStrEmpty(voiceUrl) ? YES : NO);
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [UILabel new];
        _titleL.numberOfLines = 0;
        _titleL.textColor = [UIColor darkGrayColor];
        _titleL.font = [UIFont systemFontOfSize:16];
    }
    return _titleL;
}
- (UIButton *)voiceBtn{
    if (!_voiceBtn) {
        _voiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_voiceBtn setImage:[NSBundle lg_imageName:@"lg_voice"] forState:UIControlStateNormal];
        [_voiceBtn addTarget:self action:@selector(voiceAction) forControlEvents:UIControlEventTouchUpInside];
        [_voiceBtn setImageEdgeInsets: UIEdgeInsetsMake(-8, 0, 0, 0)];
    }
    return _voiceBtn;
}
- (void)voiceAction{
    [[LGDicPlayer shareInstance] stop];
    if ([LGDicConfig shareInstance].appendDomain) {
        [[LGDicPlayer shareInstance] startPlayWithUrl:[[LGDicConfig shareInstance].voiceUrl stringByAppendingString:self.voiceUrl]];
    }else{
        [[LGDicPlayer shareInstance] startPlayWithUrl:self.voiceUrl];
    }
    [[LGDicPlayer shareInstance] play];
}
@end
