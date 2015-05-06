//
//  ThemeImageView.h
//  suuweibo
//
//  Created by suusatoshigi on 15-5-6.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeImageView : UIImageView

@property (nonatomic, copy)NSString *imageName;

- (instancetype)initWithImageName:(NSString *)imageName;

@end
