#import <VisionCamera/FrameProcessorPlugin.h>
#import <VisionCamera/Frame.h>
#import <MLKit.h>


@interface ImageLabelerPlugin : NSObject

+ (MLKImageLabeler*) labeler;

@end

@implementation ImageLabelerPlugin

+ (MLKImageLabeler*) labeler {
  static MLKImageLabeler* labeler = nil;
  if (labeler == nil) {
    MLKImageLabelerOptions *options = [[MLKImageLabelerOptions alloc] init];
    labeler = [MLKImageLabeler imageLabelerWithOptions:options];
    
  }
  return labeler;
}

static inline id imageLabeler(Frame* frame, NSArray* arguments) {
  MLKVisionImage *image = [[MLKVisionImage alloc] initWithBuffer:frame.buffer];
  image.orientation = frame.orientation; // <-- TODO: is mirrored?

  NSError* error;
  NSArray<MLKImageLabel*>* labels = [[ImageLabelerPlugin labeler] resultsInImage:image error:&error];

  NSMutableArray* results = [NSMutableArray arrayWithCapacity:labels.count];
  for (MLKImageLabel* label in labels) {
    [results addObject:@{
      @"label": label.text,
      @"confidence": [NSNumber numberWithFloat:label.confidence]
    }];
  }

  return results;
}


VISION_EXPORT_FRAME_PROCESSOR(imageLabeler)

@end
