//
//  RecomViewController.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/16.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "RecomViewController.h"

@interface RecomViewController ()

@end

@implementation RecomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableHeaderview];
}

-(void)initTableHeaderview
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BC_SCREEN_WIDTH, 0.6 * BC_SCREEN_WIDTH)];
    headerView.backgroundColor = GRandomColor;
    self.mainTableView.tableHeaderView = headerView;
}


@end
