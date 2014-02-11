//
//  ViewController.m
//  BARTAPP
//
//  Created by Chao Xu on 14-1-4.
//  Copyright (c) 2014年 Chao Xu. All rights reserved.
//

#import "HomeViewController.h"
#import "ServerAPI.h"
#import "XMLDictionary.h"

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UILabel *LableDate;
@property (weak, nonatomic) IBOutlet UILabel *LableTime;
@property (weak, nonatomic) IBOutlet UILabel *LableTrainCount;
@property (weak, nonatomic) IBOutlet UILabel *LableServices;
@property (weak, nonatomic) IBOutlet UILabel *LableElevatorInfo;
@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self getData];
}

//Advisories			Returns the current BART Service Advisories (BSA).
//Train Count			Returns the current count of trains in service.
//Elevator Information	Returns the current elevator status.
- (void)getData
{
    [self getBSAInfo];
    [self getTrainCount];
    [self getElevatorInfo];
}

- (void)getBSAInfo
{
    NSString *httpUrlString = [NSString stringWithFormat:@"%@%@cmd=%@&key=%@",SERVER_API_ADDRESS,BSA_API,@"bsa",API_KEY];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:httpUrlString]] queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
        if (nil == error) {
            NSDictionary *dic = [NSDictionary dictionaryWithXMLData:data];
//            NSLog(@"dic %@",dic);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.LableDate.text = [dic objectForKey:@"date"];
                self.LableTime.text = [dic objectForKey:@"time"];
                self.LableServices.text = [[dic objectForKey:@"bsa"]objectForKey:@"description"];
                [self.LableServices sizeToFit];
                [self.view setNeedsDisplay];
            });
        }
    }];
}

- (void)getTrainCount
{
    NSString *httpUrlString = [NSString stringWithFormat:@"%@%@cmd=%@&key=%@",SERVER_API_ADDRESS,BSA_API,@"count",API_KEY];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:httpUrlString]] queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
        if (nil == error) {
            NSDictionary *dic = [NSDictionary dictionaryWithXMLData:data];
//            NSLog(@"dic %@",dic);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.LableTrainCount.text = [dic objectForKey:@"traincount"];
                [self.view setNeedsDisplay];
            });
        }
    }];
}

- (void)getElevatorInfo
{
    NSString *httpUrlString = [NSString stringWithFormat:@"%@%@cmd=%@&key=%@",SERVER_API_ADDRESS,BSA_API,@"elev",API_KEY];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:httpUrlString]] queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
        if (nil == error) {
            NSDictionary *dic = [NSDictionary dictionaryWithXMLData:data];
//            NSLog(@"dic %@",dic);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.LableElevatorInfo.text = [[dic objectForKey:@"bsa"]objectForKey:@"description"];
                [self.view setNeedsDisplay];
            });
        }
    }];
}
@end
