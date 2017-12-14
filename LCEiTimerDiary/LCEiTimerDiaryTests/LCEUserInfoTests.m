//
//  LCEUserInfoTests.m
//  LCEiTimerDiaryTests
//
//  Created by 妖狐小子 on 2017/12/14.
//  Copyright © 2017年 妖狐小子. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LCEUserInfoApi.h"
#import "LCEUserInfoModel.h"

@interface LCEUserInfoTests : XCTestCase

@end

@implementation LCEUserInfoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    XCTestExpectation *expectation = [self expectationWithDescription:@"UserInfo request"];
    LCEUserInfoApi *api = [[LCEUserInfoApi alloc] initWithUserId:@"ea6394b3ac5b494eb36d872536c5202b"];
    
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        
        NSLog(@"====%@", request.responseJSONObject);
        XCTAssertNotNil(request.responseJSONObject, @"request.responseJSONObject nil");
        XCTAssertNotNil(request, @"request nil");
        XCTAssertEqual(request.responseStatusCode, 200, @"status != 200");
        
        LCEUserInfoModel *model = [LCEUserInfoModel changeResponseJSONObject:request.responseJSONObject[@"data"]];
        NSLog(@"%@", model);
        [expectation fulfill];
        
    } failure:^(__kindof YTKBaseRequest *request) {
        XCTAssertNotNil(request, @"request nil");
    }];
    
    [self waitForExpectationsWithTimeout:15 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
