#import <Foundation/Foundation.h>

@interface LCCalculatorModel : NSObject

@property (strong, nonatomic, readonly) NSString *output;

- (void)didReceiveInputString:(NSString *)string;

@end
