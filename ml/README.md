# ML Workspace

This folder contains the future ML pipeline for the stock simulator.

## Goal

Use ML as an enhancement for:

- stock trend prediction
- buy/hold/sell recommendation scoring
- portfolio risk analysis
- sector-level momentum hints

## Recommended First Feature

Start with one simple feature only:

- `trend prediction` for the next session

Suggested output shape:

```json
{
  "symbol": "RELIANCE",
  "prediction": "UP",
  "confidence": 0.74,
  "risk_score": 0.31,
  "source": "baseline-model"
}
```

## Folder Structure

```text
ml/
├── datasets/
├── models/
├── notebooks/
├── scripts/
├── requirements.txt
└── README.md
```

## Phase 1 Plan

1. Generate or collect a tabular dataset for Indian stocks.
2. Train a very small baseline classifier in `scripts/train_baseline_model.py`.
3. Save the trained artifact inside `ml/models/`.
4. Point Django `ML_MODE` to `model`.
5. Let Flutter read prediction/recommendation output through Django only.

## Safe Fallback

If you do not have time to finish real ML:

- keep Django `ML_MODE = "rule_based"`
- use rule-based predictions and recommendations
- still expose the same API shape to Flutter

That means the frontend does not care whether the insight came from:

- a trained model
- a rule-based engine
- a temporary mock

## Recommended Tools

Best for your setup:

- Google Colab for experimentation and training
- local Python environment for lightweight scripts
- Django only loads the saved model artifact later

Anaconda is optional if your stronger machine can handle it.

## Files To Use

- [scripts/generate_sample_dataset.py](d:\stock_simulator\ml\scripts\generate_sample_dataset.py)
- [scripts/train_baseline_model.py](d:\stock_simulator\ml\scripts\train_baseline_model.py)
- [requirements.txt](d:\stock_simulator\ml\requirements.txt)
