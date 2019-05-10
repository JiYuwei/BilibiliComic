//
//  HomeBannerModel.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/5/8.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class BannerData;

@interface HomeBannerModel : BaseModel

@property (nonatomic, strong) NSArray <BannerData *> * data;

-(BOOL)isEqualToHomeBannerModel:(HomeBannerModel *)model;

@end


@interface BannerData : NSObject

@property (nonatomic, assign) NSInteger  jump_type;
@property (nonatomic, copy)   NSString * title;
@property (nonatomic, copy)   NSString * jump_value;
@property (nonatomic, copy)   NSString * img;
@property (nonatomic, assign) NSInteger  idField;
@property (nonatomic, copy)   NSString * bg;
@property (nonatomic, copy)   NSString * img2;

@end


NS_ASSUME_NONNULL_END
