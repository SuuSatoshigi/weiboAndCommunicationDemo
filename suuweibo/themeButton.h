//
//  themeButton.h
//  suuweibo
//
//  Created by suusatoshigi on 15-5-5.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface themeButton : UIButton

@property (retain, nonatomic) NSString *imageName;
@property (retain, nonatomic) NSString *highLightImageName;
@property (retain, nonatomic) NSString *backgroundImageName;
@property (retain, nonatomic) NSString *backgroundHighLightImageName;

- (instancetype)initWithImage:(NSString *)imageName highlighted:(NSString *)highlightImageName;
- (instancetype)initWithBackgound:(NSString *)backgroundImageName
            highlightedBackground:(NSString *)backgroundHighLightImageName;
@end
