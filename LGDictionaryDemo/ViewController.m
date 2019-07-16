//
//  ViewController.m
//  LGDicDemo
//
//  Created by 刘亚军 on 2018/4/2.
//  Copyright © 2018年 刘亚军. All rights reserved.
//

#import "ViewController.h"
#import "LGDicMainViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)inquireWord:(UIButton *)sender {
   LGDicMainViewController *dicVC = [[LGDicMainViewController alloc] init];
    dicVC.config.dicUrl = @"http://192.168.129.129:10103";
    dicVC.config.userID = @"110";
    dicVC.config.parameters = @{
                                 @"Knowledge":@"",
                                 @"levelCode":@""
                                 };
    dicVC.config.wordKey = @"Knowledge";
    dicVC.config.word = self.textField.text;
    dicVC.config.queryBlock = ^(NSString *word) {
        NSLog(@"搜索的单词:%@",word);
    };
    [self.navigationController pushViewController:dicVC animated:YES];
}
@end
