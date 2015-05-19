//
//  SuuUitil.h
//  suuweibo
//
//  Created by suusatoshigi on 15-5-19.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SuuUitil : NSObject
+ (CGRect)setOriginX:(CGRect)frame sendX:(CGFloat)x;

+ (CGRect)setOriginY:(CGRect)frame sendY:(CGFloat)y;

+ (CGRect)setOriginXY:(CGRect)frame sendX:(CGFloat)x sendY:(CGFloat)y;

+ (CGSize) ScreenSize;

+ (CGFloat) ScreenHeight;

+ (CGFloat) ScreenWidth;

+ (CGRect)setHeight:(CGRect)frame sendHeight:(CGFloat)height;

+ (CGRect)setWidth:(CGRect)frame sendWidth:(CGFloat)width;

+ (CGRect)setHeightAndWidth:(CGRect)frame sendHeight:(CGFloat)height sendWidth:(CGFloat)width;
@end
