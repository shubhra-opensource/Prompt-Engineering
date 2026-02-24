# LLM as a Judge: Machine Translation Evaluation Project

## Project Overview

This project evaluates the quality of machine translations using Large Language Models (LLMs) as judges. The workflow consists of two main phases:

1. **Translation Generation**: Uses Facebook's NLLB-200 translation model to translate sentences from English and French into 14 target languages (Japanese, Mandarin, Korean, Hindi, Danish, Dutch, Finnish, German, Greek, Italian, Polish, Portuguese, Spanish, and Swedish).

2. **Translation Evaluation**: Uses Qwen3 LLM models (4B or 8B parameters) to automatically evaluate and score the quality of each translation on a scale of 1-10.

### What Problem Does This Solve?

Evaluating translation quality traditionally requires human experts, which is expensive, time-consuming, and difficult to scale. This project automates the evaluation process by using LLMs as judges, allowing for:
- **Scalable evaluation** of thousands of translations
- **Consistent scoring** across different language pairs
- **Cost-effective** automated quality assessment
- **Comparison** of translation quality from different source languages (English vs French)

### Data Used

- **Input Data**: `data/df.csv` - A CSV file containing multilingual sentences with the following columns:
  - `id`: Unique identifier for each sentence
  - `iso_639_3`: Language code (e.g., "eng" for English, "fra" for French)
  - `iso_15924`: Script code (e.g., "Latn" for Latin script)
  - `text`: The actual sentence text in that language

- **Output Data**: CSV files stored in the `results/` folder containing:
  - Translation pairs (original text + translated text)
  - Evaluation scores (mean scores per language pair)

### Outputs Generated

The project generates:
- **Translation CSV files**: Two files containing all translations (one for English sources, one for French sources)
- **Evaluation results CSV files**: Mean quality scores (1-10 scale) for each language pair
- **Console output**: Progress bars and real-time evaluation results

---

## Repository Structure

```
LLM as a Judge/
│
├── data/
│   └── df.csv                    # Input dataset with multilingual sentences
│
├── results/                       # Output folder (created automatically)
│   ├── english_translations.csv  # English → all target languages translations
│   ├── french_translations.csv   # French → all target languages translations
│   ├── qwen3_4b_llm_judge_results.csv  # Evaluation scores from 4B model
│   └── qwen3_8b_llm_judge_results.csv  # Evaluation scores from 8B model
│
├── 1_Dataset Creator LLM as a Judge.ipynb
│   └── Purpose: Creates translation dataset
│       - Loads multilingual sentences from data/df.csv
│       - Filters to aligned English and French sentences
│       - Translates from English and French to 14 target languages using NLLB model
│       - Saves translations to results/english_translations.csv and results/french_translations.csv
│
├── 2_Eval LLM as a Judge_20samp_qwen3_4b.ipynb
│   └── Purpose: Evaluates translations using Qwen3 4B model
│       - Loads translation CSV files from results/ folder
│       - Uses Qwen3 4B model (via Ollama) to score each translation (1-10 scale)
│       - Samples 20 translations per language pair for evaluation
│       - Saves mean scores to results/qwen3_4b_llm_judge_results.csv
│
└── 3_Eval LLM as a Judge_5samp_qwen3_8b.ipynb
    └── Purpose: Evaluates translations using Qwen3 8B model
        - Same workflow as notebook 2, but uses Qwen3 8B model
        - Samples 5 translations per language pair (faster, but less samples)
        - Saves mean scores to results/qwen3_8b_llm_judge_results.csv
```

### Folder Descriptions

- **`data/`**: Contains the input dataset (`df.csv`) with multilingual sentences. This is the starting point for the project.

- **`results/`**: Created automatically when you run the notebooks. Contains all output files:
  - Translation files with original and translated text pairs
  - Evaluation results with quality scores per language pair



## Outputs and Results

### Translation Files

**Location**: `results/english_translations.csv` and `results/french_translations.csv`

**Structure**: Each file contains columns:
- `source_language`: Source language code (e.g., "eng" or "fra")
- `target_language`: Target language code (e.g., "jpn", "zho", "kor")
- `original_text`: Original sentence in source language
- `translated_text`: Machine-translated sentence in target language

**Example row**:
```csv
source_language,target_language,original_text,translated_text
eng,jpn,"Monday, scientists at Stanford University...","月曜日 スタンフォード大学医学部の科学者たちは..."
```

### Evaluation Results Files

**Location**: 
- `results/qwen3_4b_llm_judge_results.csv` (from notebook 2)
- `results/qwen3_8b_llm_judge_results.csv` (from notebook 3)

**Structure**: Each file contains columns:
- `source_language`: Source language (e.g., "eng" or "fra")
- `target_language`: Target language (e.g., "jpn", "zho")
- `num_samples`: Number of translations evaluated for this pair
- `mean_llm_judge_score`: Average quality score (1-10 scale)

**Example row**:
```csv
source_language,target_language,num_samples,mean_llm_judge_score
eng,dan,20,9.4
fra,jpn,20,8.7
```

**Score Interpretation**:
- **9-10**: Excellent translation (perfect or near-perfect)
- **7-8**: Good translation (minor issues only)
- **5-6**: Fair translation (noticeable issues but mostly accurate)
- **3-4**: Poor translation (clear errors or omissions)
- **1-2**: Unusable translation (major mistranslations)

