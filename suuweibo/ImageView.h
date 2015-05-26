//
//  ImageView.h
//  suuweibo
//
//  Created by suusatoshigii on 15-5-27.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ImageBlock)(void);

@interface ImageView : UIImageView

@property (nonatomic, copy)ImageBlock touchBlock;

@end
