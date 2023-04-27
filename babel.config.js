module.exports = {
  presets: ['module:metro-react-native-babel-preset'],
  plugins: [
    [
      // <-- this
      'react-native-reanimated/plugin',
      {
        // globals: ['__scanCodes'],
        globals: ['__faceLandmarksDetector', '__imageLabeler'],
      },
    ],
  ],
};
