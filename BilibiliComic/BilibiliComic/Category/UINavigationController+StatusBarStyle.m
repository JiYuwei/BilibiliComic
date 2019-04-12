//
//  UINavigationController+StatusBarStyle.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/12.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "UINavigationController+StatusBarStyle.h"

@implementation UINavigationController (StatusBarStyle)

-(UIViewController *)childViewControllerForStatusBarStyle
{
    return self.visibleViewController;
}

-(UIViewController *)childViewControllerForStatusBarHidden
{
    return self.visibleViewController;
}

@end
