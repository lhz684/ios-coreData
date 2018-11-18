//
//  Student.h
//  CoreDataStudy20181115
//
//  Created by 684lhz on 2018/11/15.
//  Copyright © 2018年 684lhz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Student : NSManagedObject

/** <#注释#>*/
@property (nonatomic, copy) NSString * name;
/** <#注释#>*/
@property (nonatomic, strong) NSNumber * age;
/** <#注释#>*/
@property (nonatomic, strong) NSNumber * height;

@end
