//
//  SuuUitil.m
//  suuweibo
//
//  Created by suusatoshigi on 15-5-19.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import "SuuUitil.h"

@implementation SuuUitil

+ (CGRect)setOriginX:(CGRect)frame sendX:(CGFloat)x{
    CGRect myFrame = frame;
    myFrame.origin.x = x;
    return myFrame;
}

+ (CGRect)setOriginY:(CGRect)frame sendY:(CGFloat)y{
    CGRect myFrame = frame;
    myFrame.origin.y = y;
    return myFrame;
}

+ (CGRect)setOriginXY:(CGRect)frame sendX:(CGFloat)x sendY:(CGFloat)y{
    CGRect myFrame = frame;
    myFrame.origin.x = x;
    myFrame.origin.y = y;
    return myFrame;
}

+ (CGRect)setHeight:(CGRect)frame sendHeight:(CGFloat)height{
    CGRect myFrame = frame;
    myFrame.size.height = height;
    return myFrame;
}

+ (CGRect)setWidth:(CGRect)frame sendWidth:(CGFloat)width{
    CGRect myFrame = frame;
    myFrame.size.width = width;
    return myFrame;
}

+ (CGRect)setHeightAndWidth:(CGRect)frame sendHeight:(CGFloat)height sendWidth:(CGFloat)width{
    CGRect myFrame = frame;
    myFrame.size.height = height;
    myFrame.size.width = width;
    return myFrame;
}

+ (CGSize) ScreenSize{
    return [[UIScreen mainScreen] bounds].size;
}

+ (CGFloat) ScreenHeight{
    return [[UIScreen mainScreen] bounds].size.height;
}

+ (CGFloat) ScreenWidth{
    return [[UIScreen mainScreen] bounds].size.width;
}
@end
