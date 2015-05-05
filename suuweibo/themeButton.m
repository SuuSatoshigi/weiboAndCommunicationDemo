//
//  themeButton.m
//  suuweibo
//
//  Created by suusatoshigi on 15-5-5.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import "themeButton.h"
#import "ThemeManager.h"



@implementation themeButton
- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeNotification:) name:kThemeDidChangeNotification object:nil];
        
    }
    return self;
}

- (void)themeNotification:(NSNotification *)notification {
    [self loadImage];
}

- (instancetype)initWithImage:(NSString *)imageName highlighted:(NSString *)highlightImageName {
    self = [self init];
    if (self) {
        self.imageName = imageName;
        self.highLightImageName = highlightImageName;
    }
    return self;

}

- (instancetype)initWithBackgound:(NSString *)backgroundImageName
            highlightedBackground:(NSString *)backgroundHighLightImageName {
    self = [self init];
    if (self) {
        self.backgroundHighLightImageName  = backgroundHighLightImageName;
        self.backgroundHighLightImageName = backgroundHighLightImageName;
    }
    return self;
}

- (void)loadImage {
    ThemeManager *themeManager = [ThemeManager shareInstance];
    
    UIImage *image = [themeManager getThemesImage:_imageName];
    UIImage *highlightImage = [themeManager getThemesImage:_highLightImageName];
    
    [self setImage:image forState:UIControlStateNormal];
    [self setImage:highlightImage forState:UIControlStateHighlighted];
    
    UIImage *backImage = [themeManager getThemesImage:_backgroundImageName];
    UIImage *backHighlightImage = [themeManager getThemesImage:_backgroundHighLightImageName];
    
    [self setBackgroundImage:backImage forState:UIControlStateNormal];
    [self setBackgroundImage:backHighlightImage forState:UIControlStateHighlighted];
}

#pragma mark --setter
//复写是为了可以重加载
- (void)setImageName:(NSString *)imageName {
    if (_imageName != imageName) {
        [_imageName release];
        _imageName = [imageName copy];
    }
    [self loadImage];
}

- (void)setHighLightImageName:(NSString *)highLightImageName {
    if (_highLightImageName != highLightImageName) {
        [_highLightImageName release];
        _highLightImageName = [highLightImageName copy];
    }
    [self loadImage];
}

- (void)setBackgroundHighLightImageName:(NSString *)backgroundHighLightImageName {
    if (_backgroundHighLightImageName != backgroundHighLightImageName) {
        [_backgroundHighLightImageName release];
        _backgroundHighLightImageName = [backgroundHighLightImageName copy];
    }
    [self loadImage];
}

- (void)setBackgroundImageName:(NSString *)backgroundImageName {
    if (_backgroundImageName != backgroundImageName) {
        [_backgroundImageName release];
        _backgroundImageName = [backgroundImageName copy];
    }
    [self loadImage];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}
@end
