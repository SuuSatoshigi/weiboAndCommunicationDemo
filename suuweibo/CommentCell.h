//
//  CommentCell.h
//  suuweibo
//
//  Created by suusatoshigi on 15-5-20.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"

@class CommentModel;
@interface CommentCell : UITableViewCell<RTLabelDelegate>{
    UIImageView *_userImage;
    UILabel *_nicklabel;
    UILabel *_timeLabel;
    RTLabel *_contentLabel;
}

@property(nonatomic, retain)CommentModel *commentModel;
//计算评论单元格高度
+ (float)getCommentHeight:(CommentModel *)commentModel;
@end
