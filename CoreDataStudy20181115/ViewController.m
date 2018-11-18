//
//  ViewController.m
//  CoreDataStudy20181115
//
//  Created by 684lhz on 2018/11/15.
//  Copyright © 2018年 684lhz. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"
#import <CoreData/CoreData.h>
#import "Student.h"

@interface ViewController (){
    NSManagedObjectContext * _content;
}

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *ageTF;
@property (weak, nonatomic) IBOutlet UITextField *heightTF;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

/** <#注释#>*/
@property (nonatomic, strong) NSMutableArray * resultArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //1、创建模型文件（相当于数据库中的表）
    //2、创建实体类
    //3、创建上下文
    
    NSManagedObjectContext * content = [[NSManagedObjectContext alloc] initWithConcurrencyType:(NSMainQueueConcurrencyType)];
    
    //持久化存储协调器： 调度器
    //将数据从内存转移到硬盘
    //nil 默认为 mainBundle
    NSManagedObjectModel * model = [NSManagedObjectModel mergedModelFromBundles:nil];
    NSPersistentStoreCoordinator * store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    
    //告知coreData 数据库名称和路径
    //yes 绝对路径  NO 相对路径
    NSString * doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES ) lastObject];
    
    NSString * sqlPath = [doc stringByAppendingPathComponent:@"MyTable.db"];
    NSLog(@"%@",sqlPath);
    //
    
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:sqlPath] options:nil error:nil];
    content.persistentStoreCoordinator = store;
    
    _content = content;
    
    [self addStudent];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/** 增加 */
- (void)addStudent {
    Student * student = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:_content];
    student.name = @"小刘";
    student.height = @1.80;
    student.age = @22;
    NSError * error = nil;
    [_content save:&error];
    if (error) {
        NSLog(@"%@", error);
    }
    
}

/** 删除 */
- (void)deleteStudent {
    
    //请求
    NSFetchRequest * req = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    //请求条件
    NSPredicate * pre = [NSPredicate predicateWithFormat:@"age <= 20"];
    req.predicate  = pre;
    //发送请求
    NSArray * array = [_content executeFetchRequest:req error:nil];
    
    for (Student * stu in array) {
        [_content deleteObject:stu];
    }
    
    NSError * error = nil;
    [_content save:&error];
    if (error) {
        NSLog(@"%@", error);
    }
}

/** 添加 */
- (IBAction)addBtnAction:(id)sender {
    NSString * name = self.nameTF.text;
    NSNumber * age = @(self.ageTF.text.integerValue);
    NSNumber * height = @(self.heightTF.text.floatValue);
    
    Student * stu = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:_content];
    stu.name = name;
    stu.age = age;
    stu.height = height;
    
    NSError * error = nil;
    [_content save:&error];
    if (error) {
        NSLog(@"%@", error);
    }
}

/** 条件查询 */
- (IBAction)searchBtnAction:(id)sender {
    
    NSString * name = self.nameTF.text;
    //    NSInteger age = self.ageTF.text.integerValue;
    //    float  height = self.heightTF.text.floatValue;
    
    NSString * preStr = @"";
    if (name.length > 0) {
        preStr = [NSString stringWithFormat:@"name = '%@'", name];
    }
    
    NSFetchRequest * req = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    NSPredicate * pre = [NSPredicate predicateWithFormat:preStr];
    req.predicate = pre;
    NSArray * result = [_content executeFetchRequest:req error:nil];
    self.resultArray = [NSMutableArray arrayWithArray:result];
    
    NSString * resultStr = @"";
    for (Student * stu in self.resultArray) {
        resultStr = [NSString stringWithFormat:@"%@\n%@,%@,%@", resultStr, stu.name, stu.age, stu.height];
    }
    
    NSAttributedString * attributeStr = [[NSAttributedString alloc] initWithString:resultStr];
    self.resultLabel.attributedText = attributeStr;
}

- (IBAction)searchAllBtnAction:(id)sender {
    [self searchAll];
}

/** 查询全部 */
- (void)searchAll {
    NSEntityDescription * entityDes = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:_content];
    
    NSFetchRequest * req = [[NSFetchRequest alloc] init];
    [req setEntity:entityDes];
    
    NSArray * result = [_content executeFetchRequest:req error:nil];
    
    NSString * resultStr = @"";
    for (Student * stu in result) {
        resultStr = [NSString stringWithFormat:@"%@\n%@,%@,%@", resultStr, stu.name, stu.age, stu.height];
    }
    NSAttributedString * attributeStr = [[NSAttributedString alloc] initWithString:resultStr];
    self.resultLabel.attributedText = attributeStr;
}

- (IBAction)deleteBtnAction:(id)sender {
    
}

- (IBAction)modifyBtnAction:(id)sender {
    
}

@end
