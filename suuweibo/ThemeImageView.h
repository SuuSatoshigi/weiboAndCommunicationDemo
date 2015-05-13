//
//  ThemeImageView.h
//  suuweibo
//
//  Created by suusatoshigi on 15-5-6.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeImageView : UIImageView

@property(nonatomic, copy)NSString *imageName;


//为了防止切换主题时，转发微博背景变形
@property(nonatomic,assign)int leftCapWidth;
@property(nonatomic,assign)int topCapHeight;

- (instancetype)initWithImageName:(NSString *)imageName;

@end
