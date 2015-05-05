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
        NSString *themePath = [[NSBundle mainBundle] pathForResource:@"theme" ofType:@"pllist"];
        self.themesPlist = [NSDictionary dictionaryWithContentsOfFile:themePath];
        //使用默认主题
        self.themeName = nil;
    }
    return self;
}

- (NSString *)getThemePath {
    //获取包路径
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    if (self.themeName == nil) {
        return resourcePath;
    }
    
    //获取主题包路径
    NSString *themePath = [_themesPlist objectForKey:_themeName];
    //拼接成完整路径
    NSString *path = [resourcePath stringByAppendingString:themePath];
    return path;
}

- (UIImage *)getThemesImage:(NSString *)imageName {
    if (_themeName.length == 0) {
        return nil;
    }
    //当前主题目录位置
    NSString *themePath = [self getThemePath];
    //获取到图片的完整路径
    NSString *imagePath = [themePath stringByAppendingString:_themeName];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    return image;
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
