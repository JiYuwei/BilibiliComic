//
//  BaseNavigationController.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/10.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

-(UIViewController *)childViewControllerForStatusBarStyle
{
    return self.visibleViewController;
}

-(UIViewController *)childViewControllerForStatusBarHidden
{
    return self.visibleViewController;
}

@end
