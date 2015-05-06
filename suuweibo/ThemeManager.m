//
//  ThemeManager.m
//  suuweibo
//  用于更换主题
//  Created by suusatoshigi on 15-5-5.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import "ThemeManager.h"


static ThemeManager *singleThemeObject = nil;

@implementation ThemeManager
//设计单例模式
+ (ThemeManager *)shareInstance {
    if (singleThemeObject == nil) {
        //添加同步锁
        @synchronized(self){
            singleThemeObject = [[ThemeManager alloc] init];
        }
    }
    return singleThemeObject;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSString *themePath = [[NSBundle mainBundle] pathForResource:@"theme" ofType:@"plist"];
        self.themesPlist = [NSDictionary dictionaryWithContentsOfFile:themePath];
        //使用默认主题
        self.themeName = nil;
    }
    return self;
}

- (NSString *)getThemePath {
    //程序包的根目录
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    if (self.themeName == nil) {
        //如果主题名为空，则使用项目包根目录下的默认主题图片
        return resourcePath;
    }
    
    //取得主题目录, 如：Skins/blue
    NSString *themePath = [self.themesPlist objectForKey:_themeName];
    
    
    //完整的主题包目录
    NSString *path = [resourcePath stringByAppendingPathComponent:themePath];
    
    return path;
}

- (UIImage *)getThemesImage:(NSString *)imageName {
    
    if (imageName.length == 0) {
        return nil;
    }
    
    //获取主题目录
    NSString *themePath = [self getThemePath];
    //imageName在当前主题的路径
    NSString *imagePath = [themePath stringByAppendingPathComponent:imageName];
    
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    
    return image;
}

- (UIColor *)getColorWithName:(NSString *)name {
    if (name.length != 0) {
        return nil;
    }
    
    //三色值
    NSString *rgb = [_fontColorPlist objectForKey:name];
    NSArray *rgbs = [rgb componentsSeparatedByString:@","];
    if (rgbs.count == 3) {
        float r = [rgbs[0] floatValue];
        float g = [rgbs[1] floatValue];
        float b = [rgbs[2] floatValue];
        UIColor *color = color(r, g, b, 1);
        return color;
    }
    return nil;
}


//切换主题时设置主题名称
- (void)setThemeName:(NSString *)themeName {
    if (_themeName != themeName) {
        [_themeName release];
        _themeName = [themeName copy];
    }
    NSString *themePath = [self getThemePath];
    NSString *path = [themePath stringByAppendingPathComponent:@"fontColor.plist"];
    self.fontColorPlist = [NSDictionary dictionaryWithContentsOfFile:path];
}
#pragma mark -- those method use tosynchronized
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    @synchronized(self) {
        if (singleThemeObject == nil) {
            singleThemeObject = [super allocWithZone:zone];
        }
    }
    return singleThemeObject;
}

- (id)retain {
    return self;
}

- (NSUInteger)retainCount {
    return NSUIntegerMax;  //denotes an object that cannot be released
}

- (void)release {
    //do nothing
}

- (id)autorelease {
    return self;
}
@end
