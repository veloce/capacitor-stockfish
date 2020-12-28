#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>
#import "StockfishSendOutput.h"

@protocol StockfishBridge <NSObject>

- (instancetype)initWithPlugin:(CAPPlugin *)plugin;
- (void) start;
- (void) cmd: (NSString*)command;
- (void) exit;

@end

@interface StockfishBridge:NSObject <StockfishBridge>

@property(strong, nonatomic) CAPPlugin *plugin;

@end

@interface StockfishVariantsBridge:NSObject <StockfishBridge>

@property(strong, nonatomic) CAPPlugin *plugin;

@end
