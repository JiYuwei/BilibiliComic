//
//  NewFootCell.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/6/3.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "NewFootCell.h"
#import "NewOrderModel.h"

#define DefaultOrderBtnColor RGBColor(88, 167, 248)

static const CGFloat BtnHeight = 30;

@interface NewFootCell ()

@property (nonatomic,strong) UIImageView *comicView;
@property (nonatomic,strong) UILabel     *titleLabel;
@property (nonatomic,strong) UILabel     *dateLabel;

@end

@implementation NewFootCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self cusLayoutAllSubViews];
    }
    return self;
}

-(void)cusLayoutAllSubViews
{
    [self.comicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(self.comicView.mas_width).multipliedBy(1.33);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.comicView.mas_bottom).offset(8);
        make.left.right.equalTo(self);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(6);
        make.left.right.equalTo(self);
    }];
    
    [self.orderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dateLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(BtnHeight * 3, BtnHeight));
    }];
    
    
}

#pragma mark - Setter

-(void)setData:(NewOrderData *)data
{
    if (data && _data != data) {
        _data = data;
        [self buildNewOrderData];
    }
}

-(void)buildNewOrderData
{
    [self.comicView sd_setFadeImageWithURL:[NSURL URLWithString:self.data.vertical_cover] placeholderImage:BCImage(@"comic_list_placeholder_162x216_")];
    
    self.titleLabel.text = self.data.title;
    
    NSString *dateStr = [self.data.online_time componentsSeparatedByString:@"T"].firstObject;
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [format dateFromString:dateStr];
    NSDateFormatter *newFormat = [[NSDateFormatter alloc] init];
    [newFormat setDateFormat:@"MM月dd日"];
    NSString *formatDate = [newFormat stringFromDate:date];
    self.dateLabel.text = formatDate;
    
    self.orderBtn.enabled = !self.data.is_order;
}

#pragma mark - LazyLoad

-(UIImageView *)comicView
{
    if (!_comicView) {
        _comicView = [[UIImageView alloc] init];
        _comicView.layer.cornerRadius = 5;
        _comicView.layer.masksToBounds = YES;
        _comicView.layer.borderColor = DefaultBorderColor.CGColor;
        _comicView.layer.borderWidth = 0.5;
        [self addSubview:_comicView];
    }
    return _comicView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.textColor = DefaultContentLightColor;
        _dateLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_dateLabel];
    }
    return _dateLabel;
}

-(UIButton *)orderBtn
{
    if (!_orderBtn) {
        _orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _orderBtn.layer.backgroundColor = DefaultOrderBtnColor.CGColor;
        _orderBtn.layer.cornerRadius = BtnHeight / 2;
        _orderBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_orderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_orderBtn setTitle:@"预约" forState:UIControlStateNormal];
        [_orderBtn setTitle:@"已预约" forState:UIControlStateDisabled];
        [self addSubview:_orderBtn];
    }
    return _orderBtn;
}

@end
