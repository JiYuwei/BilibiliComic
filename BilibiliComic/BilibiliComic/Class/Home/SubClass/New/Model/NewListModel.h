//
//  NewListModel.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/6/3.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "BaseModel.h"

@class NewListData,NewListStyles;

@interface NewListModel : BaseModel

@property (nonatomic, strong) NSArray <NewListData *> * data;

@end


@interface NewListData : NSObject

@property (nonatomic, assign) NSInteger  comic_id;
@property (nonatomic, strong) NSArray <NewListStyles *> * styles;
@property (nonatomic, copy)   NSString * vertical_cover;
@property (nonatomic, copy)   NSString * title;

@end

@interface NewListStyles : NSObject

@property (nonatomic, copy)   NSString * name;
@property (nonatomic, assign) NSInteger  idField;

@end
