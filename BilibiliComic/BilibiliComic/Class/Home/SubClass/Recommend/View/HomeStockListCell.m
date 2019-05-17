//
//  HomeStockListCell.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/5/2.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "HomeStockListCell.h"
#import "HomeStockModel.h"

#define DefTitleFont  @"RecomListDefTitleFont"
#define SubTitleFont  @"RecomListSubTitleFont"

static const CGFloat Padding   = 18;

static const CGFloat TAGWidth  = 32;
static const CGFloat TAGHeight = 18;

@interface HomeStockListCell ()

@property (nonatomic,strong) UIImageView *comicView;
//@property (nonatomic,strong) UIImageView *statusView;
@property (nonatomic,strong) UILabel     *titleLabel;
@property (nonatomic,strong) UILabel     *subTitleLabel;
@property (nonatomic,strong) UILabel     *tagLabel;

@end

@implementation HomeStockListCell
{
    CGFloat _defTitleFont;
    CGFloat _subTitleFont;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _defTitleFont = [PlistManager widthWithKey:DefTitleFont];
        _subTitleFont = [PlistManager widthWithKey:SubTitleFont];
        [self cusLayoutAllSubViews];
    }
    return self;
}

-(void)cusLayoutAllSubViews
{
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.comicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(Padding);
        make.right.equalTo(self.contentView).offset(-Padding);
        make.height.equalTo(self.comicView.mas_width).multipliedBy(0.55);
    }];
    
//    [self.statusView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.equalTo(self.comicView);
//        make.size.mas_equalTo(CGSizeMake(80, 40));
//    }];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(Padding);
        make.top.equalTo(self.comicView.mas_bottom).offset(Padding / 3);
        make.width.mas_lessThanOrEqualTo(BC_SCREEN_WIDTH - Padding * 2.6 - TAGWidth);
    }];

    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(Padding);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(Padding / 3);
    }];

    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(Padding * 0.6);
        make.centerY.equalTo(self.titleLabel);
        make.size.mas_equalTo(CGSizeMake(TAGWidth, TAGHeight));
    }];
}

#pragma mark - Setter

-(void)setHomeStockList:(List *)homeStockList
{
    if (homeStockList && _homeStockList != homeStockList) {
        _homeStockList = homeStockList;
        
        [self.comicView sd_setFadeImageWithURL:[NSURL URLWithString:_homeStockList.img] placeholderImage:BCImage(@"comic_thumb_placeholder1_ico_343x192_")];
        self.titleLabel.text = _homeStockList.title;
        
        NSString *subTitle = _homeStockList.sub_title;
        BOOL pureNum = [subTitle mj_isPureInt];
        self.subTitleLabel.text = pureNum ? [NSString stringWithFormat:@"第%@话",subTitle] : subTitle;
        
        BOOL style = _homeStockList.styles.count > 0;
        self.tagLabel.hidden = !style;
        self.tagLabel.text = style ? _homeStockList.styles.firstObject.name : nil;
        NSString *colorID = [NSString stringWithFormat:@"%ld",_homeStockList.styles.firstObject.idField];
        colorID = [[colorID md5] substringWithRange:NSMakeRange(10, 6)];
        UIColor *tagColor = [UIColor colorWithHexString:[NSString stringWithFormat:@"#%@",colorID]];
        self.tagLabel.textColor = tagColor;
        self.tagLabel.layer.backgroundColor = [tagColor lightBackColor].CGColor;
    }
}

#pragma mark - LazyLoad

-(UIImageView *)comicView
{
    if (!_comicView) {
        _comicView = [[UIImageView alloc] init];
        _comicView.layer.borderColor = DefaultBorderColor.CGColor;
        _comicView.layer.borderWidth = 0.5f;
        _comicView.layer.cornerRadius = 3.5f;
        _comicView.layer.masksToBounds = YES;
        [self.contentView addSubview:_comicView];
    }
    return _comicView;
}

//-(UIImageView *)statusView
//{
//    if (!_statusView) {
//        _statusView = [[UIImageView alloc] init];
//        _statusView.backgroundColor = GRandomColor;
//        [self.comicView addSubview:_statusView];
//    }
//    return _statusView;
//}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:_defTitleFont];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UILabel *)subTitleLabel
{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.font = [UIFont systemFontOfSize:_subTitleFont];
        _subTitleLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_subTitleLabel];
    }
    return _subTitleLabel;
}

-(UILabel *)tagLabel
{
    if (!_tagLabel) {
        _tagLabel = [[UILabel alloc] init];
        _tagLabel.layer.backgroundColor = DefaultContentLightColor.CGColor;
        _tagLabel.textAlignment = NSTextAlignmentCenter;
        _tagLabel.textColor = [UIColor whiteColor];
        _tagLabel.font = [UIFont systemFontOfSize:11];
        _tagLabel.layer.cornerRadius = Padding / 6;
        _tagLabel.hidden = YES;
        [self.contentView addSubview:_tagLabel];
    }
    return _tagLabel;
}


@end
