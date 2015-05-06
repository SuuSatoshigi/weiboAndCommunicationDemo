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
@property (retain, nonatomic) NSString *themeName;
@property (retain, nonatomic) NSDictionary *fontColorPlist;
@property (retain, nonatomic) NSDictionary *themesPlist;

+ (ThemeManager *)shareInstance;

//由图片名返回图片
- (UIImage *)getThemesImage:(NSString *)imageName;
- (UIColor *)getColorWithName:(NSString *)name;
@end
