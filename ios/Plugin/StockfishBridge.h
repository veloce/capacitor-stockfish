#import <Foundation/Foundation.h>


@interface StockfishBridge : NSObject
    - (void) start;
    - (void) cmd: (NSString*)command;
@end
