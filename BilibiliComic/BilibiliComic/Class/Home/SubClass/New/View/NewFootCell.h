//
//  NewFootCell.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/6/3.
//  Copyright © 2019 jyw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewOrderData;

@interface NewFootCell : UITableViewCell

@property (nonatomic,strong) NewOrderData *data;
@property (nonatomic,strong) UIButton *orderBtn;

@end

