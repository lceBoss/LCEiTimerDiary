//
//  LCESecrecyTableViewCell.h
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2018/1/9.
//  Copyright © 2018年 妖狐小子. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LCESecrecyTableViewCell;
@protocol LCESecrecyTableViewCellDelegate <NSObject>

/**
 选中cell
 @param cell cell
 @param index 下标
 @param isSelect 是否是选中
 */
- (void)secrecyTableViewCell:(LCESecrecyTableViewCell *)cell selectIndex:(NSInteger)index selectStatus:(BOOL)isSelect;

@end;

@interface LCESecrecyTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLayoutConstraint;

@property (nonatomic, weak) id<LCESecrecyTableViewCellDelegate> delegate;

@property (nonatomic, assign) NSInteger indexPathRow;
@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, getter=isEdit) BOOL edit; // default is NO. setting is not animated.
- (void)setEditing:(BOOL)editing animated:(BOOL)animated;

@end
