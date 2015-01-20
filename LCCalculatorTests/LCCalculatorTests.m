//
//  LCCalculatorTests.m
//  LCCalculatorTests
//
//  Created by Liyao on 2015/1/20.
//  Copyright (c) 2015年 KKBOX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "LCCalculatorModel.h"

@interface LCCalculatorTests : XCTestCase

@property (strong, nonatomic) LCCalculatorModel *calculator;

@end

@implementation LCCalculatorTests

- (void)setUp {
    [super setUp];
    _calculator = [[LCCalculatorModel alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNumberAppending {
    
    [_calculator didReceiveInputString:@"0"];
    [_calculator didReceiveInputString:@"0"];
    [_calculator didReceiveInputString:@"0"];
    XCTAssertTrue([_calculator.output isEqualToString:@"0"]);
    
    [_calculator didReceiveInputString:@"1"];
    [_calculator didReceiveInputString:@"1"];
    XCTAssertTrue([_calculator.output isEqualToString:@"11"]);
}

- (void)testNumberAppedingWithDot {

    [_calculator didReceiveInputString:@"0"];
    XCTAssertTrue([_calculator.output isEqualToString:@"0"]);
    
    [_calculator didReceiveInputString:@"."];
    XCTAssertTrue([_calculator.output isEqualToString:@"0."]);
    [_calculator didReceiveInputString:@"."];
    [_calculator didReceiveInputString:@"."];
    [_calculator didReceiveInputString:@"."];
    XCTAssertTrue([_calculator.output isEqualToString:@"0."]);
    
    [_calculator didReceiveInputString:@"0"];
    XCTAssertTrue([_calculator.output isEqualToString:@"0.0"]);
    [_calculator didReceiveInputString:@"0"];
    XCTAssertTrue([_calculator.output isEqualToString:@"0.00"]);
    [_calculator didReceiveInputString:@"1"];
    XCTAssertTrue([_calculator.output isEqualToString:@"0.001"]);
}

- (void)testSimpleCalculate {
    
    // +
    [_calculator didReceiveInputString:@"1"];
    XCTAssertTrue([_calculator.output isEqualToString:@"1"]);
    [_calculator didReceiveInputString:@"+"];
    XCTAssertTrue([_calculator.output isEqualToString:@"1"]);
    [_calculator didReceiveInputString:@"2"];
    XCTAssertTrue([_calculator.output isEqualToString:@"2"]);
    [_calculator didReceiveInputString:@"="];
    XCTAssertTrue([_calculator.output isEqualToString:@"3"]);
    [_calculator didReceiveInputString:@"AC"];
    XCTAssertTrue([_calculator.output isEqualToString:@"0"]);
    
    // -
    [_calculator didReceiveInputString:@"4"];
    XCTAssertTrue([_calculator.output isEqualToString:@"4"]);
    [_calculator didReceiveInputString:@"-"];
    XCTAssertTrue([_calculator.output isEqualToString:@"4"]);
    [_calculator didReceiveInputString:@"3"];
    XCTAssertTrue([_calculator.output isEqualToString:@"3"]);
    [_calculator didReceiveInputString:@"="];
    XCTAssertTrue([_calculator.output isEqualToString:@"1"]);
    [_calculator didReceiveInputString:@"AC"];
    XCTAssertTrue([_calculator.output isEqualToString:@"0"]);
    
    // *
    [_calculator didReceiveInputString:@"4"];
    XCTAssertTrue([_calculator.output isEqualToString:@"4"]);
    [_calculator didReceiveInputString:@"*"];
    XCTAssertTrue([_calculator.output isEqualToString:@"4"]);
    [_calculator didReceiveInputString:@"5"];
    XCTAssertTrue([_calculator.output isEqualToString:@"5"]);
    [_calculator didReceiveInputString:@"="];
    XCTAssertTrue([_calculator.output isEqualToString:@"20"]);
    [_calculator didReceiveInputString:@"AC"];
    XCTAssertTrue([_calculator.output isEqualToString:@"0"]);
    
    // /
    [_calculator didReceiveInputString:@"4"];
    XCTAssertTrue([_calculator.output isEqualToString:@"4"]);
    [_calculator didReceiveInputString:@"/"];
    XCTAssertTrue([_calculator.output isEqualToString:@"4"]);
    [_calculator didReceiveInputString:@"2"];
    XCTAssertTrue([_calculator.output isEqualToString:@"2"]);
    NSLog(@"%@", _calculator.output);
    [_calculator didReceiveInputString:@"="];
    XCTAssertTrue([_calculator.output isEqualToString:@"2"]);
    [_calculator didReceiveInputString:@"AC"];
    XCTAssertTrue([_calculator.output isEqualToString:@"0"]);
}


// TODO: 1/0 = NaN
// 1 + 2 + - 10 = ??
// = 就承上次 operator and right





@end
