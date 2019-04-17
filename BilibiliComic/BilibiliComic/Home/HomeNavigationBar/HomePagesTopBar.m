//
//  HomePagesTopBar.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/15.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "HomePagesTopBar.h"

#define WidthKey      @"PagesTopBarItem"
#define WidthFontKey  @"PagesTopBarItemFont"
#define SliderColor   RGBColor(58, 173, 254)

static const CGFloat ItemScale     = 1.2;
static const CGFloat AnimDuration  = 0.3;

@interface HomePagesTopBar () <HomeNavigationBarProtocol>

@property (nonatomic,strong) NSMutableArray <UILabel *> *itemLabels;

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
            [self showSelectedIndex:idx];
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
    
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-4);
        make.size.mas_equalTo(CGSizeMake(18, 3));
        make.centerX.equalTo(self.itemLabels.firstObject);
    }];
    
    [self layoutIfNeeded];
    
    self.slider.layer.cornerRadius = self.slider.bounds.size.height / 2;
    self.slider.layer.masksToBounds = YES;
    [self showNavigationBarStyle:HomeNavigationBarStyleDefault];
    [self showSelectedIndex:0];
}

-(void)showSelectedIndex:(NSUInteger)index
{
    if (index >= self.itemLabels.count) {
        return;
    }
    
    UILabel *label = self.itemLabels[index];
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
}

#pragma mark - HomeNavigationBarProtocol

-(void)showNavigationBarStyle:(HomeNavigationBarStyle)style
{
    switch (style) {
        case HomeNavigationBarStyleDefault: {
            self.slider.backgroundColor = SliderColor;
            [self.itemLabels makeObjectsPerformSelector:@selector(setTextColor:) withObject:[UIColor grayColor]];
            self.itemLabels[self.currentIndex].textColor = [UIColor blackColor];
        }
            break;
        case HomeNavigationBarStyleLightContent: {
            self.slider.backgroundColor = [UIColor whiteColor];
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

-(UIView *)slider
{
    if (!_slider) {
        _slider = [[UIView alloc] init];
        [self addSubview:_slider];
    }
    return _slider;
}

@end
