//
//  Book.h
//  TiMi
//
//  Created by 江滨耀 on 2019/8/21.
//  Copyright © 2019年 江滨耀. All rights reserved.
//

#import <Realm/Realm.h>

@interface Book : RLMObject
@property(nonatomic,copy)NSString *coverImageNameString;
@property(nonatomic,copy)NSString *bookNameString;
@property(nonatomic,assign)BOOL isSelected;

@end
