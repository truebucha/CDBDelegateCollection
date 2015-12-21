

#import "CDBViewController.h"

@import CDBDelegateCollection;


@protocol CDBExampleProtocol <NSObject>

- (void)exampleMethodCalledWith:(NSString *)description;

@end


@interface CDBViewController ()
<CDBExampleProtocol>

@property (strong, nonatomic) CDBDelegateCollection * delegates;

@end


@implementation CDBViewController

#pragma mark - Life cycle -

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showExample];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Protocol - 

#pragma mark CBDExampleProtocol

- (void)exampleMethodCalledWith:(NSString *)description {
    NSLog(@"Received delegate call with description: %@", description);
}

#pragma mark - Private -

- (void)showExample {
    [self.delegates addDelegate:self];
    
    [self.delegates enumerateDelegatesRespondToSelector:@selector(exampleMethodCalledWith:)
                                             usingBlock:^(id<CDBExampleProtocol> delegate, BOOL *stop) {
        [delegate exampleMethodCalledWith:self.description];
    }];
    
}

#pragma mark - Property -

#pragma mark Lazy loading

- (CDBDelegateCollection *)delegates {
    if (_delegates == nil) {
        _delegates =
            [[CDBDelegateCollection alloc] initWithProtocol:@protocol(CDBExampleProtocol)];
    }
    return _delegates;
}

@end
