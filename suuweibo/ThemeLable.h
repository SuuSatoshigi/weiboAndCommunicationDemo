//
//  ThemeLable.h
//  suuweibo
//
//  Created by suusatoshigi on 15-5-7.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeLable : UILabel
@property (nonatomic, copy) NSString *colorName;

- (instancetype)initWithColorName:(NSString *)colorName;
@end
