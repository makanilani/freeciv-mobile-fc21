# OpenRouter Free Model Selection Report

**Date:** 2026-04-06  
**Purpose:** Select optimal free-tier OpenRouter models for each of the 5 Freeciv Mobile AI agent roles

---

## OpenRouter Free Tier Overview

- **28 free models** available (as of April 6, 2026)
- **Rate limits:** 20 requests/minute, 200 requests/day per model
- **5 distinct models** = ~1,000 daily requests total across all agents
- **No credit card required** — just an OpenRouter API key

---

## Top Free Models Evaluated

| Model | Provider | Context | Active Params | Key Strengths |
|-------|----------|---------|---------------|---------------|
| `qwen/qwen3.6-plus:free` | Qwen | 1.0M | MoE hybrid | SWE-bench 78.8, agentic coding, vision, front-end dev |
| `qwen/qwen3-coder:free` | Qwen | 262K | 35B/480B | Code-specialized, agentic coding, 480B params total |
| `nvidia/nemotron-3-super-120b-a12b:free` | NVIDIA | 262K | 12B/120B | Multi-agent RL training, 50% higher throughput, distributed systems |
| `stepfun/step-3.5-flash:free` | StepFun | 256K | 11B/196B | Speed-efficient MoE, rapid test cycles |
| `meta-llama/llama-3.3-70b-instruct:free` | Meta | 66K | 70B | General purpose, multilingual, well-tested |
| `openai/gpt-oss-120b:free` | OpenAI | 131K | 5.1B/117B | High-reasoning, agentic, function calling |
| `minimax/minimax-m2.5:free` | MiniMax | 197K | MoE | SWE-bench 80.2, office work, multi-agent teams |
| `qwen/qwen3-next-80b-a3b-instruct:free` | Qwen | 262K | 3B/80B | Fast, stable, tool use, RAG |

---

## Model Assignments by Agent Role

### 1. Project Lead → `qwen/qwen3.6-plus:free`

**Why:** #1 ranked free model across multiple categories. 1M context window is critical for reviewing large architecture documents and coordinating across all subsystems. 78.8% SWE-bench score demonstrates strong reasoning for complex decisions. Vision capabilities useful for reviewing UI mockups and architecture diagrams.

**Fallback:** `meta-llama/llama-3.3-70b-instruct:free`

### 2. Engine Architect → `qwen/qwen3-coder:free`

**Why:** Code-specialized 480B parameter model optimized for agentic coding. The C++ engine work requires deep code understanding, algorithm design, and performance optimization — exactly what this model was built for. 262K context handles large codebase analysis.

**Fallback:** `openai/gpt-oss-120b:free`

### 3. Mobile UI → `qwen/qwen3.6-plus:free`

**Why:** Strong front-end development capabilities with vision support. Can analyze wireframe images, UI mockups, and design documents. The "vibe coding" improvement in 3.6 Plus is particularly valuable for rapid UI prototyping in SwiftUI and Jetpack Compose.

**Fallback:** `minimax/minimax-m2.5:free`

### 4. Backend/Multiplayer → `nvidia/nemotron-3-super-120b-a12b:free`

**Why:** Multi-environment RL training across 10+ environments makes it ideal for distributed systems and networking code. 50% higher token throughput means faster iteration on WebSocket/Protocol Buffer implementations. Strong programming ranking (#10).

**Fallback:** `qwen/qwen3-next-80b-a3b-instruct:free`

### 5. QA/Integration → `stepfun/step-3.5-flash:free`

**Why:** Speed-efficient MoE with only 11B active parameters per token. Perfect for rapid test generation, CI/CD config validation, and documentation reviews where speed matters more than deep reasoning. 256K context handles full test suites.

**Fallback:** `nvidia/nemotron-3-nano-30b-a3b:free`

---

## Deprecated Models (DO NOT USE)

These models were in the old config but **no longer exist** on OpenRouter:

| Old Model ID | Status |
|--------------|--------|
| `nvidia/llama-3.1-nemotron-ultra-253b-v1:free` | Removed |
| `qwen/qwen3-32b:free` | Removed |

---

## Cost Analysis

All selected models are **$0** — permanently free tier on OpenRouter.

**Estimated daily usage:**
- Project Lead: ~40 requests/day (architecture reviews, coordination)
- Engine Architect: ~60 requests/day (C++ implementation, debugging)
- Mobile UI: ~50 requests/day (SwiftUI/Compose code, UI iteration)
- Backend: ~40 requests/day (networking, sync logic)
- QA: ~30 requests/day (test generation, review)
- **Total: ~220 requests/day** (within 1,000 daily limit across 5 models)

---

## Rate Limit Strategy

Each model has independent limits (20 req/min, 200 req/day). With 5 different models:
- **Burst capacity:** 100 requests/minute across all agents
- **Daily capacity:** 1,000 requests/day total
- **Shared models:** Project Lead and Mobile UI both use `qwen3.6-plus:free` (400 req/day combined limit)

If rate limits are hit:
1. Switch to fallback model for that role
2. Queue non-urgent requests
3. Monitor at https://openrouter.ai/activity
