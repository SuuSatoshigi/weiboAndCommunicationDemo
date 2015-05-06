//
//  ThemeViewController.m
//  suuweibo
//
//  Created by suusatoshigi on 15-5-6.
//  Copyright (c) 2015年 weihaoxu. All rights reserved.
//

#import "ThemeViewController.h"
#import "ThemeManager.h"

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
    }
    cell.textLabel.text = themes[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *themeName = themes[indexPath.row];
    [ThemeManager shareInstance].themeName =themeName;
    [[NSNotificationCenter defaultCenter] postNotificationName:kThemeDidChangeNotification object:themeName];
}


@end
