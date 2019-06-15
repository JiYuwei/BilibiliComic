//
//  BaseViewModel.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/6/6.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "BaseViewModel.h"
#import "BaseViewController.h"

@interface BaseViewModel ()

@property (nonatomic,weak) BaseViewController *baseVC;

@end

@implementation BaseViewModel

-(instancetype)initWithResponder:(UIResponder *)responder
{
    if (self = [super init]) {
        self.responder = responder;
        [self initViewModelBinding];
        [self registerMainTableViewCell];
    }
    return self;
}

-(void)initViewModelBinding
{
    [self.baseVC.mainTableView.mj_header setRefreshingTarget:self refreshingAction:@selector(retrieveData)];
    [self.baseVC.mainTableView.mj_footer setRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

-(void)registerMainTableViewCell
{
    //Empty
}

-(void)retrieveData
{
    [self.baseVC.mainTableView.mj_header performSelector:@selector(endRefreshing) withObject:nil afterDelay:2];
}

-(void)loadMoreData
{
    [self.baseVC.mainTableView.mj_footer performSelector:@selector(endRefreshingWithNoMoreData) withObject:nil afterDelay:2];
}

#pragma mark - LazyLoad

-(BaseViewController *)baseVC
{
    if (!_baseVC) {
        if ([self.responder isKindOfClass:[BaseViewController class]]) {
            _baseVC = (BaseViewController *)self.responder;
        }
    }
    return _baseVC;
}

@end
