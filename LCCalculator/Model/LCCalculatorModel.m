//
//  LCCalculatorModel.m
//  LCCalculator
//
//  Created by Liyao on 2015/1/20.
//  Copyright (c) 2015年 KKBOX. All rights reserved.
//

#import "LCCalculatorModel.h"

@interface LCCalculatorModel()

@property (strong, nonatomic, readwrite) NSString *output;

@property (strong, nonatomic) NSString *leftString;
@property (strong, nonatomic) NSString *rightString;


@property (strong, nonatomic) NSString *operator;

@property (strong, nonatomic) NSArray *operators;
@property (strong, nonatomic) NSDictionary *operatorToSelectorMappingDict;
@end

@implementation LCCalculatorModel

- (instancetype)init {
    if(self = [super init]){
        
        _operators = @[@"+", @"-", @"*", @"/"];
        _operatorToSelectorMappingDict = @{
                                           @"+": @"decimalNumberByAdding:",
                                           @"-": @"decimalNumberBySubtracting:",
                                           @"*": @"decimalNumberByMultiplyingBy:",
                                           @"/": @"decimalNumberByDividingBy:"
                                           };
        [self reset];
    }
    return self;
}

- (void)reset {
    
    _leftString = @"0";
    _rightString = @"";
    _operator = @"";
    _output = @"0";
}

- (void)calculate{
    
    if([_operator isEqualToString:@""]){
//        _output = [NSDecimalNumber decimalNumberWithString:_leftString];
        _output = _leftString;
        NSLog(@"output string = %@", _output);
    }
    else if ([_operators containsObject:_operator]) {
        
        if([_operator isEqualToString:@"/"] && [_rightString isEqualToString:@"0"]){
            _output = @"錯誤";
            return;
        }
        
        SEL opSelector = NSSelectorFromString(_operatorToSelectorMappingDict[_operator]);
        NSDecimalNumber *leftNumber = [NSDecimalNumber decimalNumberWithString:_leftString];
        NSDecimalNumber *rightNumber = [NSDecimalNumber decimalNumberWithString:_rightString];
        NSDecimalNumber *result = [NSDecimalNumber zero];
        if ([leftNumber respondsToSelector:opSelector]){
            
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            result = [leftNumber performSelector:opSelector withObject:rightNumber];
#pragma clang diagnostic pop

        }
        
        _leftString = [result stringValue];
        _output = _leftString;
        NSLog(@"output string = %@", _output);
    }
}

- (void)didReceiveInputString:(NSString *)string {
    
    NSLog(@"input string = %@", string);
    // reset
    if([string isEqualToString:@"AC"]){
        [self reset];
    }
    
    // input equal
    else if([string isEqualToString:@"="]){
        
        [self calculate];
    }
    
    // input operator
    else if([_operators containsObject:string]){
        
        if(![_operators containsObject:_operator]){
            [self calculate];
        }
        _operator = string;
    }
    
    // input numbers
    else {
        
        if([_operator isEqualToString:@""]){
            // left nubmer editting
            _leftString = [self stringByAppending:_leftString inputString:string];
            [self calculate];
        }
        else {
            // right number editting
            _rightString = [self stringByAppending:_rightString inputString:string];
            _output = _rightString;
        }
    }
}

- (NSString *)stringByAppending:(NSString *)originString inputString:(NSString *)inputString {
    
    
    if([inputString isEqualToString:@"."] && [originString containsString:@"."]){
        return originString;
    }
    
    if([originString isEqualToString:@"0"] && ![inputString isEqualToString:@"."]){
        
        return inputString;
    }
    else {
        return [originString stringByAppendingString:inputString];
    }
    return nil;
}

- (NSDecimalNumber *)appendNubmer:(NSDecimalNumber *)number withString:(NSString *)string {
    
    NSString *numberAfterApeending = [[number stringValue] stringByAppendingString:string];
    return [NSDecimalNumber decimalNumberWithString:numberAfterApeending];
}

@end
