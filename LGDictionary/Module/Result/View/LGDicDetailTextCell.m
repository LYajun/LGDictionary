//
//  LGDicDetailTextCell.m
//  LGDictionaryDemo
//
//  Created by 刘亚军 on 2018/9/30.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import "LGDicDetailTextCell.h"
#import <Masonry/Masonry.h>
#import "LGDicCategoryModel.h"
#import "LGDicModel.h"
#import "LGDictionaryConst.h"

@interface LGDicDetailTextCell ()
@property (strong, nonatomic) UILabel *titleL;
@end
@implementation LGDicDetailTextCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self layoutUI];
    }
    return self;
}

- (void)layoutUI{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.titleL];
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(5);
    }];
}
- (void)setText:(NSAttributedString *)text{
    self.titleL.attributedText = text;
}
- (void)setTextModel:(LGDicCategoryModel *)textModel adIndexPath:(NSIndexPath *)indexPath{
    switch (textModel.categoryType) {
        case LGDicCategoryTypeColt:
        {
            SenCollectionModel *senModel = textModel.categoryList[indexPath.row];
            NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithAttributedString:senModel.sentenceEn_attr];
            [att appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
            [att appendAttributedString:senModel.sTranslation_attr];
            [att addAttribute:NSForegroundColorAttributeName value:LGDictionaryColorHex(0x282828) range:NSMakeRange(0, att.length)];
            self.titleL.attributedText = att;
        }
            break;
        case LGDicCategoryTypeClassic:
        {
            ClassicCollectionModel *classicModel = textModel.categoryList[indexPath.row];
            NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithAttributedString:classicModel.title_attr];
            [att appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
            [att appendAttributedString:classicModel.content_attr];
            [att addAttribute:NSForegroundColorAttributeName value:LGDictionaryColorHex(0x282828) range:NSMakeRange(0, att.length)];
            self.titleL.attributedText = att;
        }
            break;
        case LGDicCategoryTypeRlt:
        {
            RltCollectionModel *rltModel = textModel.categoryList[indexPath.row];
            NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithAttributedString:rltModel.title_attr];
            [att appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
            [att appendAttributedString:rltModel.content_attr];
            [att addAttribute:NSForegroundColorAttributeName value:LGDictionaryColorHex(0x282828) range:NSMakeRange(0, att.length)];
            self.titleL.attributedText = att;
        }
            break;
        default:
            break;
    }
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
@end
