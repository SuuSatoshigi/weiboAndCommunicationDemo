//
//  WeiboView.m
//  suuweibo
//
//  Created by suusatoshigi on 15-5-11.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import "WeiboView.h"

@implementation WeiboView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _initView];
    }
    return self;
}

//frame在layout中设置
- (void)_initView {
    //可以用initwithframe
    _textLabel = [[RTLabel alloc] init];
//    _textLabel.delegate = self;
    
}

#pragma mark -- delegate

@end
