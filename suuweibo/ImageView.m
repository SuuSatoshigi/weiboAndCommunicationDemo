//
//  ImageView.m
//  suuweibo
//
//  Created by suusatoshigii on 15-5-27.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import "ImageView.h"

@implementation ImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //其他uiview都是开启的，只有uiimageview是默认关闭的（手势）
        self.UserInteractionEnabled = YES;
        //点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        //加入手势
        [self addGestureRecognizer:tap];
        [tap release];
    }
    return self;
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    if (self.touchBlock) {
        _touchBlock();
    }
}

- (void)dealloc {
    [super dealloc];
    //不能在上面release，因为这个block是每点击一次就调用一次，为了不循引用必须用release，为了下次还可以用这个block只能在dealloc调用
    Block_release(_touchBlock);
}
@end
