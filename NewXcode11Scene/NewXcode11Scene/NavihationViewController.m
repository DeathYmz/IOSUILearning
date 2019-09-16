//
//  NavihationViewController.m
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/8/29.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import "NavihationViewController.h"
#import "ViewController.h"
@interface NavihationViewController ()

@end
@interface ContainerController ()
@property (nonatomic, strong) __kindof UIViewController *contentViewController;
@property (nonatomic, strong) UINavigationController *containerNavigationController;

+ (instancetype)containerControllerWithController:(UIViewController *)controller;
+ (instancetype)containerControllerWithController:(UIViewController *)controller
                               navigationBarClass:(Class)navigationBarClass;
+ (instancetype)containerControllerWithController:(UIViewController *)controller
                               navigationBarClass:(Class)navigationBarClass
                        withPlaceholderController:(BOOL)yesOrNo;
+ (instancetype)containerControllerWithController:(UIViewController *)controller
                               navigationBarClass:(Class)navigationBarClass
                        withPlaceholderController:(BOOL)yesOrNo
                                backBarButtonItem:(UIBarButtonItem *)backItem
                                        backTitle:(NSString *)backTitle;

- (instancetype)initWithController:(UIViewController *)controller;
- (instancetype)initWithController:(UIViewController *)controller
                navigationBarClass:(Class)navigationBarClass;

@end


@implementation ContainerController

+ (instancetype)containerControllerWithController:(UIViewController *)controller {
    return [[self alloc] initWithController:controller];
}

+ (instancetype)containerControllerWithController:(UIViewController *)controller
                               navigationBarClass:(Class)navigationBarClass {
    return [[self alloc] initWithController:controller navigationBarClass:navigationBarClass];
}

+ (instancetype)containerControllerWithController:(UIViewController *)controller
                               navigationBarClass:(Class)navigationBarClass
                        withPlaceholderController:(BOOL)yesOrNo {
    return [[self alloc] initWithController:controller
                         navigationBarClass:navigationBarClass
                  withPlaceholderController:yesOrNo];
}

+ (instancetype)containerControllerWithController:(UIViewController *)controller
                               navigationBarClass:(Class)navigationBarClass
                        withPlaceholderController:(BOOL)yesOrNo
                                backBarButtonItem:(UIBarButtonItem *)backItem
                                        backTitle:(NSString *)backTitle {
    return [[self alloc] initWithController:controller
                         navigationBarClass:navigationBarClass
                  withPlaceholderController:yesOrNo
                          backBarButtonItem:backItem
                                  backTitle:backTitle];
}

- (instancetype)initWithController:(UIViewController *)controller
                navigationBarClass:(Class)navigationBarClass
         withPlaceholderController:(BOOL)yesOrNo
                 backBarButtonItem:(UIBarButtonItem *)backItem
                         backTitle:(NSString *)backTitle {
    self = [super init];
    if (self) {
        // not work while push to a hideBottomBar view controller, give up
        /*
         self.edgesForExtendedLayout = UIRectEdgeAll;
         self.extendedLayoutIncludesOpaqueBars = YES;
         self.automaticallyAdjustsScrollViewInsets = NO;
         */

        self.contentViewController = controller;
        if (yesOrNo) {
            UIViewController *vc = [UIViewController new];
            vc.title = backTitle;
            vc.navigationItem.backBarButtonItem = backItem;
            self.containerNavigationController.viewControllers = @[ vc, controller ];
        } else
            self.containerNavigationController.viewControllers = @[ controller ];

        [self addChildViewController:self.containerNavigationController];
        [self.containerNavigationController didMoveToParentViewController:self];
    }
    return self;
}

- (instancetype)initWithController:(UIViewController *)controller
                navigationBarClass:(Class)navigationBarClass
         withPlaceholderController:(BOOL)yesOrNo {
    return [self initWithController:controller
                 navigationBarClass:navigationBarClass
          withPlaceholderController:yesOrNo
                  backBarButtonItem:nil
                          backTitle:nil];
}

- (instancetype)initWithController:(UIViewController *)controller
                navigationBarClass:(Class)navigationBarClass {
    return [self initWithController:controller
                 navigationBarClass:navigationBarClass
          withPlaceholderController:NO];
}

- (instancetype)initWithController:(UIViewController *)controller {
    return [self initWithController:controller navigationBarClass:nil];
}

- (instancetype)initWithContentController:(UIViewController *)controller {
    self = [super init];
    if (self) {
        self.contentViewController = controller;
        [self addChildViewController:self.contentViewController];
        [self.contentViewController didMoveToParentViewController:self];
    }
    return self;
}

- (NSString *)debugDescription {
    return [NSString
        stringWithFormat:@"<%@: %p contentViewController: %@>", self.class, self, self.contentViewController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.containerNavigationController) {
        self.containerNavigationController.view.autoresizingMask =
            UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self.view addSubview:self.containerNavigationController.view];
        self.containerNavigationController.view.frame = self.view.bounds;
    } else {
        self.contentViewController.view.autoresizingMask =
            UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.contentViewController.view.frame = self.view.bounds;
        [self.view addSubview:self.contentViewController.view];
    }
}

- (BOOL)becomeFirstResponder {
    return [self.contentViewController becomeFirstResponder];
}

- (BOOL)canBecomeFirstResponder {
    return [self.contentViewController canBecomeFirstResponder];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.contentViewController preferredStatusBarStyle];
}

- (BOOL)prefersStatusBarHidden {
    return [self.contentViewController prefersStatusBarHidden];
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return [self.contentViewController preferredStatusBarUpdateAnimation];
}

#if __IPHONE_11_0 && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0
- (nullable UIViewController *)childViewControllerForScreenEdgesDeferringSystemGestures {
    return self.contentViewController;
}

- (UIRectEdge)preferredScreenEdgesDeferringSystemGestures {
    return [self.contentViewController preferredScreenEdgesDeferringSystemGestures];
}

- (BOOL)prefersHomeIndicatorAutoHidden {
    return [self.contentViewController prefersHomeIndicatorAutoHidden];
}

- (UIViewController *)childViewControllerForHomeIndicatorAutoHidden {
    return self.contentViewController;
}
#endif

- (BOOL)shouldAutorotate {
    return self.contentViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.contentViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return self.contentViewController.preferredInterfaceOrientationForPresentation;
}

- (UIViewController *)viewControllerForUnwindSegueAction:(SEL)action
                                      fromViewController:(UIViewController *)fromViewController
                                              withSender:(id)sender {
    return [self.contentViewController viewControllerForUnwindSegueAction:action
                                                       fromViewController:fromViewController
                                                               withSender:sender];
}

- (BOOL)hidesBottomBarWhenPushed {
    return self.contentViewController.hidesBottomBarWhenPushed;
}

- (NSString *)title {
    return self.contentViewController.title;
}

- (UITabBarItem *)tabBarItem {
    return self.contentViewController.tabBarItem;
}

@end

@implementation NavihationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
@end

