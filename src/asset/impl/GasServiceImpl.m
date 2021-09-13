//
//  GasServiceImpl.m
//  sdk-ios
//
//  Created by dxl on 2018/8/12.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "GasServiceImpl.h"
#import "Tools.h"
#import "General.h"
#import "Constant.h"
#import "Http.h"
#import "SDKError.h"
#import "SDKException.h"

@implementation GasServiceImpl
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
+ (Operation *) send : (GasSendOperation *) gasSendOperation : (NSString *) transSourceAddress {
    if ([Tools isEmpty : gasSendOperation]) {
        @throw [[SDKException alloc] initWithCode : REQUEST_NULL_ERROR];
    }
    NSString *sourceAddress = [gasSendOperation getSourceAddress];
    if (![Tools isEmpty : sourceAddress] && ![Tools isAddressValid : sourceAddress]) {
        @throw [[SDKException alloc] initWithCode : INVALID_SOURCEADDRESS_ERROR];
    }
    NSString *destAddress = [gasSendOperation getDestAddress];
    if (![Tools isAddressValid : destAddress]) {
        @throw [[SDKException alloc] initWithCode : INVALID_DESTADDRESS_ERROR];
    }
    BOOL isNotValid = (![Tools isEmpty : sourceAddress] && [sourceAddress isEqualToString : destAddress]) || [transSourceAddress isEqualToString : destAddress];
    if (isNotValid) {
        @throw [[SDKException alloc] initWithCode : SOURCEADDRESS_EQUAL_DESTADDRESS_ERROR];
    }
    int64_t amount = [gasSendOperation getAmount];
    if (amount < 0) {
        @throw [[SDKException alloc] initWithCode : INVALID_GAS_AMOUNT_ERROR];
    }
    NSString *metadata = [gasSendOperation getMetadata];
    // make operation
    Operation *operation = [Operation message];
    [operation setType : Operation_Type_PayCoin];
    if (![Tools isEmpty : sourceAddress]) {
        [operation setSourceAddress : sourceAddress];
    }
    if (![Tools isEmpty : metadata]) {
        [operation setMetadata : [metadata dataUsingEncoding : NSUTF8StringEncoding]];
    }
    OperationPayCoin *operationPayCoin = [OperationPayCoin message];
    [operationPayCoin setDestAddress : destAddress];
    [operationPayCoin setAmount : amount];
    [operation setPayCoin : operationPayCoin];
    return operation;
}
@end
