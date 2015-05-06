//
//  ThemeLable.m
//  suuweibo
//
//  Created by suusatoshigi on 15-5-7.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import "ThemeLable.h"
#import "ThemeManager.h"
@implementation ThemeLable
//最好复写这个方法。写监听通知的代码，因为其等级最高
- (instancetype)init {
    self = [super init];
    if (self != nil) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeNotification:) name:kThemeDidChangeNotification object:nil];
    }
    return self;
}

- (instancetype)initWithColorName:(NSString *)colorName {
    self = [super init];
    if (self != nil) {
        self.colorName = colorName;
    }
    return self;
}

- (void)setColor {
    UIColor *color = [[ThemeManager shareInstance] getColorWithName:_colorName];
    self.textColor = color;
}

- (void)setColorName:(NSString *)colorName {
    if (_colorName != colorName) {
        [_colorName release];
        _colorName = [colorName copy];
    }
    [self setColor];
}

#pragma mark -- notification activity
- (void)themeNotification:(NSNotification *)notification {
    [self setColor];
}

- (void)dealloc {
    [super dealloc];
    //移除所有绑定的通知减少安全隐患
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
