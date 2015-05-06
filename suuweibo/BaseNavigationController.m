//
//  BaseNavigationController.m
//  suuweibo
//
//  Created by XuWeihao on 4/26/15.
//  Copyright (c) 2015 weihaoxu. All rights reserved.
//

#import "BaseNavigationController.h"
#import "CustomCatagory.h"
#import "ThemeManager.h"
#import "UIFactory.h"
@interface BaseNavigationController ()

@end

@implementation BaseNavigationController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeNotification:) name:kThemeDidChangeNotification object:nil];
    }
    return self;
}

- (void)themeNotification:(NSNotification *)notification
{
    [self loadThemeView];
}

//使用了通知都要记得移除
- (void)dealloc {
    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kThemeDidChangeNotification
                                                  object:nil];
}

- (void)loadThemeView {
//    // 字体颜色 选中
//    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0F], NSForegroundColorAttributeName : [UIColor redColor]} forState:UIControlStateSelected];
//    
//    // 字体颜色 未选中
//    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0F],  NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    self.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    float version = WXHLOSVersion();
    if ([ThemeManager shareInstance].themeName.length == 0) {
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"bar.jpg"] forBarMetrics:UIBarMetricsDefault];
     
//        ThemeImageView *tabarImageView = [UIFactory createThemeImageView:@"bar.jpg"];
//        tabarImageView.frame = self.tabBarController.tabBar.bounds;
//        [self.tabBarController.tabBar addSubview:tabarImageView];
    } else {
        if ( version >= 5.0 ) {
            UIImage *image = [[ThemeManager shareInstance] getThemesImage:@"navigationbar_background.png"];
            [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
            self.tabBarController.tabBar.backgroundImage = image;
        } else {
            //使用setNeedsDisplay，渲染引擎会异步调用drawRect
            [self.navigationBar setNeedsDisplay];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadThemeView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
