//
//  HomeSearchModel.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/5/9.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class SearchData;

@interface HomeSearchModel : BaseModel

@property (nonatomic, strong) NSArray <SearchData *> * data;

@end


@interface SearchData : NSObject

@property (nonatomic, assign) NSInteger  total;
@property (nonatomic, copy)   NSString * vertical_cover;
@property (nonatomic, copy)   NSString * release_time;
@property (nonatomic, assign) NSInteger  last_ord;
@property (nonatomic, assign) NSInteger  status;
@property (nonatomic, copy)   NSString * title;
@property (nonatomic, copy)   NSString * square_cover;
@property (nonatomic, assign) NSInteger  is_finish;
@property (nonatomic, assign) NSInteger  season_id;
@property (nonatomic, copy)   NSString * horizontal_cover;
@property (nonatomic, copy)   NSString * last_short_title;

@end


NS_ASSUME_NONNULL_END
