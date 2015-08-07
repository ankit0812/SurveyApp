//
//  ViewController.h
//  SurveyApp
//
//  Created by optimusmac4 on 8/6/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource,UIScrollViewDelegate,UITextFieldDelegate>



@property (weak, nonatomic) IBOutlet UIPickerView *picker1;



@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;
@property (weak, nonatomic) IBOutlet UIImageView *image4;



@property (weak, nonatomic) IBOutlet UIScrollView *scroller;



@property (weak, nonatomic) IBOutlet UITextField *manufacturer;

@property (weak, nonatomic) IBOutlet UITextField *model;

@property (weak, nonatomic) IBOutlet UITextField *serialNumber;

@property (weak, nonatomic) IBOutlet UITextField *colorInfo;

@property (weak, nonatomic) IBOutlet UITextField *sizeInfo;



@property (weak, nonatomic) IBOutlet UIDatePicker *dateSelecter;


@property (weak, nonatomic) IBOutlet UIDatePicker *timeSelecter;


@property (weak, nonatomic) IBOutlet UITextField *emailID;


- (IBAction)submit:(id)sender;

@end



