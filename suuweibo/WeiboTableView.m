//
//  WeiboTableView.m
//  suuweibo
//
//  Created by suusatoshigi on 15-5-17.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import "WeiboTableView.h"
#import "WeiboCell.h"
#import "WeiboModel.h"
#import "WeiboView.h"
#import "DetailViewController.h"

@implementation WeiboTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self != nil) {

    }
    return self;
}


#pragma mark --delegate
//可以直接调用父类
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.data.count;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"weiboCell";
    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[[WeiboCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify] autorelease];
    }
    WeiboModel *weibo = [self.data objectAtIndex:indexPath.row];
    cell.weibo = weibo;
    
    return cell;
}

//不能使用创建cell对象的方法获得参数，因为会产生死循环
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeiboModel *weibo = [self.data objectAtIndex:indexPath.row];
    //weibocell的子视图都不是转发视图，这个高度仅仅是weibo视图的高度，不是cell的高度
    float height = [WeiboView getWeiboViewHeight:weibo isRepost:NO isDetail:NO];
    height += 50;
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WeiboModel *weibo = [self.data objectAtIndex:indexPath.row];
    DetailViewController *detail = [[[DetailViewController alloc] initWithNibName:nil bundle:nil] retain];
    detail.weiboModel = weibo;
    [self.viewController.navigationController pushViewController:detail animated:YES];
    [detail release];
}
@end
