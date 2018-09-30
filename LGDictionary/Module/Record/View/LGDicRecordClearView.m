//
//  LGDicRecordClearView.m
//  LGDictionaryDemo
//
//  Created by 刘亚军 on 2018/9/28.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import "LGDicRecordClearView.h"
#import <Masonry/Masonry.h>
#import "LGDictionaryConst.h"

@interface LGDicRecordClearView ()
/** 标题 */
@property (nonatomic,strong) UILabel *titleL;
/** 清除按钮 */
@property (nonatomic,strong) UIButton *clearBtn;
@end
@implementation LGDicRecordClearView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self layoutUI];
    }
    return self;
}
- (void)layoutUI{
    [self addSubview:self.titleL];
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_left).offset(10);
    }];
    [self addSubview:self.clearBtn];
    [self.clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(26);
        make.width.mas_equalTo(64);
    }];
}
- (void)clearBtnAction:(UIButton *) btn{
    if (self.clearBlock) {
        self.clearBlock();
    }
}
- (void)setIsHideClearBtn:(BOOL)isHideClearBtn{
    _isHideClearBtn = isHideClearBtn;
    self.clearBtn.hidden = isHideClearBtn;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [UILabel new];
        _titleL.text = @"搜索历史";
        _titleL.textColor = [UIColor lightGrayColor];
        _titleL.font = [UIFont systemFontOfSize:15];
    }
    return _titleL;
}
- (UIButton *)clearBtn{
    if (!_clearBtn) {
        _clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clearBtn setTitle:@"清空历史" forState:UIControlStateNormal];
        _clearBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_clearBtn setTitleColor:LGDictionaryColorHex(0x009AFC) forState:UIControlStateNormal];
        [_clearBtn addTarget:self action:@selector(clearBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearBtn;
}
@end
