//
//  SearchCycleScrollView.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/15.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "SearchCycleScrollView.h"
#import "HomeSearchViewModel.h"

#define DefaultLabelColor RGBColor(170, 170, 170)

@interface SearchCycleScrollView () <HomeNavigationBarProtocol>

//定时器，让label动起来
@property (nonatomic,strong) NSTimer *timer;
//第一个label
@property (nonatomic,strong) UILabel *firstLabel;
//第二个label
@property (nonatomic,strong) UILabel *secondLabel;

@property (nonatomic,strong) HomeSearchViewModel *searchViewModel;

@end

@implementation SearchCycleScrollView

#pragma mark - Public

-(void)openScrollMode
{
    if (self.searchViewModel.placeHolders.count < 2) return;
    
    NSArray *placeHolders = self.searchViewModel.placeHolders;
    
    self.firstLabel.text = placeHolders[0];
    self.secondLabel.text = placeHolders[1];
    self.firstLabel.frame = CGRectMake(0, 0, self.vWidth, self.vHeight);
    self.secondLabel.frame = CGRectMake(0, self.vHeight, self.vWidth, self.vHeight);
    
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.timer = [NSTimer timerWithTimeInterval:self.interval target:self selector:@selector(scroll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

#pragma mark -

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.firstLabel = [[UILabel alloc] init];
        self.secondLabel = [[UILabel alloc] init];
        self.firstLabel.font = [UIFont systemFontOfSize:12];
        self.secondLabel.font = [UIFont systemFontOfSize:12];
        
        [self addSubview:self.firstLabel];
        [self addSubview:self.secondLabel];
        
        self.searchViewModel = [[HomeSearchViewModel alloc] initWithResponder:self];
    }
    return self;
}

static NSInteger i = 1;

-(void)scroll
{
    i++;
    
    NSArray *placeHolders = self.searchViewModel.placeHolders;
    
    i = (i >= placeHolders.count) ? 0 : i;
    CGFloat height=self.vHeight;
    CGFloat width=self.vWidth;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        NSArray *labelArray=self.subviews;
        //让label滚动起来
        for (UIView *view in labelArray) {
            if ([view isKindOfClass:[UILabel class]]) {
                UILabel *label=(UILabel *)view;
                label.vTop -= height;
            }
        }
    } completion:^(BOOL finished) {
        //重新定位label的位置
        if (self.firstLabel.vOrigin.y <= -height) {
            self.firstLabel.frame = CGRectMake(0, height, width, height);
            self.firstLabel.text = placeHolders[i];
        }
        if (self.secondLabel.frame.origin.y <= -height) {
            self.secondLabel.frame = CGRectMake(0, height, width, height);
            self.secondLabel.text = placeHolders[i];
        }
    }];
}

#pragma mark - HomeNavigationBarProtocol

-(void)showNavigationBarStyle:(HomeNavigationBarStyle)style
{
    switch (style) {
        case HomeNavigationBarStyleDefault:
        {
            self.firstLabel.textColor  = DefaultLabelColor;
            self.secondLabel.textColor = DefaultLabelColor;
        }
            break;
        case HomeNavigationBarStyleLightContent:
        {
            self.firstLabel.textColor = [UIColor whiteColor];
            self.secondLabel.textColor = [UIColor whiteColor];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Setter

-(void)setCycleStyle:(HomeNavigationBarStyle)cycleStyle
{
    if (_cycleStyle != cycleStyle) {
        _cycleStyle = cycleStyle;
        
        [self showNavigationBarStyle:_cycleStyle];
    }
}

@end
