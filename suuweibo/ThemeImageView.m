//
//  ThemeImageView.m
//  suuweibo
//
//  Created by suusatoshigi on 15-5-6.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import "ThemeImageView.h"
#import "ThemeManager.h"
@implementation ThemeImageView
//使用nib时会调用这个方法而不会调用init
-(void)awakeFromNib {
    [super awakeFromNib];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeNotification:) name:kThemeDidChangeNotification object:nil];
}


- (instancetype)initWithImageName:(NSString *)imageName {
    self = [super init];
    if (self != nil) {
        self.imageName = imageName;
    }
    return self;
}

//最好复写这个方法。写监听通知的代码，因为其等级最高
- (instancetype)init {
    self = [super init];
    if (self != nil) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeNotification:) name:kThemeDidChangeNotification object:nil];
    }
    return self;
}

- (void)loadThemeImage {
    if (self.imageName == nil) {
        return ;
    }
    UIImage *image = [[ThemeManager shareInstance] getThemesImage:_imageName];
    self.image = image;
}

- (void)setImageName:(NSString *)imageName {
    if (_imageName != imageName) {
        [_imageName release];
        _imageName = [imageName copy];
    }
    [self loadThemeImage];
}

#pragma mark -- notification activity
- (void)themeNotification:(NSNotification *)notification {
    [self loadThemeImage];
}

- (void)dealloc {
    [super dealloc];
    //移除所有绑定的通知减少安全隐患
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
