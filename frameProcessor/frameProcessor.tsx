/* global __example_plugin __example_plugin_swift */
import type { Frame } from 'react-native-vision-camera';

declare let _WORKLET: true | undefined;

export function imageLabeler(frame: Frame): string[] {
  'worklet';
  if (!_WORKLET) throw new Error('imageLabeler must be called from a frame processor!');

  // @ts-expect-error because this function is dynamically injected by VisionCamera
  return __imageLabeler(frame, 'hello!', 'parameter2', true, 42, { test: 0, second: 'test' }, ['another test', 5]);
}


