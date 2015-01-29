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
    [super tearDown];
}

- (void)testNumberAppending {
    
    // 0 0 0 0 = 0
    [_calculator didReceiveInputString:@"0"];
    [_calculator didReceiveInputString:@"0"];
    [_calculator didReceiveInputString:@"0"];
    XCTAssertEqualObjects(_calculator.output,@"0");
    
    // 1 1 = 11
    [_calculator didReceiveInputString:@"1"];
    [_calculator didReceiveInputString:@"1"];
    XCTAssertEqualObjects(_calculator.output,@"11");
}

- (void)testNumberAppedingWithDot {
    
    // 0 . . . . 0 0 1 = 0.001
    [_calculator didReceiveInputString:@"0"];
    XCTAssertEqualObjects(_calculator.output,@"0");
    [_calculator didReceiveInputString:@"."];
    XCTAssertEqualObjects(_calculator.output,@"0.");
    [_calculator didReceiveInputString:@"."];
    [_calculator didReceiveInputString:@"."];
    [_calculator didReceiveInputString:@"."];
    XCTAssertEqualObjects(_calculator.output,@"0.");
    [_calculator didReceiveInputString:@"0"];
    XCTAssertEqualObjects(_calculator.output,@"0.0");
    [_calculator didReceiveInputString:@"0"];
    XCTAssertEqualObjects(_calculator.output,@"0.00");
    [_calculator didReceiveInputString:@"1"];
    XCTAssertEqualObjects(_calculator.output,@"0.001");
}

- (void)testNumberAppedingWithDot2 {
    
    // 0 . . . . 0 0 1 = 0.001
    [_calculator didReceiveInputString:@"0"];
    XCTAssertEqualObjects(_calculator.output,@"0");
    [_calculator didReceiveInputString:@"."];
    XCTAssertEqualObjects(_calculator.output,@"0.");
    [_calculator didReceiveInputString:@"+"];
    XCTAssertEqualObjects(_calculator.output,@"0.");
    [_calculator didReceiveInputString:@"1"];
    XCTAssertEqualObjects(_calculator.output,@"1");
}

- (void)testSimpleCalculate {
    
    // 1 + 2 = 3
    [_calculator didReceiveInputString:@"1"];
    XCTAssertEqualObjects(_calculator.output,@"1");
    [_calculator didReceiveInputString:@"+"];
    XCTAssertEqualObjects(_calculator.output,@"1");
    [_calculator didReceiveInputString:@"2"];
    XCTAssertEqualObjects(_calculator.output,@"2");
    [_calculator didReceiveInputString:@"="];
    XCTAssertEqualObjects(_calculator.output,@"3");
    [_calculator didReceiveInputString:@"AC"];
    XCTAssertEqualObjects(_calculator.output,@"0");
    
    // 4 - 3 =
    [_calculator didReceiveInputString:@"4"];
    XCTAssertEqualObjects(_calculator.output,@"4");
    [_calculator didReceiveInputString:@"-"];
    XCTAssertEqualObjects(_calculator.output,@"4");
    [_calculator didReceiveInputString:@"3"];
    XCTAssertEqualObjects(_calculator.output,@"3");
    [_calculator didReceiveInputString:@"="];
    XCTAssertEqualObjects(_calculator.output,@"1");
    [_calculator didReceiveInputString:@"AC"];
    XCTAssertEqualObjects(_calculator.output,@"0");
    
    // 4 * 5 = 20
    [_calculator didReceiveInputString:@"4"];
    XCTAssertEqualObjects(_calculator.output,@"4");
    [_calculator didReceiveInputString:@"*"];
    XCTAssertEqualObjects(_calculator.output,@"4");
    [_calculator didReceiveInputString:@"5"];
    XCTAssertEqualObjects(_calculator.output,@"5");
    [_calculator didReceiveInputString:@"="];
    XCTAssertEqualObjects(_calculator.output,@"20");
    [_calculator didReceiveInputString:@"AC"];
    XCTAssertEqualObjects(_calculator.output,@"0");
    
    // 4 / 2 = 2
    [_calculator didReceiveInputString:@"4"];
    XCTAssertEqualObjects(_calculator.output,@"4");
    [_calculator didReceiveInputString:@"/"];
    XCTAssertEqualObjects(_calculator.output,@"4");
    [_calculator didReceiveInputString:@"2"];
    XCTAssertEqualObjects(_calculator.output,@"2");
    [_calculator didReceiveInputString:@"="];
    XCTAssertEqualObjects(_calculator.output,@"2");
    [_calculator didReceiveInputString:@"AC"];
    XCTAssertEqualObjects(_calculator.output,@"0");
}

- (void)testNaN {
    
    // 1 / 0 = 錯誤
    [_calculator didReceiveInputString:@"1"];
    [_calculator didReceiveInputString:@"/"];
    [_calculator didReceiveInputString:@"0"];
    [_calculator didReceiveInputString:@"="];
    XCTAssertEqualObjects(_calculator.output,@"錯誤");
}

- (void)testComboCalculate {
    
    // + 1 + +
    [_calculator didReceiveInputString:@"+"];
    [_calculator didReceiveInputString:@"1"];
    XCTAssertEqualObjects(_calculator.output,@"1");
    [_calculator didReceiveInputString:@"+"];
    XCTAssertEqualObjects(_calculator.output,@"1");
    [_calculator didReceiveInputString:@"+"];
    XCTAssertEqualObjects(_calculator.output,@"1");
}

- (void)testComboEqual {
    
    // + 1 = = = =
    [_calculator didReceiveInputString:@"+"];
    [_calculator didReceiveInputString:@"1"];
    XCTAssertEqualObjects(_calculator.output,@"1");
    [_calculator didReceiveInputString:@"="];
    XCTAssertEqualObjects(_calculator.output,@"1");
    [_calculator didReceiveInputString:@"="];
    XCTAssertEqualObjects(_calculator.output,@"2");
    [_calculator didReceiveInputString:@"="];
    XCTAssertEqualObjects(_calculator.output,@"3");
    [_calculator didReceiveInputString:@"="];
    XCTAssertEqualObjects(_calculator.output,@"4");
}

- (void)testChangeOperator {
    
    // 5 + - 2 = =
    [_calculator didReceiveInputString:@"5"];
    XCTAssertEqualObjects(_calculator.output,@"5");
    [_calculator didReceiveInputString:@"+"];
    XCTAssertEqualObjects(_calculator.output,@"5");
    [_calculator didReceiveInputString:@"-"];
    XCTAssertEqualObjects(_calculator.output,@"5");
    [_calculator didReceiveInputString:@"2"];
    XCTAssertEqualObjects(_calculator.output,@"2");
    [_calculator didReceiveInputString:@"="];
    XCTAssertEqualObjects(_calculator.output,@"3");
    [_calculator didReceiveInputString:@"="];
    XCTAssertEqualObjects(_calculator.output,@"1");
    [_calculator didReceiveInputString:@"="];
    XCTAssertEqualObjects(_calculator.output,@"-1");
}

- (void)testComboSubtractingWithEqual {
    
    // 1 + 3 - 2 = = =
    [_calculator didReceiveInputString:@"1"];
    [_calculator didReceiveInputString:@"+"];
    [_calculator didReceiveInputString:@"3"];
    XCTAssertEqualObjects(_calculator.output, @"3");
    [_calculator didReceiveInputString:@"-"];
    XCTAssertEqualObjects(_calculator.output, @"4");
    [_calculator didReceiveInputString:@"2"];
    XCTAssertEqualObjects(_calculator.output, @"2");
    [_calculator didReceiveInputString:@"="];
    XCTAssertEqualObjects(_calculator.output, @"2");
    [_calculator didReceiveInputString:@"="];
    XCTAssertEqualObjects(_calculator.output, @"0");
    [_calculator didReceiveInputString:@"="];
    XCTAssertEqualObjects(_calculator.output, @"-2");
}

- (void)testNonRightString {
    
    [_calculator didReceiveInputString:@"+"];
    XCTAssertEqualObjects(_calculator.output, @"0");
    [_calculator didReceiveInputString:@"="];
    XCTAssertEqualObjects(_calculator.output, @"0");
    [_calculator didReceiveInputString:@"-"];
    XCTAssertEqualObjects(_calculator.output, @"0");
    [_calculator didReceiveInputString:@"="];
    XCTAssertEqualObjects(_calculator.output, @"0");
    [_calculator didReceiveInputString:@"-"];
    XCTAssertEqualObjects(_calculator.output, @"0");
    [_calculator didReceiveInputString:@"="];
    XCTAssertEqualObjects(_calculator.output, @"0");
}

- (void)testLastOperationWasEqual {
    
    [_calculator didReceiveInputString:@"5"];
    XCTAssertEqualObjects(_calculator.output, @"5");
    [_calculator didReceiveInputString:@"+"];
    XCTAssertEqualObjects(_calculator.output, @"5");
    [_calculator didReceiveInputString:@"3"];
    XCTAssertEqualObjects(_calculator.output, @"3");
    [_calculator didReceiveInputString:@"="];
    XCTAssertEqualObjects(_calculator.output, @"8");
    [_calculator didReceiveInputString:@"."];
    XCTAssertEqualObjects(_calculator.output, @"0.");
    [_calculator didReceiveInputString:@"3"];
    XCTAssertEqualObjects(_calculator.output, @"0.3");
    [_calculator didReceiveInputString:@"="];
    XCTAssertEqualObjects(_calculator.output, @"3.3");
}

- (void)testLastOperationWasEqual2 {
    
    [_calculator didReceiveInputString:@"5"];
    XCTAssertEqualObjects(_calculator.output, @"5");
    [_calculator didReceiveInputString:@"+"];
    XCTAssertEqualObjects(_calculator.output, @"5");
    [_calculator didReceiveInputString:@"3"];
    XCTAssertEqualObjects(_calculator.output, @"3");
    [_calculator didReceiveInputString:@"="];
    XCTAssertEqualObjects(_calculator.output, @"8");
    [_calculator didReceiveInputString:@"0"];
    [_calculator didReceiveInputString:@"."];
    XCTAssertEqualObjects(_calculator.output, @"0.");
    [_calculator didReceiveInputString:@"3"];
    XCTAssertEqualObjects(_calculator.output, @"0.3");
    [_calculator didReceiveInputString:@"="];
    XCTAssertEqualObjects(_calculator.output, @"3.3");
}

- (void)test3 {
    
    [_calculator didReceiveInputString:@"8"];
    [_calculator didReceiveInputString:@"+"];
    [_calculator didReceiveInputString:@"3"];
    [_calculator didReceiveInputString:@"."];
    [_calculator didReceiveInputString:@"2"];
    XCTAssertEqualObjects(_calculator.output, @"3.2");
    [_calculator didReceiveInputString:@"="];
    XCTAssertEqualObjects(_calculator.output, @"11.2");
}

- (void)test2 {
    
    [_calculator didReceiveInputString:@"5"];
    XCTAssertEqualObjects(_calculator.output, @"5");
    [_calculator didReceiveInputString:@"+"];
    XCTAssertEqualObjects(_calculator.output,@"5");
    [_calculator didReceiveInputString:@"2"];
    XCTAssertEqualObjects(_calculator.output,@"2");
    [_calculator didReceiveInputString:@"."];
    XCTAssertEqualObjects(_calculator.output,@"2.");
    [_calculator didReceiveInputString:@"4"];
    XCTAssertEqualObjects(_calculator.output,@"2.4");
}

- (void)testPreventInputWrongTyep {
    
    //不能輸入11
    [_calculator didReceiveInputString:@"11"];
    XCTAssertEqualObjects(_calculator.output,@"0");
    [_calculator didReceiveInputString:@"0"];
}

@end
