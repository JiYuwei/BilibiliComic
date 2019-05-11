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

/**
 GET请求

 @param url         请求的URL
 @param parameters  参数
 @param success     成功回调
 @param failure     失败回调
 */
+(void)retrieveJsonUseGETfromURL:(NSString *)url
                      parameters:(NSDictionary *)parameters
                         success:(requestSuccessBlock)success
                         failure:(requestFailureBlock)failure;

/**
 POST请求

 @param url         请求的URL
 @param parameters  参数
 @param success     成功回调
 @param failure     失败回调
 */
+(void)retrieveJsonUsePOSTfromURL:(NSString *)url
                       parameters:(NSDictionary *)parameters
                          success:(requestSuccessBlock)success
                          failure:(requestFailureBlock)failure;

/**
 通用请求

 @param prepare     准备阶段回调
 @param finish      请求完成回调
 @param needCache   是否需要缓存
 @param type        请求类型 GET/POST
 @param url         请求的URL
 @param parameters  参数
 @param success     成功回调
 @param failure     失败回调
 */
+(void)retrieveJsonWithPrepare:(prepareBlock)prepare
                        finish:(finishBlock)finish
                     needCache:(BOOL)needCache
                   requestType:(HTTPRequestType)type
                       fromURL:(NSString *)url
                    parameters:(NSDictionary *)parameters
                       success:(requestSuccessBlock)success
                       failure:(requestFailureBlock)failure;

/**
 上传图片

 @param url         上传图片URL
 @param parameters  参数
 @param image       图片
 @param original    是否上传原图
 @param success     成功回调
 @param failure     失败回调
 */
+(void)uploadImageWithURL:(NSString *)url
               parameters:(NSDictionary *)parameters
                    image:(UIImage *)image
               isOriginal:(BOOL)original
                  success:(requestSuccessBlock)success
                  failure:(failureBlock)failure;

/**
 上传多图

 @param url             上传图片URL
 @param parameters      参数
 @param images          图片数组
 @param original        是否上传原图
 @param uploadProgress  上传进度
 @param success         成功回调
 @param failure         失败回调
 */
+(void)uploadMutiImageWithURL:(NSString *)url
                      parameters:(NSDictionary *)parameters
                          images:(NSArray <UIImage *> *)images
                      isOriginal:(BOOL)original
                        progress:(progressBlock)uploadProgress
                         success:(requestSuccessBlock)success
                         failure:(failureBlock)failure;

/**
 上传文件

 @param url             上传文件URL
 @param parameters      参数
 @param fileURL         文件路径
 @param name            名称
 @param fileName        文件名称
 @param mimeType        媒体类型
 @param uploadProgress  上传进度
 @param success         成功回调
 @param failure         失败回调
 */
+(void)uploadFileWithURL:(NSString *)url
              parameters:(NSDictionary *)parameters
                 fileURL:(NSURL *)fileURL
                    name:(NSString *)name
                fileName:(NSString *)fileName
                mimeType:(NSString *)mimeType
                progress:(progressBlock)uploadProgress
                 success:(requestSuccessBlock)success
                 failure:(failureBlock)failure;

/**
 下载文件

 @param url              下载文件URL
 @param donloadProgress  下载进度
 @param success          成功回调
 @param failure          失败回调
 */
+(void)downloadFileWithURL:(NSString *)url
                  progress:(progressBlock)donloadProgress
                   success:(void (^)(NSURLResponse *response, NSURL *filePath))success
                   failure:(failureBlock)failure;

/**
 取消指定URL的请求

 @param url 需要取消请求的URL
 */
+(void)cancelRequestWithURL:(NSString *)url;

/**
 取消所有请求
 */
+(void)cancelAllRequest;

@end
