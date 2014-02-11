//
//  StationInfoDetailViewController.m
//  BARTAPP
//
//  Created by Chao Xu on 14-1-5.
//  Copyright (c) 2014年 Chao Xu. All rights reserved.
//

#import "StationInfoDetailViewController.h"
#import <MapKit/MapKit.h>

@interface StationInfoDetailViewController ()<MKMapViewDelegate>
{
    CLLocationCoordinate2D coordinate;
}
@property (weak, nonatomic) IBOutlet MKMapView *stationMap;
@end

@implementation StationInfoDetailViewController


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
    self.stationMap.mapType = MKMapTypeStandard;
    coordinate.latitude = [[self.stationInfomation objectForKey:@"gtfs_latitude"]floatValue];
    coordinate.longitude = [[self.stationInfomation objectForKey:@"gtfs_longitude"]floatValue];
    [self.stationMap setCenterCoordinate:coordinate];
    [self.stationMap setZoomEnabled:YES];
    [self addPinToMap:nil];
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coordinate, 2000, 2000);
    MKCoordinateRegion adjustedRegion = [self.stationMap regionThatFits:viewRegion];
    [self.stationMap setRegion:adjustedRegion animated:YES];
    self.stationMap.showsUserLocation = YES;
    
    self.navigationController.navigationBarHidden = NO;
    self.title = [self.stationInfomation objectForKey:@"address"];
    
    [self.navigationItem setBackBarButtonItem:[[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(dismissViewController:)]];
    
    self.tabBarController.tabBar.hidden = YES;
}

- (IBAction)dismissViewController:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addPinToMap:(id)sender
{
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    [point setCoordinate:(coordinate)];
    [self.stationMap addAnnotation:point];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
