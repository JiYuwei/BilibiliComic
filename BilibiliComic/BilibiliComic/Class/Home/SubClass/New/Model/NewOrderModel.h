//
//  NewOrderModel.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/6/3.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "BaseModel.h"

@class NewOrderData;

@interface NewOrderModel : BaseModel

@property (nonatomic, strong) NSArray <NewOrderData *> * data;

@end


@interface NewOrderData : NSObject

@property (nonatomic, assign) NSInteger  is_order;
@property (nonatomic, copy)   NSString * online_time;
@property (nonatomic, assign) NSInteger  comic_id;
@property (nonatomic, assign) NSInteger  online_type;
@property (nonatomic, copy)   NSString * vertical_cover;
@property (nonatomic, copy)   NSString * title;

@end
