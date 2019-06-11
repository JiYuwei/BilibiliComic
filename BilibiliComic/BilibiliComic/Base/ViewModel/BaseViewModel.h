//
//  BaseViewModel.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/6/6.
//  Copyright © 2019 jyw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseViewModel : NSObject

@property (nonatomic,weak) UIResponder *responder;

/**
 绑定与ViewModel对应的视图

 @param responder 视图
 @return self
 */
-(instancetype)initWithResponder:(UIResponder *)responder;

/**
 Model与View间的绑定操作
 */
-(void)executeViewModelBinding;

/**
 下拉刷新
 */
-(void)retrieveData;
/**
 上拉加载
 */
-(void)loadMoreData;

@end

