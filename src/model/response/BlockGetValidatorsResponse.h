//
//  BlockGetValidatorsResponse.h
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseResponse.h"
#import "BlockGetValidatorsResult.h"

@interface BlockGetValidatorsResponse : NSObject
@property (nonatomic, assign) int32_t errorCode;
@property (nonatomic, copy) NSString *errorDesc;
@property (nonatomic, strong) BlockGetValidatorsResult *result;

-(void)buildResponse:(int32_t)errorCode :(BlockGetValidatorsResult *)result;
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(BlockGetValidatorsResult *)result;
@end
