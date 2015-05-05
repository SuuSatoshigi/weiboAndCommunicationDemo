//
//  ThemeManager.h
//  suuweibo
//
//  Created by suusatoshigi on 15-5-5.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kThemeDidChangeNotification @"kThemeDidChangeNotification"

@interface ThemeManager : NSObject
//当前主题名
@property (strong, nonatomic) NSString * themeName;

@property (strong, nonatomic) NSDictionary * themesPlist;

+ (ThemeManager *)shareInstance;

//由图片名返回图片
- (UIImage *)getThemesImage:(NSString *)imageName;
@end
