//
//  BaseViewModel.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/6/6.
//  Copyright © 2019 jyw. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BCViewModelDataProtocol <NSObject>

@optional
-(NSInteger)customNumberOfRowsInSection:(NSInteger)section;
-(UITableViewCell *)customCellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol BCViewModelProtocol <NSObject>

@optional
-(CGFloat)customHeightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface BaseViewModel : NSObject <BCViewModelDataProtocol,BCViewModelProtocol>

@property (nonatomic,weak) UIResponder *responder;

/**
 绑定与ViewModel对应的视图

 @param responder 视图
 @return self
 */
-(instancetype)initWithResponder:(UIResponder *)responder;

/** Model与View间的绑定操作 */
-(void)initViewModelBinding;

/** 注册自定义Cell */
-(void)registerMainTableViewCell;

/** 下拉刷新 */
-(void)retrieveData;
/** 上拉加载 */
-(void)loadMoreData;



@end

