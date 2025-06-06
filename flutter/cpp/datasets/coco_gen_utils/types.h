/* Copyright 2024 The MLPerf Authors. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
==============================================================================*/
#ifndef MLPERF_DATASETS_COCO_GEN_UTILS_TYPES_H_
#define MLPERF_DATASETS_COCO_GEN_UTILS_TYPES_H_

#include "tensorflow/core/example/example.pb.h"
#include "tensorflow/core/example/feature_util.h"
#include "tensorflow/core/platform/types.h"

namespace mlperf {
namespace mobile {

// CaptionRecord is equivalent to records in the ground truth tfrecord file.
struct CaptionRecord {
  explicit CaptionRecord(const tensorflow::tstring& record) {
    using string = std::string;
    tensorflow::Example example;
    example.ParseFromString(record);

    auto caption_id_list =
        tensorflow::GetFeatureValues<int64_t>("caption_id", example);
    caption_id =
        std::vector<int32_t>(caption_id_list.begin(), caption_id_list.end())[0];

    auto caption_list =
        tensorflow::GetFeatureValues<string>("caption", example);
    caption_text =
        std::vector<std::string>(caption_list.begin(), caption_list.end());

    auto input_id_list =
        tensorflow::GetFeatureValues<int64_t>("input_ids", example);
    input_ids =
        std::vector<int32_t>(input_id_list.begin(), input_id_list.end());

    auto attention_mask_list =
        tensorflow::GetFeatureValues<int64_t>("attention_mask", example);
    attention_mask = std::vector<int32_t>(attention_mask_list.begin(),
                                          attention_mask_list.end());

    auto filename_list =
        tensorflow::GetFeatureValues<string>("file_name", example);
    filename =
        std::vector<std::string>(filename_list.begin(), filename_list.end());

    auto clip_score_list =
        tensorflow::GetFeatureValues<float>("clip_score", example);
    clip_score =
        std::vector<float>(clip_score_list.begin(), clip_score_list.end())[0];
  }

  void dump() {
    std::cout << "CaptionRecord:\n";
    std::cout << "  caption_id: " << get_caption_id() << "\n";
    std::cout << "  caption_text: " << get_caption_text() << "\n";
    std::cout << "  input_ids: ";
    for (size_t i = 0; i < input_ids.size(); ++i) {
      std::cout << input_ids[i];
      if (i != input_ids.size() - 1) {
        std::cout << ", ";
      } else {
        std::cout << "\n";
      }
    }
    std::cout << "  attention_mask: ";
    for (size_t i = 0; i < attention_mask.size(); ++i) {
      std::cout << attention_mask[i];
      if (i != attention_mask.size() - 1) {
        std::cout << ", ";
      } else {
        std::cout << "\n";
      }
    }
    std::cout << "  file_name: " << get_filename() << "\n";
    std::cout << "  clip_score: " << clip_score << "\n";
  }

  int get_caption_id() const { return caption_id; }
  std::string get_caption_text() const { return caption_text[0]; }
  std::string get_filename() const { return filename[0]; }
  int32_t* get_input_ids() { return input_ids.data(); }
  int32_t* get_attention_mask() { return attention_mask.data(); }
  std::vector<int32_t> get_input_ids_vector() { return input_ids; }
  std::vector<int32_t> get_attention_mask_vector() { return attention_mask; }

 private:
  int caption_id;
  std::vector<std::string> caption_text;
  std::vector<int32_t> input_ids;
  std::vector<int32_t> attention_mask;
  std::vector<std::string> filename;
  float clip_score;
};

}  // namespace mobile
}  // namespace mlperf

#endif  // MLPERF_DATASETS_COCO_GEN_UTILS_TYPES_H_
