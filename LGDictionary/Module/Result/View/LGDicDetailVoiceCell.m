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
@property (strong, nonatomic) UIImageView *playGifImage;
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
    [self.contentView addSubview:self.playGifImage];
    [self.playGifImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.voiceBtn);
        make.centerY.equalTo(self.voiceBtn).offset(-1);
        make.width.height.mas_equalTo(20);
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopGif) name:LGDictionaryPlayerDidFinishPlayNotification object:nil];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)stopGif{
    self.playGifImage.hidden = YES;
    [self.playGifImage stopAnimating];
}

- (void)setTextModel:(LGDicCategoryModel *)textModel adIndexPath:(NSIndexPath *)indexPath{
    SenCollectionModel *senModel = textModel.categoryList[indexPath.row];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithAttributedString:senModel.sentenceEn_attr];
    [att appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
    [att appendAttributedString:senModel.sTranslation_attr];
//    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, att.length)];
    [att addAttribute:NSForegroundColorAttributeName value:LGDictionaryColorHex(0x282828) range:NSMakeRange(0, att.length)];
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
        [_voiceBtn setImage:[NSBundle lgd_imageName:@"lg_voice"] forState:UIControlStateNormal];
        [_voiceBtn addTarget:self action:@selector(voiceAction) forControlEvents:UIControlEventTouchUpInside];
        [_voiceBtn setImageEdgeInsets: UIEdgeInsetsMake(-3, 0, 0, 0)];
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
    self.playGifImage.hidden = NO;
    [self.playGifImage startAnimating];
}
- (UIImageView *)playGifImage{
    if (!_playGifImage) {
        _playGifImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        _playGifImage.backgroundColor = [UIColor whiteColor];
        _playGifImage.animationImages = [NSBundle lgd_imageVoiceGifs];
        _playGifImage.animationDuration = 1.0;
        _playGifImage.hidden = YES;
    }
    return _playGifImage;
}
@end
