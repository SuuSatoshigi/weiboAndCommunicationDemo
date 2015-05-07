//
//  ThemeViewController.m
//  suuweibo
//
//  Created by suusatoshigi on 15-5-6.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import "ThemeViewController.h"
#import "ThemeManager.h"
#import "UIFactory.h"
@interface ThemeViewController ()

@end

@implementation ThemeViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        themes = [[ThemeManager shareInstance].themesPlist allKeys];
        [themes retain];
        
        self.title = @"主题切换";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return themes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"themeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
       cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify] autorelease];
        ThemeLable *textLabel = [UIFactory createThemeLable:kThemeListLabel];
        textLabel.frame =CGRectMake(10, 10, 200, 30);
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.tag = 2015;
        textLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        [cell.contentView addSubview:textLabel];
    }
//    cell.textLabel.text = themes[indexPath.row];
    
    UILabel *textLabel = (UILabel *)[cell.contentView viewWithTag:2015];
   
    
    //当前cell中的主题名
    NSString *name = themes[indexPath.row];
    textLabel.text = name;
    //当前使用的主题名称
    NSString *themeName = [ThemeManager shareInstance].themeName;
    if (themeName == nil) {
        themeName = @"默认";
    }
    
    //比较cell中的主题名和当前使用的主题名是否相同，增加一个打勾的框
    if ([themeName isEqualToString:name]) {
        //打勾
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
    //        消除
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *themeName = themes[indexPath.row];
    
    if ([themeName isEqualToString:@"默认"]) {
        themeName = nil;
    }
    //保存主题到本地
    [[NSUserDefaults standardUserDefaults] setObject:themeName forKey:kThemeName];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [ThemeManager shareInstance].themeName =themeName;
    [[NSNotificationCenter defaultCenter] postNotificationName:kThemeDidChangeNotification object:themeName];
    
//    打勾的框不能随着点击按钮更新
    [tableView reloadData];
}


@end
