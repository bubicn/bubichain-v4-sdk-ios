//
//  GasServiceImpl.h
//  sdk-ios
//
//  Created by dxl on 2018/8/12.
//  Copyright © 2018 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GasSendOperation.h"
#import "Chain.pbobjc.h"

@interface GasServiceImpl : NSObject
/**
 Send gas to other account that is in bubi chain
 
 @param gasSendOperation
            sourceAddress(NSString *) : The account who will make this sending gas operation
            destAddress(NSString *) : The account who will receive the gas
            amount(int64_t) : The gas amount
            metadata(NSString *) : Notes
 
 @param transSourceAddress : The source account who will start the transaction
 @return Operation *
 */
+ (Operation *) send : (GasSendOperation *) gasSendOperation : (NSString *) transSourceAddress;
@end
