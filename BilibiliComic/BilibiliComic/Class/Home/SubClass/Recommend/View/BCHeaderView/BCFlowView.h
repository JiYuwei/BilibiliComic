//
//  BCFlowView.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/24.
//  Copyright © 2019 jyw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCIndexBannerSubview.h"

@protocol HQFlowViewDataSource;
@protocol HQFlowViewDelegate;

/******************************
 
 页面滚动的方向分为横向和纵向
 
 目的:实现类似于选择电影票的效果,并且实现无限/自动轮播
 
 特点:1.无限轮播;2.自动轮播;3.电影票样式的层次感;4.非当前显示view具有缩放和透明的特效
 
 问题:考虑到轮播图的数量不会太大,暂时未做重用处理;对设备性能影响不明显,后期版本会考虑添加重用标识模仿tableview的重用
 
 ******************************/

typedef NS_ENUM(NSUInteger, HQFlowViewOrientation) {
    HQFlowViewOrientationHorizontal = 0,
    HQFlowViewOrientationVertical
};

@interface BCFlowView : UIView

/**
 *  默认为横向
 */
@property (nonatomic,assign) HQFlowViewOrientation orientation;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic,assign) BOOL needsReload;
/**
 *  总页数
 */
@property (nonatomic,assign) NSInteger pageCount;

@property (nonatomic,strong) NSMutableArray *cells;
@property (nonatomic,assign) NSRange visibleRange;
/**
 *  如果以后需要支持reuseIdentifier，这边就得使用字典类型了
 */
@property (nonatomic,strong) NSMutableArray *reusableCells;

@property (nonatomic,assign) id <HQFlowViewDataSource> dataSource;
@property (nonatomic,assign) id <HQFlowViewDelegate>   delegate;

/**
 *  指示器
 */
@property (nonatomic,retain)  UIPageControl *pageControl;

/**
 *  非当前页的透明比例
 */
@property (nonatomic, assign) CGFloat minimumPageAlpha;

/**
 左右间距,默认20
 */
@property (nonatomic, assign) CGFloat leftRightMargin;

/**
 上下间距,默认30
 */
@property (nonatomic, assign) CGFloat topBottomMargin;

/**
 *  是否开启自动滚动,默认为开启
 */
@property (nonatomic, assign) BOOL isOpenAutoScroll;

/**
 *  是否开启无限轮播,默认为开启
 */
@property (nonatomic, assign) BOOL isCarousel;

/**
 *  当前是第几页
 */
@property (nonatomic, assign, readonly) NSInteger currentPageIndex;

/**
 *  定时器
 */
@property (nonatomic, weak) NSTimer *timer;

/**
 *  自动切换视图的时间,默认是5.0
 */
@property (nonatomic, assign) CGFloat autoTime;

/**
 *  原始页数
 */
@property (nonatomic, assign) NSInteger orginPageCount;

/**
 *  刷新视图
 */
- (void)reloadData;

/**
 *  获取可重复使用的Cell
 *
 *  @return 填充内容的矩形块
 */
- (BCIndexBannerSubview *)dequeueReusableCell;

/**
 *  滚动到指定的页面
 *
 *  @param pageNumber 页号
 */
- (void)scrollToPage:(NSUInteger)pageNumber;

/**
 *  开启定时器,废弃
 */
//- (void)startTimer;

/**
 *  关闭定时器,关闭自动滚动
 */
- (void)stopTimer;

/**
 调整中间页居中，经常出现滚动卡住一半时调用
 */
- (void)adjustCenterSubview;

@end


@protocol  HQFlowViewDelegate<NSObject>

@optional
/**
 *  当前显示cell的Size(中间页显示大小)
 *
 *  @param flowView 轮播图
 *
 *  @return 中间页尺寸
 */
- (CGSize)sizeForPageInFlowView:(BCFlowView *)flowView;

/**
 *  滚动到了某一列
 *
 *  @param pageNumber 页号
 *  @param flowView   轮播图
 */
- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(BCFlowView *)flowView;

/**
 *  点击了第几个cell
 *
 *  @param subView 点击的控件
 *  @param subIndex    点击控件的index
 */
- (void)didSelectCell:(BCIndexBannerSubview *)subView withSubViewIndex:(NSInteger)subIndex;

@end


@protocol HQFlowViewDataSource <NSObject>

/**
 *  返回显示View的个数
 *
 *  @param flowView 轮播图
 *
 *  @return 总页数
 */
- (NSInteger)numberOfPagesInFlowView:(BCFlowView *)flowView;

/**
 *  给某一列设置属性
 *
 *  @param flowView 轮播图
 *  @param index    页号
 *
 *  @return 填充内容的矩形块
 */
- (BCIndexBannerSubview *)flowView:(BCFlowView *)flowView cellForPageAtIndex:(NSInteger)index;

@end
