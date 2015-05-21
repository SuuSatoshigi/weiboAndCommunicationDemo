//
//  CommentModel.m
//  suuweibo
//
//  Created by suusatoshigi on 15-5-20.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import "CommentModel.h"



@implementation CommentModel

- (void)setAttributes:(NSDictionary *)dataDic {
    [super setAttributes:dataDic];
    
    NSDictionary *userDic = [dataDic objectForKey:@"user"];
    NSDictionary *statusDic = [dataDic objectForKey:@"status"];
    
    UserModel *user = [[UserModel alloc] initWithDataDic:userDic];
    WeiboModel *weibo = [[WeiboModel alloc] initWithDataDic:statusDic];
    
    self.user = [user autorelease];
    self.weibo = [weibo autorelease];
}

@end
