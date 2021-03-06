//
//  WeiboCell.m
//  suuweibo
//
//  Created by suusatoshigi on 15-5-11.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import "WeiboCell.h"
#import "WeiboView.h"
#import "WeiboModel.h"
#import "UIImageView+WebCache.h"

@implementation WeiboCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initView];
    }
    return self;
}

- (void)_initView {
    //－－－－－－用户头像－－－－－－－
    _userImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    _userImage.backgroundColor = [UIColor clearColor];
    //设置圆角
    _userImage.layer.cornerRadius = 5;//圆弧半径
    _userImage.layer.borderWidth = .5;//边框大小
    _userImage.layer.borderColor = [UIColor grayColor].CGColor;//
    _userImage.layer.masksToBounds =YES;//是否裁剪
    [self.contentView addSubview:_userImage];
    
//    －－－－昵称－－－－
    _nickLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _nickLabel.backgroundColor = [UIColor clearColor];
    _nickLabel.font = [UIFont systemFontOfSize:14.0];
    [self.contentView addSubview:_nickLabel];
    
    //－－－－转发数－－－
    _repostCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _repostCountLabel.backgroundColor = [UIColor clearColor];
    _repostCountLabel.font = [UIFont systemFontOfSize:12.0];
    _repostCountLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_repostCountLabel];
    
    //－－－－来源数－－－
    _sourceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _sourceLabel.backgroundColor = [UIColor clearColor];
    _sourceLabel.font = [UIFont systemFontOfSize:12.0];
    _sourceLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_sourceLabel];
    
    
    //－－－－发布时间数－－－
    _createLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _createLabel.backgroundColor = [UIColor clearColor];
    _createLabel.font = [UIFont systemFontOfSize:12.0];
    _createLabel.textColor = [UIColor blueColor];
    [self.contentView addSubview:_createLabel];
    
    //微博视图
    _weiboView = [[WeiboView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_weiboView];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //---用户头像视图－－
    _userImage.frame = CGRectMake(5, 5, 35, 35);
    NSString *userImageUrl = _weibo.user.profile_image_url;
    [_userImage setImageWithURL:[NSURL URLWithString:userImageUrl]];
    
//    －－昵称－－
    _nickLabel.frame = CGRectMake(50, 5, 200, 20);
    _nickLabel.text = _weibo.user.screen_name;
    
    //--微博视图
    _weiboView.weiboModel = _weibo;
    float h = [WeiboView getWeiboViewHeight:_weibo isRepost:NO isDetail:NO]; //weibo cell下的微博必定不是转发，转发的内容嵌套在微博里
#pragma warning --一定要改宽度
    _weiboView.frame = CGRectMake(50, CGRectGetMaxY(_nickLabel.frame), kWeibo_Width_List, h);//CGRectGetMaxY(_nickLabel.frame)是指在nicknamelabel下（bottom）
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
