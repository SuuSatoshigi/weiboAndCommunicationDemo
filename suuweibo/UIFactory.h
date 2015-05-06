//
//  UIFactory.h
//  suuweibo
//
//  Created by suusatoshigi on 15-5-6.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThemeManager.h"
#import "ThemeImageView.h"
#import "ThemeLable.h"
@interface UIFactory : NSObject

+ (ThemeImageView *)createThemeImageView:(NSString *)imageName;

+ (ThemeLable *)createThemeLable:(NSString *)colorName;
@end
