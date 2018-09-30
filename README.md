# LGDictionary
知识点课件，电子词典
<div align="left">
<img src="https://github.com/LYajun/LGDictionary/blob/master/Assets/dic1.PNG" width ="375" height ="667" >
<img src="https://github.com/LYajun/LGDictionary/blob/master/Assets/dic2.PNG" width ="375" height ="667" >
 </div>
 
## 使用方式

1、集成:

```
pod 'LGDictionary'
```

2、配置

```objective-c
/** 用户ID */
@property (nonatomic,copy) NSString *userID;
/** 词典地址 */
@property (nonatomic,copy) NSString *dicUrl;
/** 直接查询的单词 */
@property (nonatomic,copy) NSString *word;
/** 请求参数 */
@property (nonatomic,strong) NSDictionary *parameters;
/** 指定请求参数中键值对value为所查询的单词的key */
@property (nonatomic,copy) NSString *wordKey;
/** 请求类型 */
@property (nonatomic,assign) LGDicReqType reqType;
/** 对于音频地址缺失域名时的设置 */
/** 音频地址(Http://IP:Port) */
@property (nonatomic,copy) NSString *voiceUrl;
/** 音频地址是否需要拼接域名 */
@property (nonatomic,assign) BOOL appendDomain;
/** 单词查询回调 */
@property (nonatomic,copy) void (^queryBlock) (NSString *word);
```

3、使用

```objective-c
LGDicMainViewController *dicVC = [[LGDicMainViewController alloc] init];
dicVC.config.dicUrl = @"http://zh.lancooecp.com:10128/API/Resources/GetCourseware";
dicVC.config.userID = @"110";
dicVC.config.parameters = @{
                             @"Knowledge":@"",
                             @"levelCode":@""
                           };
dicVC.config.wordKey = @"Knowledge";
dicVC.config.queryBlock = ^(NSString *word) {
    NSLog(@"搜索的单词:%@",word);
};
[self.navigationController pushViewController:dicVC animated:YES];
```
