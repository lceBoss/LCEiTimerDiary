//
//  LCEUserInfoModel.h
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2017/12/14.
//  Copyright © 2017年 妖狐小子. All rights reserved.
//

#import "LCEBaseModel.h"

@interface LCEUserInfoModel : LCEBaseModel

@property (nonatomic, strong) NSString *photo;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *user_type_name;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *market;
@property (nonatomic, strong) NSString *userType;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, assign) NSInteger is_subscribed;
@property (nonatomic, assign) NSInteger colleaguenum;
@property (nonatomic, assign) NSInteger livenum;
@property (nonatomic, assign) NSInteger livestatus;
@property (nonatomic, assign) NSInteger coursenum;
@property (nonatomic, assign) NSInteger issuenum;
@property (nonatomic, strong) NSString *parent_ids;
@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *office_name;
@property (nonatomic, strong) NSString *officeId;
@property (nonatomic, assign) NSInteger articlenum;
@property (nonatomic, assign) NSInteger attentionnum;
@property (nonatomic, assign) NSInteger fansnum;
@property (nonatomic, assign) NSInteger commentnum;
@property (nonatomic, assign) NSInteger bycommentnum;
@property (nonatomic, assign) NSInteger messagenum;
@property (nonatomic, assign) NSInteger articlecommentcount;
@property (nonatomic, assign) NSInteger askcommentcount;

@end
