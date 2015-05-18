//
//  BaseTableView.h
//  suuweibo
//
//  Created by suusatoshigi on 15-5-17.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@class BaseTableView;
//为了使用delegate要写协议
@protocol UITableViewEventDelagate <NSObject>
//可选
@optional
//下拉
- (void)pullDown:(BaseTableView *)tableView;
//上拉
- (void)pullUp:(BaseTableView *)tableView;
//选中delegate
- (void)tableView:(BaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface BaseTableView : UITableView <EGORefreshTableHeaderDelegate, UITableViewDataSource, UITableViewDelegate>{
    EGORefreshTableHeaderView *_refreshTableHeaderView;
    BOOL _reloading;
}

@property(nonatomic, assign)BOOL refreshHeader;//是否需要下拉

@property(nonatomic, retain)NSArray *data;//为tableview提供数据

@property(nonatomic, assign)id<UITableViewEventDelagate> eventDelegate;

- (void)doneLoadingTableViewData;
@end
