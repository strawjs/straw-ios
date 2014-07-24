#import "STWViewController.h"

@interface STWViewController ()

@property (nonatomic, retain) STWWebViewDelegate *delegate;
@property (nonatomic, retain) UIWebView *webView;

@end

@implementation STWViewController

- (id)init
{
    self = [super init];

    if (self) {
        // create a webView
        self.webView = [[UIWebView alloc] init];

        // configure
        self.webView.autoresizesSubviews = YES;
        self.webView.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);

        // create a STWWebViewDelegate object
        self.delegate = [[STWWebViewDelegate alloc] initWithWebView:self.webView withViewController:self];
    }

    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    // set the frame of the webView
    [self.webView setFrame:self.view.frame];

    // load www/index.html
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"www/index" ofType:@"html"]]]];

    // add the webView to the tree of views
    [self.view addSubview:self.webView];
}

- (void)loadService:(Class<STWService>)serviceClass
{
    [self.delegate loadService:serviceClass];
}


@end
