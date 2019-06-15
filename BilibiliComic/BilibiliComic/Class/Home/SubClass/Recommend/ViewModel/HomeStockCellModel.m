//
//  HomeStockCellModel.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/6/14.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "HomeStockCellModel.h"
#import "HomeStockListCell.h"
#import "HomeStockModel.h"

@interface HomeStockCellModel ()

@property (nonatomic,weak)   HomeStockListCell * cell;

@property (nonatomic,copy)   NSString * comicUrl;
@property (nonatomic,copy)   NSString * titleText;
@property (nonatomic,copy)   NSString * subTitleText;
@property (nonatomic,copy)   NSString * tagLabelText;
@property (nonatomic,assign) BOOL       tagHidden;
@property (nonatomic,strong) UIColor  * tagColor;

@end

@implementation HomeStockCellModel

-(void)initViewModelBinding
{
    RAC(self.cell.titleLabel, text)       = RACObserve(self, titleText);
    RAC(self.cell.subTitleLabel, text)    = RACObserve(self, subTitleText);
    RAC(self.cell.tagLabel, text)         = RACObserve(self, tagLabelText);
    RAC(self.cell.tagLabel, hidden)       = RACObserve(self, tagHidden);

    @weakify(self)
    [[RACObserve(self, comicUrl) skip:1] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.cell.comicView sd_setFadeImageWithURL:[NSURL URLWithString:self.comicUrl] placeholderImage:BCImage(@"comic_thumb_placeholder1_ico_343x192_")];
    }];
    
    [[RACObserve(self, tagColor) skip:1] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.cell.tagLabel.textColor = self.tagColor;
        self.cell.tagLabel.layer.backgroundColor = [self.tagColor lightBackColor].CGColor;
    }];
}

-(void)fillDataWithStockList:(StockList *)list
{
    self.comicUrl     = list.img;
    self.titleText    = list.title;
    
    NSString *subTitle = list.sub_title;
    BOOL pureNum = [subTitle mj_isPureInt];
    self.subTitleText = pureNum ? [NSString stringWithFormat:@"第%@话",subTitle] : subTitle;
    
    BOOL style = list.styles.count > 0;
    self.tagLabelText = style ? list.styles.firstObject.name : nil;
    self.tagHidden    = !style;
    
    NSString *colorID = [NSString stringWithFormat:@"%ld",list.styles.firstObject.idField];
    colorID = [[colorID md5] substringWithRange:NSMakeRange(10, 6)];
    self.tagColor     = [UIColor colorWithHexString:[NSString stringWithFormat:@"#%@",colorID]];
}

#pragma mark - LazyLoad

-(HomeStockListCell *)cell
{
    if (!_cell) {
        if ([self.responder isKindOfClass:[HomeStockListCell class]]) {
            _cell = (HomeStockListCell *)self.responder;
        }
    }
    return _cell;
}

@end
