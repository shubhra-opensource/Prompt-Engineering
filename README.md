# 🚀 Prompt Engineering


## 🎯 Project Overview

This repository provides a comprehensive guide to **prompt engineering** for LLMs, demonstrating various testing methodologies, evaluation techniques, and optimization strategies. The notebook covers topics from basic prompt testing to advanced techniques like Chain-of-Thought reasoning and LLM-as-a-Judge evaluation.

### Key Techniques Demonstrated

- ✅ **Pointwise vs. Pairwise Testing** - Comparing single prompt evaluation vs. comparative analysis
- ✅ **Reference-Based vs. Reference-Free Evaluation** - Ground truth comparison vs. LLM-based assessment
- ✅ **Temperature & Top-P Effects** - Understanding sampling parameters' impact on outputs
- ✅ **Few-Shot Learning** - Demonstrating in-context learning with examples
- ✅ **Chain-of-Thought (CoT) Prompting** - Step-by-step reasoning for complex problems
- ✅ **Structured Output Control** - JSON and formatted response generation
- ✅ **Prompt Chaining** - Multi-step reasoning workflows
- ✅ **LLM-as-a-Judge** - Using LLMs to evaluate other LLM responses
- ✅ **Performance Visualization** - Comparing prompt variations quantitatively


## 📈 Experiments Explained

### 1. Pointwise vs. Pairwise Testing

**Pointwise Testing** evaluates a single prompt in isolation, useful for understanding baseline performance.

**Pairwise Testing** compares multiple prompt variations side-by-side, enabling direct comparison of effectiveness.

| Approach | Use Case | Example |
|----------|----------|---------|
| **Pointwise** | Initial prompt development | Testing a single sentiment analysis prompt |
| **Pairwise** | Prompt optimization | Comparing prompts with/without format constraints |

**Key Insight:** Pairwise testing reveals how subtle prompt changes (e.g., adding format constraints) can significantly alter model behavior.

---

### 2. Reference-Based vs. Reference-Free Testing

**Reference-Based Testing** compares LLM outputs against ground truth labels or expected responses.

**Reference-Free Testing** uses another LLM to evaluate responses without predefined correct answers.

| Method | Pros | Cons |
|--------|------|------|
| **Reference-Based** | Objective, measurable accuracy | Requires labeled data |
| **Reference-Free** | No labels needed, flexible | Subjective, may be inconsistent |

**Example Result:**
- Reference-based: `response == "mixed"` → ✅ Correct
- Reference-free: LLM judge evaluates response quality on a 1-4 scale

---

### 3. Factors Affecting Prompt Response

#### System Instructions
The system role/persona significantly influences output style and format:
- **Vague role:** `"You are an expert tweet sentiment analyzer."`
- **Specific role:** `"You are an expert tweet sentiment analyzer. You respond in a single word."`

**Impact:** More specific instructions lead to more constrained, predictable outputs.

#### Temperature Settings
Controls randomness in token sampling:

| Temperature | Behavior | Best For |
|-------------|----------|----------|
| `0.0` | Deterministic, most likely tokens | Factual tasks, consistency |
| `0.5-0.8` | Balanced creativity | General tasks |
| `> 0.9` | High randomness | Creative writing |

**Example:** Lower temperature (0.0) produces consistent sentiment labels; higher temperature (0.8) may vary.

#### Top-P (Nucleus Sampling)
Limits token selection to the top-p probability mass:

| Top-P | Effect | Use Case |
|-------|--------|----------|
| `0.1` | Very focused, narrow vocabulary | Precise, constrained outputs |
| `0.9` | Diverse, broader vocabulary | Creative, varied responses |

**Combined Effect:** `temperature=0.5, top_p=0.1` → focused, deterministic; `top_p=0.9` → more diverse outputs.

---

### 4. LLM As a Judge

Uses a separate LLM (e.g., Llama-3.3-70B) to evaluate responses from another model, providing:
- **Scalable evaluation** without human annotators
- **Flexible criteria** (relevance, helpfulness, accuracy)
- **Rating scales** (e.g., 1-4 for answer quality)

**Judge Prompt Structure:**
```
1. Define evaluation criteria
2. Provide rating scale (1-4)
3. Include question and answer
4. Request structured feedback
```

**Output Format:**
```
Feedback:::
Evaluation: [rationale]
Total rating: [1-4]
```

---

### 5. Few-Shot Learning

Demonstrates in-context learning by providing examples before the target task.

**Zero-Shot:**
```
Classify sentiment: "The product arrived damaged..."
```

**Few-Shot:**
```
Examples:
Review: I love this product! → positive
Review: This is terrible → negative
Review: The product is okay → neutral

Now classify: "The product arrived damaged..."
```

**Result:** Few-shot prompts often improve accuracy by clarifying expected format and task boundaries.

---

### 6. Chain-of-Thought (CoT) Prompting

Encourages step-by-step reasoning for complex problems.

**Standard Prompt:**
```
Solve: A store has 15 apples. They sell 6 in the morning and 4 in the afternoon. How many are left?
```

**CoT Prompt:**
```
Solve step by step:
1. Start with initial number
2. Subtract morning sales
3. Subtract afternoon sales
4. State final answer
```

**Benefit:** CoT improves accuracy on multi-step reasoning tasks by making intermediate steps explicit.

---

### 7. Output Format Control

Demonstrates structured output generation (JSON, formatted text).

**Example:**
```python
json_prompt = """Extract information and return as JSON:
{
  "name": "...",
  "age": ...,
  "occupation": "..."
}"""
```

**Result:** Models can reliably generate valid JSON when explicitly instructed, enabling programmatic parsing.

---

### 8. Prompt Templates & Best Practices

Three template patterns:

1. **Role-Based:** `Role: {role}\nTask: {task}\nInput: {input}`
2. **Instruction-Based:** `Instructions: {instructions}\nContext: {context}\nQuestion: {question}`
3. **Conversational:** `You are {role}. The user asks: {question}`

**Best Practices:**
- Be explicit about format requirements
- Use clear role definitions
- Provide context when needed
- Specify output constraints

---

### 9. Prompt Chaining

Multi-step workflows where each step builds on previous outputs:

```
Step 1: Extract topics → Step 2: Analyze relationships → Step 3: Generate summary
```

**Use Case:** Complex tasks requiring decomposition (e.g., research, analysis, summarization).

---

### 10. Performance Visualization

Quantitative comparison of prompt variations:

| Metric | Purpose |
|--------|---------|
| **Response Length** | Measure verbosity |
| **Response Time** | Assess latency |
| **Accuracy** | Evaluate correctness (with labels) |

**Visualization:** Bar charts comparing different prompt types across metrics.

---

## 📚 Key Concepts

### Pointwise vs. Pairwise Evaluation

- **Pointwise:** Evaluate one prompt at a time, measure absolute performance
- **Pairwise:** Compare multiple prompts, measure relative performance

### Reference-Based vs. Reference-Free

- **Reference-Based:** Requires ground truth labels (e.g., "mixed" sentiment)
- **Reference-Free:** Uses LLM judge or heuristics, no labels needed

### Temperature Effects

- **Low (0.0-0.3):** Deterministic, consistent outputs
- **Medium (0.5-0.7):** Balanced creativity and consistency
- **High (0.8-1.0):** Creative, varied outputs

### Top-P (Nucleus Sampling)

- **Low (0.1-0.3):** Focused vocabulary, predictable
- **Medium (0.5-0.7):** Balanced diversity
- **High (0.8-0.95):** Diverse vocabulary, creative

### Few-Shot Learning

- Provides examples in the prompt to guide model behavior
- More effective than zero-shot for complex or ambiguous tasks
- Trade-off: Longer prompts, higher token costs

### Chain-of-Thought (CoT)

- Explicitly requests step-by-step reasoning
- Improves performance on multi-step problems
- Can be combined with few-shot examples

---
