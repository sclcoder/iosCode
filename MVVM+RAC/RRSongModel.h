//
//  RRSongModel.h
//  MVVM+RAC
//
//  Created by sunchunlei on 2022/5/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RRSongModel : NSObject <YYModel>

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;



//"id":346089,
//"name":"海阔天空",
//"artists":[],
//"album":{},
//"duration":322560,
//"copyrightId":7002,
//"status":0,
//"alias":[],
//"rtype":0,
//"ftype":0,
//"transNames":[],
//"mvid":376199,
//"fee":8,
//"rUrl":null,
//"mark":0

@end

NS_ASSUME_NONNULL_END
