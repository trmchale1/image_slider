//
//  GTImageViewController.m
//  Image Slider
//
//  Created by Tim McHale on 5/28/14.
//  Copyright (c) 2014 Gramercy Consultants. All rights reserved.
//

#import "GTImageViewController.h"

@interface GTImageViewController ()

@end

@implementation GTImageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    id y = [defaults objectForKey:@"Cheese"];
    int z = [y integerValue];
    
    NSLog(@"z = %d", z);
    
    [self.navigationItem setHidesBackButton:YES];
    self.currentIndex = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:z
                                                  target:self
                                                selector:@selector(timerExpired:)
                                                userInfo:nil
                                                 repeats:NO];
    
	// Create the data model
    _pageImages = @[@"i-Pads_00_txt.png", @"i-Pads_01_txt.png", @"i-Pads_02_txt.png", @"i-Pads_03_txt.png", @"i-Pads_04_txt.png", @"i-Pads_06_txt.png", @"i-Pads_07_txt.png", @"i-Pads_08_txt.png", @"i-Pads_09_txt.png", @"i-Pads_05_txt.png", @"i-Pads_10_txt.png", @"i-Pads_11_txt.png", @"i-Pads_12_txt.png", @"i-Pads_13_txt.png", @"i-Pads_14_txt.png", @"i-Pads_15_txt.png", @"i-Pads_16_txt.png", @"i-Pads_18_txt.png", @"i-Pads_19_txt.png", @"i-Pads_20_txt.png", @"i-Pads_21_txt.png", @"i-Pads_22_txt.png", @"i-Pads_23_txt.png", @"i-Pads_24_txt.png", @"i-Pads_25_txt.png", @"i-Pads_26_txt.png", @"i-Pads_27_txt.png", @"i-Pads_28_txt.png", @"i-Pads_29_txt.png", @"i-Pads_30_txt.png"];
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    NSLog(@"photo = %@", _pageImages[0]);
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height); // -30
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    
    NSArray *subviews = self.pageViewController.view.subviews;
    UIPageControl *thisControl = nil;
    for (int i=0; i<[subviews count]; i++) {
        if ([[subviews objectAtIndex:i] isKindOfClass:[UIPageControl class]]) {
            thisControl = (UIPageControl *)[subviews objectAtIndex:i];
        }
    }
    
    thisControl.hidden = true;
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height); // + 40
    
    NSLog(@"self %@", self);
    [self.pageViewController didMoveToParentViewController:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startWalkthrough:(id)sender {
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
}



- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageImages count] == 0) || (index >= [self.pageImages count])) {
        return nil;
    }
    
    
    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.imageFile = self.pageImages[index];
    NSLog(@"? = %@", self.pageImages[0]);
    pageContentViewController.pageIndex = index;
    
    /**
     * make sure 0 < index < [self.pageImages count]
     * index = 0, buttonPrevious = 4
     * index = 4, buttonNext = 0
     *
     * buttonPrevious.image = self.pageImages[index -1];
     * buttonCurrent.image = self.pageImages[index];
     * buttonNext.image = self.pageImages[index+1];
     */
    
    
    [self resetTimer];
    
    NSLog(@"page content view controller = %@", pageContentViewController);

    return pageContentViewController;
    NSLog(@"page content view controller = %@", pageContentViewController);
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        index = [self.pageImages count];
    }
    index--;
    
    self.currentIndex = index;
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageImages count]) {
        index = 0;
    }
    
    self.currentIndex = index;
    
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    
    return [self.pageImages count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

-(void) timerExpired: (id) sender
{
    self.currentIndex++;
    if (self.currentIndex == [self.pageImages count])
        self.currentIndex = 0;
    
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.imageFile = self.pageImages[self.currentIndex];
    pageContentViewController.pageIndex = self.currentIndex;
    
    [self.pageViewController setViewControllers:@[pageContentViewController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
    
    [self resetTimer];
    NSLog(@"timer went off");
    
    
    
}

-(void) resetTimer
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    id y = [defaults objectForKey:@"Cheese"];
    int z = [y integerValue];
    NSLog(@"z = %d", z);
    if (self.timer != nil)
        [self.timer invalidate];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:z
                                                  target:self
                                                selector:@selector(timerExpired:)
                                                userInfo:nil
                                                 repeats:NO];
}
@end
