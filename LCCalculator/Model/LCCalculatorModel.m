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

@property (assign, nonatomic) BOOL isLastOperatoionWasEqual;
@property (strong, nonatomic) NSString *leftString;
@property (strong, nonatomic) NSString *rightString;
@property (strong, nonatomic) NSString *operator;
@property (strong, nonatomic) NSDictionary *operatorToSelectorMappingDict;

@end

@implementation LCCalculatorModel

- (instancetype)init {
    if(self = [super init]){
        _operatorToSelectorMappingDict = @{
                                           @"+": @"decimalNumberByAdding:",
                                           @"-": @"decimalNumberBySubtracting:",
                                           @"*": @"decimalNumberByMultiplyingBy:",
                                           @"/": @"decimalNumberByDividingBy:"
                                           };
        _rightString = @"";
        [self reset];
    }
    return self;
}

- (void)reset {

    _operator = @"";
    self.output = _leftString = @"0";
    _isLastOperatoionWasEqual = NO;
}

- (void)calculate {
    
    if ([_operatorToSelectorMappingDict objectForKey:_operator]) {
        
        if([_rightString isEqualToString:@""]){
            return;
        }
        
        // 1/0
        if([_operator isEqualToString:@"/"] && [_rightString isEqualToString:@"0"]){
            self.output = @"錯誤";
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
    }

    self.output = _leftString;
}

- (void)didReceiveInputString:(NSString *)inputString {

    NSLog(@"inputString: %@", inputString);
    
    if(inputString == nil) {
        return;
    }
    
    // reset
    if([inputString isEqualToString:@"AC"]){
        [self reset];
        _rightString = @"";
        return;
    }
    
    if(inputString.length > 1){
        return;
    }

    // input same operator
    if ([inputString isEqualToString:_operator]){
        return;
    }
    
    // input new operator
    if([_operatorToSelectorMappingDict objectForKey:inputString]){
        _isLastOperatoionWasEqual = NO;
        // replace operator
        if(_operator.length > 0 && _rightString.length > 0){
            [self calculate];
            _rightString = @"";
        }
        
        _operator = inputString;
        return;
    }
    
    // input equal
    if([inputString isEqualToString:@"="]){
        
        _isLastOperatoionWasEqual = YES;
        [self calculate];
        return;
    }
    
    // right number editting
    if (_operator.length > 0 && !_isLastOperatoionWasEqual) {
        self.output = _rightString = [self updateString:_rightString inputString:inputString];
        return;
    }
    
    if(_isLastOperatoionWasEqual == YES && ![_leftString containsString:@"."]) {
        _leftString = @"0";
    }

    // left nubmer editting
    self.output = _leftString = [self updateString:_leftString inputString:inputString];
}

- (NSString *)updateString:(NSString *)originString inputString:(NSString *)inputString {
    
    if([originString containsString:@"."] && [inputString isEqualToString:@"."]){
        return originString;
    }
    
    if([originString isEqualToString:@"0"] && ![inputString isEqualToString:@"."]){
        return inputString;
    }
    
    return [originString stringByAppendingString:inputString];
}

@end
