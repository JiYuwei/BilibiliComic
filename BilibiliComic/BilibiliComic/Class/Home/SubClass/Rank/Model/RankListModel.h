//
//  RankListModel.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/5/16.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "BaseModel.h"

@class RankData,FansData,RankComics,Reward_users,RankStyles;

@interface RankListModel : BaseModel

@property (nonatomic, strong) NSArray <RankData *> * rankData;
@property (nonatomic, strong) FansData * fansData;

@end


@interface RankData : NSObject

@property (nonatomic, strong) NSArray <NSString *>   * author;
@property (nonatomic, assign) NSInteger  total;
@property (nonatomic, strong) NSArray <RankStyles *> * styles;
@property (nonatomic, assign) NSInteger  last_ord;
@property (nonatomic, copy)   NSString * title;
@property (nonatomic, assign) NSInteger  is_finish;
@property (nonatomic, assign) NSInteger  comic_id;
@property (nonatomic, copy)   NSString * vertical_cover;
@property (nonatomic, copy)   NSString * last_short_title;

@end

@interface FansData : NSObject

@property (nonatomic, copy)   NSString * next_time;
@property (nonatomic, strong) NSArray <RankComics *> * comics;
@property (nonatomic, copy)   NSString * current_time;

@end

@interface RankComics : NSObject

@property (nonatomic, strong) NSArray <NSString *>   * author;
@property (nonatomic, assign) NSInteger  total;
@property (nonatomic, strong) NSArray <RankStyles *> * styles;
@property (nonatomic, assign) NSInteger  last_ord;
@property (nonatomic, copy)   NSString * title;
@property (nonatomic, assign) NSInteger  is_finish;
@property (nonatomic, assign) NSInteger  comic_id;
@property (nonatomic, copy)   NSString * fans;
@property (nonatomic, copy)   NSString * vertical_cover;
@property (nonatomic, copy)   NSString * last_short_title;
@property (nonatomic, assign) NSInteger  last_rank;
@property (nonatomic, strong) NSArray <Reward_users *> * reward_users;

@end

@interface Reward_users : NSObject

@property (nonatomic, copy) NSString * fans;
@property (nonatomic, copy) NSString * avatar;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * uid;

@end

@interface RankStyles : NSObject

@property (nonatomic, copy)   NSString * name;
@property (nonatomic, assign) NSInteger  idField;

@end
