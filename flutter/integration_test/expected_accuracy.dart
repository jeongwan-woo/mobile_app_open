import 'package:mlperfbench/app_constants.dart';

import 'utils.dart';

/*
value: Interval of expected accuracy
key: <accelerator> OR <accelerator>|<backendName>
- cpu -> Windows
- npu -> Android TFLite
- tpu -> Android Pixel
- ane -> iOS TFLite or Core ML
- cpu&gpu&ane -> iOS Core ML
- snpe_dsp -> Android QTI
- psnpe_dsp -> Android QTI
- neuron-mdla > Android MediaTek
- neuron > Android MediaTek
- samsung_npu > Android Samsung
*/

const Map<String, Interval> _imageClassificationV2 = {
  'cpu': Interval(min: 0.82, max: 0.84),
  'npu': Interval(min: 0.80, max: 0.82),
  'tpu': Interval(min: 0.82, max: 0.84),
  'ane': Interval(min: 0.69, max: 0.91),
  'cpu&gpu&ane': Interval(min: 0.69, max: 0.91),
  'snpe_dsp': Interval(min: 0.83, max: 0.85),
  'psnpe_dsp': Interval(min: 0.83, max: 0.85),
  'neuron-mdla': Interval(min: 0.81, max: 0.83),
  'samsung_npu': Interval(min: 0.83, max: 0.85),
};

const Map<String, Interval> _imageClassificationOfflineV2 = {
  'cpu': Interval(min: 0.88, max: 0.91),
  'npu': Interval(min: 0.69, max: 0.71),
  'tpu': Interval(min: 0.89, max: 0.91),
  'ane': Interval(min: 0.69, max: 0.91),
  'cpu&gpu&ane': Interval(min: 0.69, max: 0.91),
  'snpe_dsp': Interval(min: 0.88, max: 0.91),
  'psnpe_dsp': Interval(min: 0.89, max: 0.91),
  'neuron-mdla': Interval(min: 0.79, max: 0.81),
  'samsung_npu': Interval(min: 0.98, max: 1.0),
};

const Map<String, Interval> _objectDetection = {
  'cpu': Interval(min: 0.31, max: 0.32),
  'npu': Interval(min: 0.28, max: 0.31),
  'tpu': Interval(min: 0.36, max: 0.38),
  'ane|TFLite': Interval(min: 0.31, max: 0.34),
  'ane|Core ML': Interval(min: 0.45, max: 0.46),
  'cpu&gpu&ane': Interval(min: 0.45, max: 0.46),
  'snpe_dsp': Interval(min: 0.34, max: 0.35),
  'psnpe_dsp': Interval(min: 0.34, max: 0.35),
  'neuron': Interval(min: 0.28, max: 0.35),
  'samsung_npu': Interval(min: 0.36, max: 0.39),
};

const Map<String, Interval> _imageSegmentationV2 = {
  'cpu': Interval(min: 0.38, max: 0.40),
  'npu': Interval(min: 0.33, max: 0.34),
  'tpu': Interval(min: 0.33, max: 0.34),
  'ane|TFLite': Interval(min: 0.38, max: 0.40),
  'ane|Core ML': Interval(min: 0.38, max: 0.40),
  'cpu&gpu&ane': Interval(min: 0.38, max: 0.40),
  'snpe_dsp': Interval(min: 0.36, max: 0.37),
  'psnpe_dsp': Interval(min: 0.36, max: 0.37),
  'neuron': Interval(min: 0.32, max: 0.34),
  'samsung_npu': Interval(min: 0.36, max: 0.39),
};

const Map<String, Interval> _naturalLanguageProcessing = {
  'cpu': Interval(min: 1.00, max: 1.00),
  'tpu': Interval(min: 1.00, max: 1.00),
  'gpu|TFLite': Interval(min: 1.00, max: 1.00),
  // 1.00 in simulator, 0.80 on iphone 12 mini
  'gpu|Core ML': Interval(min: 0.80, max: 1.00),
  'cpu&gpu&ane': Interval(min: 0.80, max: 1.00),
  'snpe_dsp': Interval(min: 1.00, max: 1.00),
  'psnpe_dsp': Interval(min: 1.00, max: 1.00),
  'neuron-no-ahwb': Interval(min: 1.00, max: 1.00),
  'samsung_npu': Interval(min: 1.00, max: 1.00),
};

const Map<String, Interval> _superResolution = {
  'cpu': Interval(min: 0.32, max: 0.35),
  'npu': Interval(min: 0.32, max: 0.35),
  'tpu': Interval(min: 0.32, max: 0.35),
  'ane|TFLite': Interval(min: 0.32, max: 0.35),
  'ane|Core ML': Interval(min: 0.32, max: 0.35),
  'cpu&gpu&ane': Interval(min: 0.32, max: 0.35),
  'snpe_dsp': Interval(min: 0.33, max: 0.34),
  'psnpe_dsp': Interval(min: 0.33, max: 0.34),
  'neuron': Interval(min: 0.32, max: 0.35),
  'samsung_npu': Interval(min: 0.08, max: 0.12),
};

// TODO (anhappdev): update expected accuracy for stable diffusion
const Map<String, Interval> _stableDiffusion = {
  'cpu': Interval(min: 0, max: 1.0),
  'npu': Interval(min: 0, max: 1.0),
  'tpu': Interval(min: 0, max: 1.0),
  'ane|TFLite': Interval(min: 0, max: 1.0),
  'ane|Core ML': Interval(min: 0, max: 1.0),
  'cpu&gpu&ane': Interval(min: 0, max: 1.0),
  'snpe_dsp': Interval(min: 0, max: 1.0),
  'psnpe_dsp': Interval(min: 0, max: 1.0),
  'neuron': Interval(min: 0, max: 1.0),
  'samsung_npu': Interval(min: 0, max: 1.0),
};

const benchmarkExpectedAccuracy = {
  BenchmarkId.imageClassificationV2: _imageClassificationV2,
  BenchmarkId.objectDetection: _objectDetection,
  BenchmarkId.imageSegmentationV2: _imageSegmentationV2,
  BenchmarkId.naturalLanguageProcessing: _naturalLanguageProcessing,
  BenchmarkId.superResolution: _superResolution,
  BenchmarkId.stableDiffusion: _stableDiffusion,
  BenchmarkId.imageClassificationOfflineV2: _imageClassificationOfflineV2,
};
