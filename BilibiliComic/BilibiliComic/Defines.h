//
//  Defines.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/12.
//  Copyright © 2019 jyw. All rights reserved.
//

#ifndef Defines_h
#define Defines_h

#define HOME_TITLE       @"首页"
#define HOME_N_ICON      @"comic_tab_home_n_ico_28x28_"
#define HOME_S_ICON      @"comic_tab_home_s_ico_28x28_"

#define CLASSIFY_TITLE   @"分类"
#define CLASSIFY_N_ICON  @"comic_tab_kind_n_ico_28x28_"
#define CLASSIFY_S_ICON  @"comic_tab_kind_s_ico_28x28_"

#define BOOKLIST_TITLE   @"书架"
#define BOOKLIST_N_ICON  @"comic_tab_bookshelf_n_ico_28x28_"
#define BOOKLIST_S_ICON  @"comic_tab_bookshelf_s_ico_28x28_"

#define ME_TITLE         @"我"
#define ME_N_ICON        @"comic_tab_mine_n_ico_28x28_"
#define ME_S_ICON        @"comic_tab_mine_s_ico_28x28_"


//获取主屏幕和屏幕宽度与高度
#define BCSCREEN_WIDTH         [UIScreen mainScreen].bounds.size.width
#define BCSCREEN_HEIGHT        [UIScreen mainScreen].bounds.size.height

//安全区域
#define BC_NAV_HEIGHT          (BCSCREEN_HEIGHT >= 812 ? 88 : 64)
#define BC_STATUS_HEIGHT       (BCSCREEN_HEIGHT >= 812 ? 44 : 20)
#define BC_NAV_REALHEIGHT      44
#define BC_TABBAR_HEIGHT       (BCSCREEN_HEIGHT >= 812 ? 83 : 49)
#define BC_TABBAR_SAFEHEIGHT   (BCSCREEN_HEIGHT >= 812 ? 34 : 0)

//获取通知中心和UserDefaults
#define BCNotificationCenter   [NSNotificationCenter defaultCenter]
#define BCUserDefaults         [NSUserDefaults standardUserDefaults]

//设置随机颜色
#define GRandomColor           [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

//设置RGB颜色/设置RGBA颜色
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]
// clear背景颜色
#define GClearColor [UIColor clearColor]

//弱引用/强引用
#define LRWeakSelf(type)  __weak typeof(type) weak##type = type;
#define LRStrongSelf(type)  __strong typeof(type) type = weak##type;

//获取UIImage
#define UIImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]


//获取temp
#define kPathTemp NSTemporaryDirectory()
//获取沙盒 Document
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒 Cache
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]


//GCD - 只执行一次
#define kDISPATCH_ONCE(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);
//GCD - 在Main线程上运行
#define kDISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);
//GCD - 开启异步线程
#define kDISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);


#endif /* Defines_h */