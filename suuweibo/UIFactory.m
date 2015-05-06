//
//  UIFactory.m
//  suuweibo
//
//  Created by suusatoshigi on 15-5-6.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import "UIFactory.h"

@implementation UIFactory

+ (ThemeImageView *)createThemeImageView:(NSString *)imageName {
    ThemeImageView *imageView = [[ThemeImageView alloc] initWithImageName:imageName];
    return [imageView autorelease];
}

+ (ThemeLable *)createThemeLable:(NSString *)colorName {
    ThemeLable *label = [[ThemeLable alloc] initWithColorName:colorName];
    return [label autorelease];
}
@end
