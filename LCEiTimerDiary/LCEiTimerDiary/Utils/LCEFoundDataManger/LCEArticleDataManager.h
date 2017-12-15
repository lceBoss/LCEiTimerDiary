//
//  DataManager.h
//  VTMagic
//
//  Created by tianzhuo on 7/21/16.
//  Copyright © 2016 tianzhuo. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LCEArticleDataManager : NSObject

/**
 *  数据管理对象单例
 *
 *  @return self
 */
+ (instancetype)sharedInstance;
/**
 *  保存页面数据
 *
 *  @param info   页面数据
 *  @param menuId 菜单id
 */
- (void)savePageInfo:(NSArray *)infoList menuId:(NSString *)menuId;
/**
 *  根据menuId获取相应页面的数据
 *
 *  @param menuId 菜单id
 *
 *  @return 页面数据，可为nil
 */
- (NSArray *)pageInfoWithMenuId:(NSString *)menuId;

/**
 删除页面数据

 @param menuIds 所有的菜单id
 */
- (void)deletePageInfoWithMenuIds:(NSArray *)menuIds;

@end
