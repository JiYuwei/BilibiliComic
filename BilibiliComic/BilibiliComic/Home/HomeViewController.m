//
//  HomeViewController.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/2/16.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeNavigationBar.h"

@interface HomeViewController ()

@property (nonatomic,strong) HomeNavigationBar *homeNavBar;

@end

@implementation HomeViewController

-(UIStatusBarStyle)preferredStatusBarStyle
{
    if (self.homeNavBar.navBarStyle == HomeNavigationBarStyleLightContent) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.navigationController.navigationBar.hidden = YES;
    
    [self initNavigationBar];
}

-(void)initNavigationBar
{
    self.homeNavBar.navBarStyle = HomeNavigationBarStyleLightContent;
}

#pragma mark - LazyLoad

-(HomeNavigationBar *)homeNavBar
{
    if (!_homeNavBar) {
        _homeNavBar = [[HomeNavigationBar alloc] initWithFrame:CGRectMake(0, 0, BCSCREEN_WIDTH, BC_NAV_HEIGHT)];
        [self.view addSubview:_homeNavBar];
    }
    return _homeNavBar;
}

@end
