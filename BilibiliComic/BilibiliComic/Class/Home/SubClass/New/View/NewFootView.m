//
//  NewFootView.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/5/27.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "NewFootView.h"
#import "NewFootCell.h"
#import "NewOrderModel.h"

static const CGFloat BtnHeight   = 40;
static const CGFloat TitleHeight = 25;

@interface NewFootView () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UILabel     *titleLabel;
@property (nonatomic,strong) UITableView *orderTableView;

@end

@implementation NewFootView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self cusLayoutAllSubViews];
    }
    return self;
}

-(void)cusLayoutAllSubViews
{
    [self.loadMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.left.equalTo(self).offset(75);
        make.right.equalTo(self).offset(-75);
        make.height.mas_equalTo(BtnHeight);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loadMoreBtn.mas_bottom).offset(30);
        make.left.equalTo(self).offset(18);
        make.height.mas_equalTo(TitleHeight);
    }];
    
    [self.orderTableView registerClass:[NewFootCell class] forCellReuseIdentifier:NSStringFromClass([NewFootCell class])];
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.data.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewFootCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NewFootCell class]) forIndexPath:indexPath];
    cell.transform = CGAffineTransformMakeRotation(M_PI_2);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.data = self.data[indexPath.section];
    [[[cell.orderBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self orderBtnClickedAtIndex:indexPath.section];
    }];
    
    return cell;
}

#pragma mark UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    BOOL isFirst = (section == 0);
    return isFirst ? 15 : 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    BOOL isLast = (section == 9);
    return isLast ? 15 : 5;
}

#pragma mark - Action

-(void)orderBtnClickedAtIndex:(NSInteger)index
{
    //Empty RACSignalForSelecter -> NewViewController;
}

#pragma mark - Setter

-(void)setData:(NSArray<NewOrderData *> *)data
{
    if (data && _data != data) {
        _data = data;
        [self.orderTableView reloadData];
    }
}

#pragma mark - LazyLoad

-(UIButton *)loadMoreBtn
{
    if (!_loadMoreBtn) {
        _loadMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loadMoreBtn.layer.backgroundColor = DefaultViewBackgroundColor.CGColor;
        _loadMoreBtn.layer.cornerRadius = BtnHeight / 2;
        _loadMoreBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_loadMoreBtn setTitleColor:DefaultContentLightColor forState:UIControlStateNormal];
        [_loadMoreBtn setTitle:@"查看更多" forState:UIControlStateNormal];
        [_loadMoreBtn setTitle:@"～没有更多了哦～" forState:UIControlStateDisabled];
        [self addSubview:_loadMoreBtn];
    }
    return _loadMoreBtn;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _titleLabel.text = @"新作预约";
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UITableView *)orderTableView
{
    if (!_orderTableView) {
        CGFloat cHeight = self.vHeight - BtnHeight - TitleHeight - 90;
        _orderTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, cHeight, self.vWidth) style:UITableViewStyleGrouped];
        _orderTableView.center = CGPointMake(self.vWidth / 2, cHeight / 2 + BtnHeight + TitleHeight + 70);
        _orderTableView.transform = CGAffineTransformMakeRotation(-M_PI_2);
        _orderTableView.backgroundColor = [UIColor whiteColor];
        _orderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _orderTableView.showsVerticalScrollIndicator = NO;
        _orderTableView.showsHorizontalScrollIndicator = NO;
        _orderTableView.dataSource = self;
        _orderTableView.delegate = self;
        if (@available(iOS 11.0, *)) {
            _orderTableView.estimatedRowHeight = 0;
            _orderTableView.estimatedSectionHeaderHeight = 0;
            _orderTableView.estimatedSectionFooterHeight = 0;
        }
        
        [self addSubview:_orderTableView];
    }
    return _orderTableView;
}
@end
