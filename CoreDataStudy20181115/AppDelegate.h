//
//  AppDelegate.h
//  CoreDataStudy20181115
//
//  Created by 684lhz on 2018/11/15.
//  Copyright © 2018年 684lhz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

