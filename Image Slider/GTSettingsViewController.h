//
//  GTSettingsViewController.h
//  Image Slider
//
//  Created by Tim McHale on 5/28/14.
//  Copyright (c) 2014 Gramercy Consultants. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GTSettingsViewController : UIViewController

{
    IBOutlet UISlider *mySlider;
    IBOutlet UITextField *myTextField;
    
}

@property (nonatomic) int *sliderValue;

@property (strong, nonatomic) IBOutlet UISlider *mySlider;
@property (strong, nonatomic) IBOutlet UITextField *myTextField;

@property int someData;
- (IBAction) sliderValueChanged:(id)sender;
- (IBAction) changeButtonPressed:(id)sender;


@end
