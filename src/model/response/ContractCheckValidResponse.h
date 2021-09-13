//
//  ContractCheckValidResponse.h
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseResponse.h"
#import "ContractCheckValidResult.h"

@interface ContractCheckValidResponse : NSObject
@property (nonatomic, assign) int32_t errorCode;
@property (nonatomic, copy) NSString *errorDesc;
@property (nonatomic, strong) ContractCheckValidResult *result;

-(void)buildResponse:(int32_t)errorCode :(ContractCheckValidResult *)result;
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(ContractCheckValidResult *)result;
@end
