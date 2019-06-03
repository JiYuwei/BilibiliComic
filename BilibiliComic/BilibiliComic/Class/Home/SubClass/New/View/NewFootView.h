//
//  NewFootView.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/5/27.
//  Copyright © 2019 jyw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewOrderData;

@interface NewFootView : UIView

@property (nonatomic,strong) NSArray <NewOrderData *> *data;
@property (nonatomic,strong) UIButton *loadMoreBtn;

@end

