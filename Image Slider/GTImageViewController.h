//
//  GTImageViewController.h
//  Image Slider
//
//  Created by Tim McHale on 5/28/14.
//  Copyright (c) 2014 Gramercy Consultants. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"
#import "GTViewController.h"
@interface GTImageViewController : UIPageViewController <UIPageViewControllerDataSource>

- (IBAction)startWalkthrough:(id)sender;

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageImages;
@property (strong, nonatomic) NSTimer *timer;
@property NSInteger currentIndex;

@end
