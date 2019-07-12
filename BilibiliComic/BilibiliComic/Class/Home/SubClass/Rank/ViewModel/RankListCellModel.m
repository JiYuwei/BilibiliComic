//
//  RankListCellModel.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/7/12.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "RankListCellModel.h"
#import "RankListViewCell.h"
#import "RankListModel.h"

@interface RankListCellModel ()

@property (nonatomic,weak) RankListViewCell * cell;

@property (nonatomic,strong) NSString *comicUrl;
@property (nonatomic,strong) NSString *titleText;
@property (nonatomic,strong) NSString *srcText;
@property (nonatomic,strong) NSString *typeText;
@property (nonatomic,strong) NSString *updateText;

@property (nonatomic,strong) NSString *fansSrcText;
@property (nonatomic,strong) NSString *fansCountText;
@property (nonatomic,strong) NSArray <Reward_users *> *users;
@property (nonatomic,assign) NSInteger arrowDirection;

@end

@implementation RankListCellModel

-(void)initViewModelBinding
{
    RAC(self.cell.titleLabel, text)     = RACObserve(self, titleText);
    RAC(self.cell.srcLabel, text)       = RACObserve(self, srcText);
    RAC(self.cell.typeLabel, text)      = RACObserve(self, typeText);
    RAC(self.cell.updateLabel, text)    = RACObserve(self, updateText);
    RAC(self.cell.fansSrcLabel, text)   = RACObserve(self, fansSrcText);
    RAC(self.cell.fansCountLabel, text) = RACObserve(self, fansCountText);
    
    @weakify(self)
    
    [[RACObserve(self, rank) skip:1] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        BOOL topRank = (self.rank <= 3);
        self.cell.rankLabel.text = [NSString stringWithFormat:topRank?@"%ld":@"%02ld",self.rank];
        self.cell.rankLabel.font = [UIFont fontWithName:@"Impact MT Std" size:topRank?70:35];
    }];
    
    [[RACObserve(self, comicUrl) skip:1] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.cell.comicView sd_setFadeImageWithURL:[NSURL URLWithString:self.comicUrl] placeholderImage:BCImage(@"comic_list_placeholder_162x216_")];
    }];
    
    [[RACObserve(self, users) skip:1] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        @weakify(self)
        [self.cell.fansView.fansAvatars enumerateObjectsUsingBlock:^(UIImageView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
            @strongify(self)
            if (idx < self.users.count) {
                NSString *avatarURL = self.users[idx].avatar;
                [view sd_setFadeImageWithURL:[NSURL URLWithString:avatarURL]];
            }
        }];
    }];
    
    [[RACObserve(self, arrowDirection) skip:1] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        if (self.arrowDirection < 0) {
            self.cell.fansView.fansArrow.image = BCImage(@"sort_up_icon_24x24_");
        }
        else if (self.arrowDirection == 0) {
            self.cell.fansView.fansArrow.image = BCImage(@"sort_equal_icon_24x24_");
        }
        else if (self.arrowDirection > 0) {
            self.cell.fansView.fansArrow.image = BCImage(@"sort_down_icon_24x24_");
        }
    }];
}

-(void)fillDataWithRankData:(RankData *)list
{
    self.comicUrl = list.vertical_cover;
    
    self.titleText = list.title;
    self.srcText = [list.author componentsJoinedByString:@" "];
    NSMutableArray *types = [NSMutableArray array];
    for (RankStyles *type in list.styles) {
        [types addObject:type.name];
    }
    self.typeText = [types componentsJoinedByString:@" "];
    NSString *updateStr = list.last_short_title;
    BOOL pureNum = [updateStr mj_isPureInt];
    self.updateText = [NSString stringWithFormat:pureNum?@"更新至%@话":@"更新至%@",list.last_short_title];
}

-(void)fillDataWithRankComics:(RankComics *)list
{
    self.comicUrl = list.vertical_cover;
    
    self.titleText = list.title;
    self.fansSrcText = [list.author componentsJoinedByString:@" "];
    CGFloat fans = list.fans.floatValue / 10000;
    self.fansCountText = [NSString stringWithFormat:@"%.2fw 粉丝值",fans];
    
    self.users = list.reward_users;
    self.arrowDirection = (self.rank - list.last_rank);
}

#pragma mark - LazyLoad

-(RankListViewCell *)cell
{
    if (!_cell) {
        if ([self.responder isKindOfClass:[RankListViewCell class]]) {
            _cell = (RankListViewCell *)self.responder;
        }
    }
    return _cell;
}

@end
