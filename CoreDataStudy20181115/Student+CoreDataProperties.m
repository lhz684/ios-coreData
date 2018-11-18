//
//  Student+CoreDataProperties.m
//  CoreDataStudy20181115
//
//  Created by 684lhz on 2018/11/15.
//  Copyright © 2018年 684lhz. All rights reserved.
//
//

#import "Student+CoreDataProperties.h"

@implementation Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Student"];
}

@dynamic name;
@dynamic age;
@dynamic height;

@end
