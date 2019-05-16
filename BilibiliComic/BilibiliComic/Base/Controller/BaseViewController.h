//
//  BaseViewController.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/2/16.
//  Copyright © 2019 jyw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,assign) BOOL mainTableViewEnabled;

-(void)retrieveData;
-(void)loadMoreData;

@end

