//
//  Student+CoreDataProperties.h
//  CoreDataStudy20181115
//
//  Created by 684lhz on 2018/11/15.
//  Copyright © 2018年 684lhz. All rights reserved.
//
//

#import "Student+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int16_t age;
@property (nonatomic) float height;

@end

NS_ASSUME_NONNULL_END
