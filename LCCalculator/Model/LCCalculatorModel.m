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
    
    _leftString = @"0";
    _operator = @"";
    self.output = @"0";
}

- (void)calculate {
    
    if ([_operatorToSelectorMappingDict objectForKey:_operator]) {
        
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
    
    // input same operator
    if ([inputString isEqualToString:_operator]){
        return;
    }
    
    // reset
    if([inputString isEqualToString:@"AC"]){
        [self reset];
        _rightString = @"";
        return;
    }
    
    // input equal
    if([inputString isEqualToString:@"="]){
        [self calculate];
        return;
    }
    
    // input new operator
    if([_operatorToSelectorMappingDict objectForKey:inputString]){
        
        // replace operator
        if([_operatorToSelectorMappingDict objectForKey:_operator] && ![_rightString isEqualToString:@""]){
            [self calculate];
            _rightString = @"";
        }
        
        _operator = inputString;
        return;
    }
    
    // left nubmer editting
    if([_operator isEqualToString:@""]){
        self.output = _leftString = [self updateString:_leftString inputString:inputString];
        return;
    }
    
    // right number editting
    self.output = _rightString = [self updateString:_rightString inputString:inputString];;
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
