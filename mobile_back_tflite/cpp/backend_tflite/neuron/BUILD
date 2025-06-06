load(
    "@org_tensorflow//tensorflow/lite:build_def.bzl",
    "tflite_copts",
    "tflite_jni_binary",
)
load("//flutter/cpp/proto:pbtxt2header.bzl", "pbtxt2header")

pbtxt2header(
    name = "tflite_settings",
    srcs = [
        "backend_settings/tflite_settings_mtk.pbtxt",
        "backend_settings/tflite_settings_mtk_mt6989.pbtxt",
    ],
)

cc_library(
    name = "neuron_delegate",
    srcs = select({
        "@org_tensorflow//tensorflow:android": [
            "@neuron_delegate//neuron/java:libtensorflowlite_neuron_jni.so",
        ],
    }),
    hdrs = select({
        "@org_tensorflow//tensorflow:android": [
            "@neuron_delegate//neuron:APUWareUtilsApi.h",
            "@neuron_delegate//neuron:neuron_delegate.h",
        ],
    }),
)

cc_library(
    name = "tflite_neuron_c",
    srcs = [
        "neuron_backend.cc",
        "//mobile_back_tflite/cpp/backend_tflite:sd_utils.cc",
        "//mobile_back_tflite/cpp/backend_tflite:single_model_pipeline.cc",
        "//mobile_back_tflite/cpp/backend_tflite:stable_diffusion_invoker.cc",
        "//mobile_back_tflite/cpp/backend_tflite:stable_diffusion_pipeline.cc",
        "//mobile_back_tflite/cpp/backend_tflite:tflite_c.cc",
    ],
    hdrs = [
        "APUWareUtilsLib.h",
        "NeuronAdapter.h",
        "NeuronAdapterShim.h",
        "neuron_backend.h",
        "neuron_builder.h",
        "tflite_settings_mtk.h",
        "//mobile_back_tflite/cpp/backend_tflite:pipeline.h",
        "//mobile_back_tflite/cpp/backend_tflite:sd_utils.h",
        "//mobile_back_tflite/cpp/backend_tflite:single_model_pipeline.h",
        "//mobile_back_tflite/cpp/backend_tflite:stable_diffusion_invoker.h",
        "//mobile_back_tflite/cpp/backend_tflite:stable_diffusion_pipeline.h",
        "//mobile_back_tflite/cpp/backend_tflite:tflite_settings_android.h",
        "//mobile_back_tflite/cpp/backend_tflite:tflite_settings_apple.h",
        "//mobile_back_tflite/cpp/backend_tflite:tflite_settings_windows.h",
        "//mobile_back_tflite/cpp/backend_tflite:thread_pool.h",
        "//mobile_back_tflite/cpp/backend_tflite:utils.h",
    ],
    copts = tflite_copts() + [
        "-Iexternal/neuron_delegate",
    ] + select({
        "//flutter/android/commonlibs:use_asan": [
            "-fsanitize=address",
            "-g",
            "-O1",
            "-fno-omit-frame-pointer",
        ],
        "//conditions:default": [],
    }),
    local_defines = ["MTK_TFLITE_NEURON_BACKEND"],
    deps = [
        ":tflite_settings",
        "//flutter/cpp:utils",
        "//flutter/cpp/c:headers",
        "//mobile_back_tflite/cpp/backend_tflite:embedding_utils",
        "//mobile_back_tflite/cpp/backend_tflite:tflite_settings",
        "@org_tensorflow//tensorflow/core:tflite_portable_logging",
        "@org_tensorflow//tensorflow/lite/c:c_api",
        "@org_tensorflow//tensorflow/lite/c:common",
    ] + select({
        "@org_tensorflow//tensorflow:android": [
            ":neuron_delegate",
            "@org_tensorflow//tensorflow/lite/delegates/gpu:delegate",
        ],
        "//conditions:default": [],
    }),
    alwayslink = 1,
)

tflite_jni_binary(
    name = "libtfliteneuronbackend.so",
    linkscript = "//flutter/cpp/c:version_script.lds",
    deps = [
        ":tflite_neuron_c",
    ],
)

aar_import(
    name = "tflite_neuron_aar",
    aar = "neuron/tensorflow-lite-neuron.aar",
)
