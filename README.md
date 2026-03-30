# Brain Tumor Segmentation using U-Net

This project implements a deep learning pipeline for brain tumor segmentation using MRI scans from the BraTS dataset. A custom 2D U-Net is trained to perform multi-class semantic segmentation across four MRI modalities.

The implementation is designed to be run primarily on Google Colab (Pro) with GPU acceleration (NVIDIA A100).

---

## Overview

The goal is to segment brain tumors into clinically relevant regions:

- Edema  
- Non-enhancing tumor  
- Enhancing tumor  

Performance is evaluated using clinically relevant composite tumor regions. See the Dataset section for information on the labels.
- Enhancing Tumor (ET): Label 4
- Tumor Core (TC): Labels 1 and 4
- Whole Tumor (WT): Labels 1, 2, and 4

The model is trained on multi-modal MRI scans and evaluated using standard segmentation metrics including Dice score and Hausdorff distance.

---

## Dataset

This project uses the BraTS (Brain Tumor Segmentation) dataset, specifically the Task01_BrainTumour dataset.

Download dataset:

https://msd-for-monai.s3-us-west-2.amazonaws.com/Task01_BrainTumour.tar  

Each MRI volume includes four modalities:

```json
{
  "0": "FLAIR",
  "1": "T1w",
  "2": "T1gd",
  "3": "T2w"
}
```

Modalities:

- FLAIR: highlights lesions  
- T1w: anatomical structure  
- T1gd: contrast-enhanced tumor regions  
- T2w: edema regions  

Labels:
```json
{
  "0": "background",
  "1": "edema",
  "2": "non-enhancing tumor",
  "3": "enhancing tumor"
}
```

---

## Model Architecture

A custom 2D U-Net is implemented from scratch:

- Encoder-decoder structure  
- Skip connections  
- Convolution blocks (Conv → ReLU → Conv → ReLU)  
- Final 4-class output layer  

The model operates on 2D slices extracted from 3D MRI volumes.

---

## Training Strategy

- Cross-validation: 5-fold KFold  
- Loss: Hybrid (Cross-Entropy + Dice)  
- Optimizer: Adam  
- Learning rate: 1e-4  
- Batch size: 16  
- Epochs: 2 per fold  
- Mixed precision training  
- cuDNN benchmarking enabled  

---

## Data Handling

- MRI volumes loaded using nibabel  
- Sliced into 2D samples  
- Custom Dataset with caching  
- Normalization applied per slice  

---

## Evaluation Metrics

- Dice Score  
- Hausdorff Distance (95th percentile)  

Regions evaluated:

- ET (Enhancing Tumor)  
- TC (Tumor Core)  
- WT (Whole Tumor)  

---

## Results

| Fold   | Dice (ET) | Dice (TC) | Dice (WT) |
|--------|----------|----------|----------|
| Fold 1 | 0.7691   | 0.7175   | 0.6425   |
| Fold 2 | 0.7732   | 0.7258   | 0.6690   |
| Fold 3 | 0.7732   | 0.7340   | 0.6121   |
| Fold 4 | 0.7753   | 0.7278   | 0.6165   |
| Fold 5 | 0.7562   | 0.7063   | 0.6064   |

| Metric           | Value   |
|------------------|--------|
| Dice (ET) Avg    | 0.7694 |
| Dice (TC) Avg    | 0.7223 |
| Dice (WT) Avg    | 0.6293 |
| Hausdorff (WT)   | 5.9337 | 

---

## Visualization

MRI slices are visualized with segmentation overlays across all modalities.

---

## Future Improvements

- 3D U-Net  
- MONAI integration  
- More epochs  
- Data augmentation  
- Attention mechanisms  

---

## License

MIT License