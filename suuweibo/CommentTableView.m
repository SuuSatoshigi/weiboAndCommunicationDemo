//
//  CommentTableView.m
//  suuweibo
//
//  Created by suusatoshigi on 15-5-20.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import "CommentTableView.h"
#import "CommentCell.h"
@implementation CommentTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"CommentCell";
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CommentCell" owner:self options:nil] lastObject];
        //取消选中效果
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    CommentModel *commentModel = [self.data objectAtIndex:indexPath.row];
    cell.commentModel = commentModel;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentModel *commentModel = [self.data objectAtIndex:indexPath.row];
    float h = [CommentCell getCommentHeight:commentModel];
    return h +40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
