//
//  BaseTabbarController.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/2/16.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "BaseTabbarController.h"
#import "BaseNavigationController.h"
#import "HomeViewController.h"
#import "ClassifyViewController.h"
#import "BookListViewController.h"
#import "MeViewController.h"

@interface BaseTabbarController ()

@end

@implementation BaseTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITabBarItem *itm=[UITabBarItem appearance];
    [itm setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    BaseNavigationController *homeNav = [[BaseNavigationController alloc] initWithRootViewController:homeVC];
    homeNav.tabBarItem.title = HOME_TITLE;
    homeNav.tabBarItem.image = [[UIImage imageNamed:HOME_N_ICON] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeNav.tabBarItem.selectedImage = [[UIImage imageNamed:HOME_S_ICON] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeNav.navigationBar.translucent = YES;
    
    ClassifyViewController *classifyVC = [[ClassifyViewController alloc] init];
    BaseNavigationController *classifyNav = [[BaseNavigationController alloc] initWithRootViewController:classifyVC];
    classifyNav.tabBarItem.title = CLASSIFY_TITLE;
    classifyNav.tabBarItem.image = [[UIImage imageNamed:CLASSIFY_N_ICON] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    classifyNav.tabBarItem.selectedImage = [[UIImage imageNamed:CLASSIFY_S_ICON] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    classifyNav.navigationBar.translucent = NO;
    
    BookListViewController *bookListVC = [[BookListViewController alloc] init];
    BaseNavigationController *bookListNav = [[BaseNavigationController alloc] initWithRootViewController:bookListVC];
    bookListNav.tabBarItem.title = BOOKLIST_TITLE;
    bookListNav.tabBarItem.image = [[UIImage imageNamed:BOOKLIST_N_ICON] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    bookListNav.tabBarItem.selectedImage = [[UIImage imageNamed:BOOKLIST_S_ICON] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    bookListNav.navigationBar.translucent = NO;
    
    MeViewController *meVC = [[MeViewController alloc] init];
    BaseNavigationController *meNav = [[BaseNavigationController alloc] initWithRootViewController:meVC];
    meNav.tabBarItem.title = ME_TITLE;
    meNav.tabBarItem.image = [[UIImage imageNamed:ME_N_ICON] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    meNav.tabBarItem.selectedImage = [[UIImage imageNamed:ME_S_ICON] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    meNav.navigationBar.translucent = NO;
    
    self.viewControllers = @[homeNav,classifyNav,bookListNav,meNav];
    
//    self.tabBar.tintColor = MAIN_COLOR;
    self.tabBar.translucent = NO;
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
