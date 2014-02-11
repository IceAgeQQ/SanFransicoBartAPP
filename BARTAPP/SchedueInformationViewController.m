//
//  SchedueInformationViewController.m
//  BARTAPP
//
//  Created by Chao Xu on 14-1-6.
//  Copyright (c) 2014年 Chao Xu. All rights reserved.
//

#import "SchedueInformationViewController.h"
#import "ServerAPI.h"
#import "XMLDictionary.h"
#import "NSDictionary+helloworld.h"
@interface SchedueInformationViewController ()<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic) UIPickerView *stationPicker;
@property (nonatomic) NSMutableArray *stationListArray;
@property (nonatomic) NSMutableArray *stationNameArray;
@property (nonatomic) NSMutableArray *stationAbbrArray;
@end

@implementation SchedueInformationViewController
@synthesize DateLabel,AfterLabel,SchednumLabel,DepartTextField,TimeLabel,BeforeLabel,ArriveTextField;

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.DepartTextField resignFirstResponder];
    [self.ArriveTextField resignFirstResponder];
}

-(IBAction)getScheduleInformation:(id)sender{
    NSString *Depart = [self.stationAbbrArray objectAtIndex:[self.stationNameArray indexOfObject:DepartTextField.text]];
    NSString *Arrive = [self.stationAbbrArray objectAtIndex:[self.stationNameArray indexOfObject:ArriveTextField.text]];
    
    NSString *httpUrlString = [NSString stringWithFormat:@"%@%@cmd=%@&orig=%@&dest=%@&date=now&key=%@&b=2&a=2&l=1",SERVER_API_ADDRESS, SCHEDULE_API, @"arrive", Depart, Arrive, API_KEY];
    NSLog(@"%@",httpUrlString);
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:httpUrlString]] queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (Nil == error) {
            NSDictionary *dic = [NSDictionary dictionaryWithXMLData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"the data is %@",dic);
                self.SchednumLabel.text = [dic objectForKey:@"sched_num"];
                self.DateLabel.text = [[dic objectForKey:@"schedule"] objectForKey:@"date"];
                self.TimeLabel.text = dic[@"schedule"][@"request"][@"trip"][0][@"_destTimeMin"];
                self.BeforeLabel.text = [[dic objectForKey:@"schedule"] objectForKey:@"before"];
                self.AfterLabel.text = [[dic objectForKey:@"schedule"] objectForKey:@"after"];
                [self.view setNeedsDisplay];
            });
        }
    }];
}

- (void)getStationList
{
    NSString *httpUrlString = [NSString stringWithFormat:@"%@%@cmd=%@&key=%@",SERVER_API_ADDRESS,STATION_API,@"stns",API_KEY];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:httpUrlString]] queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
        if (nil == error) {
            NSDictionary *dic = [NSDictionary dictionaryWithXMLData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.stationListArray = [[dic objectForKey:@"stations"]objectForKey:@"station"];
                NSLog(@"station %@",self.stationListArray);
                self.stationNameArray = [self.stationListArray valueForKeyPath:@"name"];
                self.stationAbbrArray = [self.stationListArray valueForKeyPath:@"abbr"];
                NSLog(@"%@",self.stationNameArray);
                [self.stationPicker reloadAllComponents];
            });
        }
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self getStationList];
   // [self test];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - datasource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.stationNameArray count];
}
#pragma mark - delegate
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.stationNameArray objectAtIndex:row];
}

- (IBAction)departPicker:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:nil
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    
    pickerView.showsSelectionIndicator = YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    [actionSheet addSubview:pickerView];
    self.stationPicker = pickerView;
    
    UISegmentedControl *okButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"OK"]];
    okButton.momentary = YES;
    okButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
    okButton.tintColor = [UIColor blackColor];
    [okButton addTarget:self action:@selector(departActionSheet:) forControlEvents:UIControlEventValueChanged];
    [actionSheet addSubview:okButton];
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    
    [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
}

- (void)departActionSheet:(UISegmentedControl*)sender{
    UIActionSheet *actionSheet = (UIActionSheet *)[sender superview];
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
    NSInteger row = [self.stationPicker selectedRowInComponent:0];
    DepartTextField.text = [self.stationNameArray objectAtIndex:row];
}

- (IBAction)arrivePicker:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:nil
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    
    pickerView.showsSelectionIndicator = YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    [actionSheet addSubview:pickerView];
    self.stationPicker = pickerView;
    
    UISegmentedControl *okButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"OK"]];
    okButton.momentary = YES;
    okButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
    okButton.tintColor = [UIColor blackColor];
    [okButton addTarget:self action:@selector(arriveActionSheet:) forControlEvents:UIControlEventValueChanged];
    [actionSheet addSubview:okButton];
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    
    [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
}

- (void)arriveActionSheet:(UISegmentedControl*)sender{
    UIActionSheet *actionSheet = (UIActionSheet *)[sender superview];
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
    NSInteger row = [self.stationPicker selectedRowInComponent:0];
    ArriveTextField.text = [self.stationNameArray objectAtIndex:row];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
}

-(NSString *)test{
    NSDictionary *dic = [[NSDictionary alloc]init];
    NSString *hello = [dic hello];
   // NSLog(@"hello is %@",hello);
    return hello;
    
}
-(NSString *)test2{
    return @"helloworld";
}
@end















