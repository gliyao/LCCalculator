//
//  LCCalculatorModel.h
//  LCCalculator
//
//  Created by Liyao on 2015/1/20.
//  Copyright (c) 2015年 KKBOX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCCalculatorModel : NSObject

@property (strong, nonatomic, readonly) NSString *output;

- (void)didReceiveInputString:(NSString *)string;

@end
