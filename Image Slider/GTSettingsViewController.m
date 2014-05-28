//
//  GTSettingsViewController.m
//  Image Slider
//
//  Created by Tim McHale on 5/28/14.
//  Copyright (c) 2014 Gramercy Consultants. All rights reserved.
//

#import "GTSettingsViewController.h"

@interface GTSettingsViewController ()

@end

@implementation GTSettingsViewController
@synthesize mySlider, myTextField;
@synthesize sliderValue, someData;

- (IBAction) sliderValueChanged:(UISlider *)sender {
    myTextField.text = [NSString stringWithFormat:@"%.1f", [sender value]];
}

- (IBAction) changeButtonPressed:(id)sender {
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    
    NSLog(@"text value = %@", myTextField);
    NSString *textValue = [myTextField text];
    int value = [textValue floatValue];
    if (value < 0) value = 0;
    if (value > 100) value = 100;
    mySlider.value = value;
    sliderValue = &value;
    NSLog(@"sliderValue = %d", *(sliderValue));
    myTextField.text = [NSString stringWithFormat:@"%.1d", value];
    if ([myTextField canResignFirstResponder]) [myTextField resignFirstResponder];
    someData = *(sliderValue);
    
    NSLog(@"slidervalue = %d", sliderValue);
    
    NSLog(@"someData = %d", someData);
    
    [defaults setInteger:someData forKey:@"Cheese"];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
