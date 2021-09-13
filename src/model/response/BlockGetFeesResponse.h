//
//  BlockGetFeesResponse.h
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseResponse.h"
#import "BlockGetFeesResult.h"

@interface BlockGetFeesResponse : NSObject
@property (nonatomic, assign) int32_t errorCode;
@property (nonatomic, copy) NSString *errorDesc;
@property (nonatomic, strong) BlockGetFeesResult *result;

-(void)buildResponse:(int32_t)errorCode :(BlockGetFeesResult *)result;
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(BlockGetFeesResult *)result;
@end
