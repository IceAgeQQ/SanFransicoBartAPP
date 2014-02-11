//
//  ServerAPI.h
//  BARTAPP
//
//  Created by Chao Xu on 14-1-5.
//  Copyright (c) 2014年 Chao Xu. All rights reserved.
//

//all the follow apis is come from http://api.bart.gov/docs/overview/examples.aspx


#define SERVER_API_ADDRESS @"http://api.bart.gov/api/"
#define API_KEY @"EGL2-TMQE-E8ZY-VSBJ"

//Advisory information
//Advisories	        Returns the current BART Service Advisories (BSA).
//Train Count	        Returns the current count of trains in service.
//Elevator Information	Returns the current elevator status.
//Help	                Returns the available API Advisory Information commands.
//Version	            Returns the current API version.
#define BSA_API @"bsa.aspx?"


//Real-Time Information
//Real-Time Estimates			Returns the Estimated Time of Departure (ETD) for the specified station.
//Filtered Real-Time Estimates	Returns the Estimated Time of Departure (ETD) for the specified station limited to a single direction (Northbound or Southbound).
//Help							Returns the available API Real-Time Information commands.
//Version						Returns the current API version.
#define ETD_API @"etd.aspx?"


//Route Information
//Routes	Returns a list of current BART Routes.
//Route 	Information	Returns detailed information about a specific route.
//Help		Returns the available API Route Information commands.
//Version	Returns the current API version.
#define ROUTE_API @"route.aspx?"


//Schedule Information
//QuickPlanner (Arrive)	Returns schedule information based on specified arrive time.
//QuickPlanner (Depart)	Returns schedule information based on specified depart time.
//Fare					Returns the fare information between two stations.
//Holidays				Returns information about upcoming BART holidays.
//Load Factor				Returns a historical estimate of how full the BART trains are for various legs on a trip.
//Route Schedule			Returns a complete schedule for the specified route
//Available Schedules		Returns a list of released BART Schedules and their effective date.
//Special Schedules		Returns any currently active special schedule announcements.
//Station Schedule		Returns a complete schedule for the specified station.
//Help					Returns the available API Schedule Information commands.
//Version					Returns the current API version.
#define SCHEDULE_API @"sched.aspx?"


//Station Information
//Station List	Returns a list of all BART stations.
//Station Information	Returns detailed information about the specified station.
//Station Access Information	Returns information about access to the specified station, along with nearby attractions.
//Help	Returns the available API Station Information commands.
//Version	Returns the current API version.
#define STATION_API @"stn.aspx?"