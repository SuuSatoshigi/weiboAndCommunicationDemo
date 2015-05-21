//
//  CommentCell.m
//  suuweibo
//
//  Created by suusatoshigi on 15-5-20.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import "CommentCell.h"
#import "CommentModel.h"
#import "UIImageView+WebCache.h"
#import "UIUtils.h"
//新方式写cell，创建cell
@implementation CommentCell
//cell xib use it
- (void)awakeFromNib {
    // Initialization code
    _userImage = [(UIImageView *)[self viewWithTag:100] retain];
    _nicklabel = [(UILabel *)[self viewWithTag:101] retain];
    _timeLabel = [(UILabel *)[self viewWithTag:102] retain];
    
    //需要根据文本重新设置高度
    _contentLabel = [[RTLabel alloc] initWithFrame:CGRectZero];
    
    _contentLabel.font = [UIFont systemFontOfSize:14.0f];
    _contentLabel.delegate = self;
    //设置链接颜色
    _contentLabel.linkAttributes = [NSDictionary dictionaryWithObject:@"#4595CB" forKey:@"color"];
    //设置链接高亮
    _contentLabel.selectedLinkAttributes = [NSDictionary dictionaryWithObject:@"darkGray" forKey:@"color"];
    //add to content
    [self.contentView addSubview:_contentLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSString *url = self.commentModel.user.profile_image_url;
    [_userImage setImageWithURL:[NSURL URLWithString:url]];
    _userImage.layer.cornerRadius = 5;
    //设置超过子图层的部分裁减掉
    //UI框架中使用的方法
    _userImage.layer.masksToBounds = YES;
    
    _nicklabel.text = self.commentModel.user.screen_name;
    _timeLabel.text = [UIUtils fomateString:self.commentModel.created_at];
    
    _contentLabel.frame = CGRectMake([SuuUitil right:_userImage.frame]+10, [SuuUitil bottom:_nicklabel.frame]+5, 240, 21);
    NSString *commt = self.commentModel.text;
    commt = [UIUtils parseLink:commt];
    _contentLabel.text = commt;
    _contentLabel.frame = [SuuUitil setHeight:_contentLabel.frame sendHeight:_contentLabel.optimumSize.height];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//计算评论单元格高度
+ (float)getCommentHeight:(CommentModel *)commentModel {
    RTLabel *rt = [[RTLabel alloc] initWithFrame:CGRectMake(0, 0, 240, 0)];
    rt.font = [UIFont systemFontOfSize:14.0f];
    rt.text = commentModel.text;
    return rt.optimumSize.height;
}

#pragma mark - RTLabel delegate
- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL *)url {
    
}
@end
