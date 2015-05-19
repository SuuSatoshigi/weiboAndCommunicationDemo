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

+ (CGSize) ScreenSize{
    return [[UIScreen mainScreen] bounds].size;
}


@end
