//
//  LGDicRecordFlowCell.m
//  LGDictionaryDemo
//
//  Created by 刘亚军 on 2018/9/28.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import "LGDicRecordFlowCell.h"
#import "LGDictionaryConst.h"
#import <Masonry/Masonry.h>
#import "NSBundle+LGDictionary.h"

@interface LGDicRecordFlowCell ()
@property (strong, nonatomic) UILabel *contentL;
@end
@implementation LGDicRecordFlowCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configure];
        [self layoutUI];
    }
    return self;
}
- (void)layoutUI{
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.contentL];
    [self.contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    [self clipContentLLayerToRoundWithRadius:4 width:1 color:LGDictionaryColorHex(0xDCDCDC)];
}
- (void)configure{
    _isChoice = NO;
}
- (void)setText:(NSString *)text{
    _text = text;
    self.contentL.text = text;
}
- (void)setTextBgColor:(UIColor *)textBgColor{
    _textBgColor = textBgColor;
    self.contentL.backgroundColor = textBgColor;
}
- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    self.contentL.textColor = textColor;
}
- (void)setBorderColor:(UIColor *)borderColor{
    _borderColor = borderColor;
    [self clipContentLLayerToRoundWithRadius:4 width:1 color:borderColor];
}
- (void)setIsChoice:(BOOL)isChoice{
    _isChoice = isChoice;
    if (_isChoice) {
        [self clipContentLLayerToRoundWithRadius:4 width:1 color:[UIColor darkGrayColor]];
    }else{
        [self clipContentLLayerToRoundWithRadius:4 width:0 color:nil];
    }
}
- (void)clipContentLLayerToRoundWithRadius:(CGFloat)r width:(CGFloat)w color:(UIColor *)color{
    self.contentL.layer.cornerRadius = r;
    self.contentL.layer.borderWidth = w;
    self.contentL.layer.borderColor = color.CGColor;
    self.contentL.layer.masksToBounds = YES;
}
- (UILabel *)contentL{
    if (!_contentL) {
        _contentL = [[UILabel alloc] init];
        _contentL.textAlignment = NSTextAlignmentCenter;
        _contentL.font = [UIFont systemFontOfSize:16];
        _contentL.numberOfLines = 0;
        _contentL.textColor = LGDictionaryColorHex(0x4D4D4D);
        _contentL.backgroundColor = LGDictionaryColorHex(0xDCDCDC);
    }
    return _contentL;
}
@end
