#import "LCCalculatorViewController.h"

#import "LCCalculatorModel.h"

@interface LCCalculatorViewController ()

// Model
@property (strong, nonatomic) LCCalculatorModel *calculator;
// Xib
@property (weak, nonatomic) IBOutlet UILabel *outputLabel;

@end

@implementation LCCalculatorViewController

- (void)dealloc {
    
    [_calculator removeObserver:self forKeyPath:@"output"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _calculator = [[LCCalculatorModel alloc] init];
    [_calculator addObserver:self forKeyPath:@"output"
                     options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew
                     context:@"output"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"output"]) {
        
        NSString *outputString = change[NSKeyValueChangeNewKey];
        _outputLabel.text = [outputString copy];
    }
    else {
        
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (IBAction)userDidClickButton:(UIButton *)sender {
    NSLog(@"%@", sender.titleLabel.text);
    [_calculator didReceiveInputString:sender.titleLabel.text];
}

@end
