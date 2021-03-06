//
//  BCPagesTopBar.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/15.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "BCPagesTopBar.h"

#define WidthKey     @"PagesTopBarItem"

#define HomeFontKey  @"HomePagesTopBarFont"
#define RankFontKey  @"RankPagesTopBarFont"

#define SliderColor   [UIColor blackColor]

static const CGFloat ItemScale     = 1.2;
static const CGFloat AnimDuration  = 0.3;

@interface BCPagesTopBar () <HomeNavigationBarProtocol>

@property (nonatomic,strong) NSMutableArray <UILabel *> *itemLabels;

@end

@implementation BCPagesTopBar
{
    CGFloat _itemWidth;
    CGFloat _itemFont;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.topBarStyle = HomeNavigationBarStyleDefault;
        self.topBarType = PagesTopBarTypeHome;
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
    
    [self showNavigationBarStyle:HomeNavigationBarStyleDefault];
    [self showSelectedIndex:0];
}

-(void)initSelectedIndex:(NSUInteger)index
{
    if (index >= self.itemLabels.count) {
        return;
    }
    
    [self.slider mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-4);
        make.size.mas_equalTo(CGSizeMake(18, 3));
        make.centerX.equalTo(self.itemLabels[index]);
    }];
    [self showSelectedIndex:index];
}

-(void)showSelectedIndex:(NSUInteger)index
{
    if (index >= self.itemLabels.count) {
        return;
    }
    
    self.currentIndex = index;
    UILabel *label    = self.itemLabels[index];
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
            self.slider.layer.backgroundColor = SliderColor.CGColor;
            [self.itemLabels makeObjectsPerformSelector:@selector(setTextColor:) withObject:[UIColor grayColor]];
            self.itemLabels[self.currentIndex].textColor = [UIColor blackColor];
        }
            break;
        case HomeNavigationBarStyleLightContent: {
            self.slider.layer.backgroundColor = [UIColor whiteColor].CGColor;
            [self.itemLabels makeObjectsPerformSelector:@selector(setTextColor:) withObject:[UIColor whiteColor]];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Setter

-(void)setTopBarType:(PagesTopBarType)topBarType
{
    if (_topBarType != topBarType) {
        _topBarType = topBarType;
    }
    _itemWidth = [PlistManager widthWithKey:WidthKey];
    NSArray *fontStrArr = @[HomeFontKey,RankFontKey];
    _itemFont = [PlistManager widthWithKey:fontStrArr[_topBarType]];
    NSArray *sWArr = @[@18,@12];
    [self.slider mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake([sWArr[self.topBarType] floatValue], 3));
    }];
}

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
        _slider.layer.cornerRadius = 1.5;
        [self addSubview:_slider];
    }
    return _slider;
}

@end
