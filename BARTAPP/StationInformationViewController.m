//
//  StationInformationViewController.m
//  BARTAPP
//
//  Created by Chao Xu on 14-1-5.
//  Copyright (c) 2014年 Chao Xu. All rights reserved.
//

#import "StationInformationViewController.h"
#import "ServerAPI.h"
#import "XMLDictionary.h"
#import "StationListCell.h"


@interface StationInformationViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic)NSMutableArray *stationListArray;
@property (weak, nonatomic) IBOutlet UITableView *stationTableview;
@end

@implementation StationInformationViewController


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
//    CGSize size = CGSizeMake(320, );
//    [self.stationTableview ];
    self.stationTableview.frame = CGRectMake(0,IS_GREATER_IOS_7?64:44,320,SCREENHEIGHT - self.tabBarController.tabBar.frame.size.height - (IS_GREATER_IOS_7?20+44:44));
    NSLog(@"%f",self.stationTableview.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    [self getStationList];
}

- (void)getStationList
{
    NSString *httpUrlString = [NSString stringWithFormat:@"%@%@cmd=%@&key=%@",SERVER_API_ADDRESS,STATION_API,@"stns",API_KEY];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:httpUrlString]] queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
        if (nil == error) {
            NSDictionary *dic = [NSDictionary dictionaryWithXMLData:data];
//            NSLog(@"list of station: %@",dic);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.stationListArray = [[dic objectForKey:@"stations"]objectForKey:@"station"];
                NSLog(@"station %@",self.stationListArray);
                [self.stationTableview reloadData];
            });
        }
    }];
}

- (void)getStationInfomation:(NSString *)station
{
    NSString *httpUrlString = [NSString stringWithFormat:@"%@%@cmd=%@&orig=%@&key=%@", SERVER_API_ADDRESS, STATION_API, @"stninfo", station, API_KEY];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:httpUrlString]] queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
        if (nil == error) {
            NSString *resultString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"result station info:%@",resultString);
        }
    }];
}

- (void)getAccessInfomation:(NSString *)station
{
    NSString *httpUrlString = [NSString stringWithFormat:@"%@%@cmd=%@&%@&key=%@", SERVER_API_ADDRESS, STATION_API, @"stnaccess", station, API_KEY];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:httpUrlString]] queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
        if (nil == error) {
            NSString *resultString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"result access info:%@",resultString);
        }
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.stationListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"station";
    StationListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[StationListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
//    cell.addressLable.text = [NSString stringWithFormat:@"%@, %@", [[self.stationListArray objectAtIndex:indexPath.row]objectForKey:@"address"],[[self.stationListArray objectAtIndex:indexPath.row]objectForKey:@"city"]];
    cell.addressLable.text = [NSString stringWithFormat:@"%@",[[self.stationListArray objectAtIndex:indexPath.row]objectForKey:@"name"]];
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    NSLog(@"cell info:%@",[self.stationListArray objectAtIndex:indexPath.row]);
    StationInfoDetailViewController *detailViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"stationDetail"];
    detailViewController.stationInfomation = [self.stationListArray objectAtIndex:indexPath.row];
//    [self presentViewController:detailViewController animated:YES completion:nil];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}
@end
