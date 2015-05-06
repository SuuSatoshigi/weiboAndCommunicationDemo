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
- (id)init {
    self = [super init];
    if (self != nil) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeNotification:) name:kThemeDidChangeNotification object:nil];
    }
    return self;
}

- (id)initWithColorName:(NSString *)colorName {
    self = [self init];
    if (self != nil) {
        self.colorName = colorName;
    }
    return self;
}

- (void)setColorName:(NSString *)colorName {
    if (_colorName != colorName) {
        [_colorName release];
        _colorName = [colorName copy];
    }
    
    [self setColor];
}

- (void)setColor {
    UIColor *textColor = [[ThemeManager shareInstance] getColorWithName:_colorName];
    self.textColor = textColor;
}

#pragma mark - NSNotification actions
- (void)themeNotification:(NSNotification *)notification {
    [self setColor];
}



//移除所有绑定的通知减少安全隐患
- (void)dealloc {
    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_colorName release];
}

@end
