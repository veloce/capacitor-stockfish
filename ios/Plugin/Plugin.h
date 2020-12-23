#import <UIKit/UIKit.h>
#import <Capacitor/Capacitor.h>
#import <StockfishSendOutput.h>

//! Project version number for Plugin.
FOUNDATION_EXPORT double PluginVersionNumber;

//! Project version string for Plugin.
FOUNDATION_EXPORT const unsigned char PluginVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <Plugin/PublicHeader.h>

@interface Stockfish : CAPPlugin
    - (void) start:(CAPPluginCall *)call;
    - (void) cmd: (CAPPluginCall *)call;
    - (void) exit: (CAPPluginCall *)call;
@end
