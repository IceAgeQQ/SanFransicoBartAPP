//
//  SchedueInformationViewController.h
//  BARTAPP
//
//  Created by Chao Xu on 14-1-6.
//  Copyright (c) 2014年 Chao Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SchedueInformationViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *DepartLabel;
@property (strong, nonatomic) IBOutlet UILabel *ArriveLabel;
@property (strong, nonatomic) IBOutlet UILabel *SchednumLabel;
@property (strong, nonatomic) IBOutlet UILabel *DateLabel;
@property (strong, nonatomic) IBOutlet UILabel *TimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *BeforeLabel;
@property (strong, nonatomic) IBOutlet UILabel *AfterLabel;
@property (strong,nonatomic) IBOutlet UITextField *DepartTextField;
@property (strong,nonatomic) IBOutlet UITextField *ArriveTextField;
-(NSString *)test;
-(NSString *)test2;
@end
