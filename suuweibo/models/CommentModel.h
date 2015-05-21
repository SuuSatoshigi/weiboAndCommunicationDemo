//
//  CommentModel.h
//  suuweibo
//
//  Created by suusatoshigi on 15-5-20.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import "BaseModel.h"
#import "UserModel.h"
#import "WeiboModel.h"
@interface CommentModel : BaseModel
@property(nonatomic,copy)NSString *created_at;	//string	评论创建时间
@property(nonatomic,retain)NSNumber *id;	//int64	评论的ID
@property(nonatomic,copy)NSString *text;	//string	评论的内容
@property(nonatomic,copy)NSString *source;	//string	评论的来源
@property(nonatomic,retain)UserModel *user;	//object	评论作者的用户信息字段 详细
@property(nonatomic,copy)NSString *mid;	//string	//评论的MID
@property(nonatomic,copy)NSString *idstr;	//string	字符串型的评论ID
@property(nonatomic,retain)WeiboModel *weibo;//

@end
