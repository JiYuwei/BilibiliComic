//
//  HomePagesTopBar.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/15.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "HomePagesTopBar.h"

static const CGFloat ItemWidth     = 50;
static const CGFloat ItemFont      = 17;
static const CGFloat ItemScale     = 1.2;
static const CGFloat AnimDuration  = 0.3;

@interface HomePagesTopBar ()

@property (nonatomic,strong) NSMutableArray <UILabel *> *itemLabels;
@property (nonatomic,strong) UIView *silder;

@end

@implementation HomePagesTopBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

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
    
    [self.itemLabels mas_distributeSudokuViewsWithFixedItemWidth:ItemWidth
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
    
    [self showPagesTopBarStyle:HomePagesTopBarStyleDefault];
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
                titleLabel.font = [UIFont boldSystemFontOfSize:ItemFont];
            }
            else {
                titleLabel.transform = CGAffineTransformMakeScale(1, 1);
                titleLabel.textColor = defaultStyle?[UIColor grayColor]:[UIColor whiteColor];
                titleLabel.font = [UIFont systemFontOfSize:ItemFont];
            }
        }];
    }];
    
    [UIView animateWithDuration:AnimDuration animations:^{
        CGFloat x = self.currentIndex * self.bounds.size.width / self.itemLabels.count + ItemWidth / 2;
        CGFloat y = self.silder.center.y;
        self.silder.center = CGPointMake(x, y);
    }];
}

-(void)showPagesTopBarStyle:(HomePagesTopBarStyle)style
{
    switch (style) {
        case HomePagesTopBarStyleDefault: {
            self.silder.backgroundColor = [UIColor blueColor];
            [self.itemLabels makeObjectsPerformSelector:@selector(setTextColor:) withObject:[UIColor grayColor]];
            self.itemLabels[self.currentIndex].textColor = [UIColor blackColor];
        }
            break;
        case HomePagesTopBarStyleLightContent: {
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

-(void)setTopBarStyle:(HomePagesTopBarStyle)topBarStyle
{
    if (_topBarStyle != topBarStyle) {
        _topBarStyle = topBarStyle;
        [self showPagesTopBarStyle:_topBarStyle];
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
