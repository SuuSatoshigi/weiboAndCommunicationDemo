//
//  ThemeViewController.h
//  suuweibo
//
//  Created by suusatoshigi on 15-5-6.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import "BaseViewController.h"

@interface ThemeViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *themes;
}

@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end
