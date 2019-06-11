//
//  LGSearchBar.m
//  LGDictionaryDemo
//
//  Created by 刘亚军 on 2018/9/27.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import "LGSearchBar.h"
#import "NSBundle+LGDictionary.h"
#import "LGDicAlertView.h"
#import <BlocksKit/UITextField+BlocksKit.h>


@interface LGSearchBar ()
/** 搜索内容 */
@property (nonatomic,copy) NSString *searchString;
@property (nonatomic, strong) UIToolbar *customAccessoryView;
@end

@implementation LGSearchBar
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self config];
    }
    return self;
}
- (void)config{
    self.inputAccessoryView = self.customAccessoryView;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[NSBundle lgd_imageName:@"lg_search"]];
    imageView.contentMode = UIViewContentModeCenter;
    CGRect frame = imageView.frame;
    frame.size.width = imageView.frame.size.width + 10;
    imageView.frame = frame;
    self.backgroundColor = [UIColor whiteColor];
    self.tintColor = [UIColor lightGrayColor];
    self.placeholder = @"请输入要查询的单词";
    self.font = [UIFont systemFontOfSize:14];
//    self.borderStyle = UITextBorderStyleRoundedRect;
    self.layer.cornerRadius = self.frame.size.height/2;
    self.layer.masksToBounds = YES;
    self.leftView = imageView;
    self.leftViewMode = UITextFieldViewModeAlways;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.returnKeyType = UIReturnKeySearch;
    
    [self addTarget:self action:@selector(lg_textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    __weak typeof(self) weakSelf = self;
    self.bk_shouldChangeCharactersInRangeWithReplacementStringBlock = ^BOOL(UITextField *textField, NSRange range, NSString *string) {
        return [weakSelf lg_textField:textField shouldChangeCharactersInRange:range replacementString:string];
    };
    
    self.bk_shouldReturnBlock = ^BOOL(UITextField *textField) {
        return [weakSelf lg_textFieldShouldReturn:textField];
    };
}
- (void)clearText{
    self.searchString = @"";
    self.text = @"";
}
- (void)clearAction{
    self.text = @"";
}
- (void)done{
    [self resignFirstResponder];
}
// 使textField不把输入的拼音认作文本编辑框的内容
- (void)lg_textFieldDidChange:(UITextField *) textField{
    UITextRange *selectedRange = [textField markedTextRange];
    NSString *newText = [textField textInRange:selectedRange];
    if (newText.length <= 0) {
        self.searchString = [[textField.text lowercaseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        self.text = self.searchString;
    }
}

- (BOOL)lg_textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.text.length > 50) {
        return NO;
    }
    return YES;
}
- (BOOL)lg_textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (self.searchString.length > 0) {
        if (self.lgDelegate && [self.lgDelegate respondsToSelector:@selector(lg_searchBar:didSearchWord:)]) {
            [self.lgDelegate lg_searchBar:self didSearchWord:self.searchString];
        }
    }else{
        [LGDicAlertView showWithText:@"输入不能为空!"];
    }
    return YES;
}
- (UIToolbar *)customAccessoryView{
    if (!_customAccessoryView) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        _customAccessoryView = [[UIToolbar alloc]initWithFrame:(CGRect){0,0,width,40}];
        _customAccessoryView.barTintColor = [UIColor whiteColor];
        UIBarButtonItem *clear = [[UIBarButtonItem alloc]initWithTitle:@"清空" style:UIBarButtonItemStyleDone target:self action:@selector(clearAction)];
        UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *finish = [[UIBarButtonItem alloc]initWithTitle:@"收起" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
        [_customAccessoryView setItems:@[clear,space,finish]];
        
    }
    return _customAccessoryView;
}

@end
