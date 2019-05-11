//
//  BaseModel.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/5/5.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

-(instancetype)init
{
    if (self = [super init]) {
        self.msg = @"initialized";
        self.code = -1;
    }
    return self;
}

@end
