//
//  HomePagesTopBar.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/15.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "HomePagesTopBar.h"

#define WidthKey @"PagesTopBarItem"
#define WidthFontKey @"PagesTopBarItemFont"

static const CGFloat ItemScale     = 1.2;
static const CGFloat AnimDuration  = 0.3;

@interface HomePagesTopBar () <HomeNavigationBarProtocol>

@property (nonatomic,strong) NSMutableArray <UILabel *> *itemLabels;
@property (nonatomic,strong) UIView *silder;

@end

@implementation HomePagesTopBar
{
    CGFloat _itemWidth;
    CGFloat _itemFont;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _itemWidth = [PlistManager widthWithKey:WidthKey];
        _itemFont = [PlistManager widthWithKey:WidthFontKey];
    }
    return self;
}

-(void)createItemLabels
{
    [self.itemTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = [NSString stringWithFormat:@"%@",title];
        titleLabel.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        @weakify(self)
        [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x){
            @strongify(self)
            self.currentIndex = idx;
            UILabel *label = (UILabel *)x.view;
            [self showSelectedLabel:label];
        }];
        [titleLabel addGestureRecognizer:tap];
        
        [self addSubview:titleLabel];
        [self.itemLabels addObject:titleLabel];
    }];
    
    [self.itemLabels mas_distributeSudokuViewsWithFixedItemWidth:_itemWidth
                                                 fixedItemHeight:0
                                                fixedLineSpacing:0
                                           fixedInteritemSpacing:0
                                                       warpCount:self.itemLabels.count
                                                      topSpacing:0
                                                   bottomSpacing:0
                                                     leadSpacing:0
                                                     tailSpacing:0];
    
    [self.silder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-3);
        make.size.mas_equalTo(CGSizeMake(18, 3));
        make.centerX.equalTo(self.itemLabels.firstObject);
    }];
    
    [self layoutIfNeeded];
    
    [self showNavigationBarStyle:HomeNavigationBarStyleDefault];
    [self showSelectedLabel:self.itemLabels.firstObject];
}

-(void)showSelectedLabel:(UILabel *)label
{
    BOOL defaultStyle = !self.topBarStyle;
    [self.itemLabels enumerateObjectsUsingBlock:^(UILabel * _Nonnull titleLabel, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [UIView animateWithDuration:AnimDuration animations:^{
            
            if (titleLabel == label) {
                titleLabel.transform = CGAffineTransformMakeScale(ItemScale, ItemScale);
                titleLabel.textColor = defaultStyle?[UIColor blackColor]:[UIColor whiteColor];
                titleLabel.font = [UIFont boldSystemFontOfSize:self->_itemFont];
            }
            else {
                titleLabel.transform = CGAffineTransformMakeScale(1, 1);
                titleLabel.textColor = defaultStyle?[UIColor grayColor]:[UIColor whiteColor];
                titleLabel.font = [UIFont systemFontOfSize:self->_itemFont];
            }
        }];
    }];
    
    [UIView animateWithDuration:AnimDuration animations:^{
        CGFloat x = self.currentIndex * self.bounds.size.width / self.itemLabels.count + self->_itemWidth / 2;
        CGFloat y = self.silder.center.y;
        self.silder.center = CGPointMake(x, y);
    }];
}

#pragma mark - HomeNavigationBarProtocol

-(void)showNavigationBarStyle:(HomeNavigationBarStyle)style
{
    switch (style) {
        case HomeNavigationBarStyleDefault: {
            self.silder.backgroundColor = [UIColor blueColor];
            [self.itemLabels makeObjectsPerformSelector:@selector(setTextColor:) withObject:[UIColor grayColor]];
            self.itemLabels[self.currentIndex].textColor = [UIColor blackColor];
        }
            break;
        case HomeNavigationBarStyleLightContent: {
            self.silder.backgroundColor = [UIColor whiteColor];
            [self.itemLabels makeObjectsPerformSelector:@selector(setTextColor:) withObject:[UIColor whiteColor]];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Setter

-(void)setItemTitles:(NSArray *)itemTitles
{
    if (itemTitles && ![_itemTitles isEqualToArray:itemTitles]) {
        _itemTitles = itemTitles;
        [self createItemLabels];
    }
}

-(void)setTopBarStyle:(HomeNavigationBarStyle)topBarStyle
{
    if (_topBarStyle != topBarStyle) {
        _topBarStyle = topBarStyle;
        [self showNavigationBarStyle:_topBarStyle];
    }
}

#pragma mark - LazyLoad

-(NSMutableArray<UILabel *> *)itemLabels
{
    if (!_itemLabels) {
        _itemLabels = [NSMutableArray array];
    }
    return _itemLabels;
}

-(UIView *)silder
{
    if (!_silder) {
        _silder = [[UIView alloc] init];
        [self addSubview:_silder];
    }
    return _silder;
}

@end
