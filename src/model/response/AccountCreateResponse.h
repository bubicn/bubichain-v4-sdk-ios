//
//  AccountCreateResponse.h
//  test-sdk-ios
//
//  Created by dxl on 2018/8/1.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseResponse.h"
#import "AccountCreateResult.h"

@interface AccountCreateResponse : NSObject
@property (nonatomic, assign) int32_t errorCode;
@property (nonatomic, copy) NSString *errorDesc;
@property (nonatomic, strong) AccountCreateResult *result;

-(void)buildResponse:(int32_t)errorCode :(AccountCreateResult *)result;
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(AccountCreateResult *)result;
@end
