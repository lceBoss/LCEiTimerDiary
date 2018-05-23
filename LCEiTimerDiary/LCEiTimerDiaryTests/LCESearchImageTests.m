//
//  LCESearchImageTests.m
//  LCEiTimerDiaryTests
//
//  Created by 妖狐小子 on 2018/5/23.
//  Copyright © 2018年 妖狐小子. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LCESearchImageTagListApi.h"
#import "LCESearchImageTagModel.h"
#import "LCEStreetSnapImageApi.h"
#import "LCESearchImageModel.h"

@interface LCESearchImageTests : XCTestCase

@end

@implementation LCESearchImageTests

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
    LCESearchImageTagListApi *api = [[LCESearchImageTagListApi alloc] init];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSLog(@"====%@", request.responseJSONObject);
        XCTAssertNotNil(request.responseJSONObject, @"request.responseJSONObject nil");
        XCTAssertNotNil(request, @"request nil");
        XCTAssertEqual(request.responseStatusCode, 200, @"status != 200");
        NSArray *dataArray = [LCESearchImageTagModel changeResponseJSONObject:request.responseJSONObject[@"data"]];
        LCESearchImageTagModel *model = dataArray[0];
        NSLog(@"%@", model.keyword);
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

- (void)testImageApi {
    XCTestExpectation *expectation = [self expectationWithDescription:@"UserInfo request"];
    LCEStreetSnapImageApi *api = [[LCEStreetSnapImageApi alloc] initWithKeyword:@"街拍" page:2];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        
        NSLog(@"====%@", request.responseJSONObject);
        XCTAssertNotNil(request.responseJSONObject, @"request.responseJSONObject nil");
        XCTAssertNotNil(request, @"request nil");
        XCTAssertEqual(request.responseStatusCode, 200, @"status != 200");
        
        NSArray *dataArray = [LCESearchImageModel changeResponseJSONObject:request.responseJSONObject[@"data"]];
        
        LCESearchImageModel *imageModel = dataArray[0];
        NSLog(@"%@", imageModel.title);
        
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
