//
//  WeiboBaseModel.m
//  suuweibo
//
//  Created by suusatoshigi on 15-5-7.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import "WeiboModel.h"

@implementation WeiboModel
- (NSDictionary *)attributeMapDictionary {
    NSDictionary *mapAtt = @{
                             @"createDate":@"created_at",
                             @"weiboId":@"id",
                             @"text":@"text",
                             @"source":@"source",
                             @"favorited":@"favorited",
                             @"thumbnailImage":@"thumbnail_pic",
                             @"bmiddleImage":@"bmiddle_pic",
                             @"originalImage":@"original_pic",
                             @"geo":@"geo",
                             @"repostsCount":@"reposts_count",
                             @"commentsCount":@"comments_count"
                             };
    
    return mapAtt;
}

//需要额外赋值的usermodel和weibomodel对象
- (void)setAttributes:(NSDictionary *)dataDic {
    //将字典映射关系填入到字典对象
    [super setAttributes:dataDic];
    
    NSDictionary *relWeiboStatus = [dataDic objectForKey:@"retweeted_status"];
    if (relWeiboStatus != nil) {
        WeiboModel *weibo = [[WeiboModel alloc] initWithDataDic:relWeiboStatus];
        self.relWeibo = weibo;
        [weibo release];
    }
    
    
    NSDictionary *user = [dataDic objectForKey:@"user"];
    if (user != nil) {
        UserModel *userModel = [[UserModel alloc] initWithDataDic:user];
        self.user = userModel;
        [user release];
    }
    
}
@end
