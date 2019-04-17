//
//  BCNetworkRequest.h
//  NetWorkRequestDemo
//
//  Created by 纪宇伟 on 2017/7/5.
//  Copyright © 2017年 jyw. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HTTPRequestType) {
    HTTPRequestTypeGET,
    HTTPRequestTypePOST
};

typedef void(^prepareBlock)();
typedef void(^finishBlock)();
typedef void(^progressBlock)(NSProgress *progress);
typedef void(^requestSuccessBlock) (NSDictionary *json);
typedef void(^requestFailureBlock) (NSError *error,BOOL needCache,NSDictionary *cachedJson);
typedef void(^failureBlock) (NSError *error);


@interface BCNetworkRequest : NSObject

+(void)retrieveJsonUseGETfromURL:(NSString *)url
                      parameters:(NSDictionary *)parameters
                         success:(requestSuccessBlock)success
                         failure:(requestFailureBlock)failure;

+(void)retrieveJsonUsePOSTfromURL:(NSString *)url
                       parameters:(NSDictionary *)parameters
                          success:(requestSuccessBlock)success
                          failure:(requestFailureBlock)failure;



+(void)retrieveJsonWithPrepare:(prepareBlock)prepare
                        finish:(finishBlock)finish
                     needCache:(BOOL)needCache
                   requestType:(HTTPRequestType)type
                       fromURL:(NSString *)url
                    parameters:(NSDictionary *)parameters
                       success:(requestSuccessBlock)success
                       failure:(requestFailureBlock)failure;



+(void)uploadImageWithURL:(NSString *)url
               parameters:(NSDictionary *)parameters
                    image:(UIImage *)image
               isOriginal:(BOOL)original
                  success:(requestSuccessBlock)success
                  failure:(failureBlock)failure;


+(void)uploadMutiImageWithURL:(NSString *)url
                      parameters:(NSDictionary *)parameters
                          images:(NSArray <UIImage *> *)images
                      isOriginal:(BOOL)original
                        progress:(progressBlock)uploadProgress
                         success:(requestSuccessBlock)success
                         failure:(failureBlock)failure;


+(void)uploadFileWithURL:(NSString *)url
              parameters:(NSDictionary *)parameters
                 fileURL:(NSURL *)fileURL
                    name:(NSString *)name
                fileName:(NSString *)fileName
                mimeType:(NSString *)mimeType
                progress:(progressBlock)uploadProgress
                 success:(requestSuccessBlock)success
                 failure:(failureBlock)failure;


+(void)downloadFileWithURL:(NSString *)url
                  progress:(progressBlock)donloadProgress
                   success:(void (^)(NSURLResponse *response, NSURL *filePath))success
                   failure:(failureBlock)failure;


+(void)cancelRequestWithURL:(NSString *)url;

+(void)cancelAllRequest;

@end


@interface NSString (md5)
- (NSString *) md5;
@end

#import<CommonCrypto/CommonDigest.h>

@implementation NSString (md5)

- (NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr),result);
    NSMutableString *md5Str =[NSMutableString string];
    for (int i = 0; i < 16; i++)
        [md5Str appendFormat:@"%02X", result[i]];
    
    return [md5Str uppercaseString];
}

@end
