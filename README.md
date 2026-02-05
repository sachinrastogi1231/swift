# Swift Producer–Consumer using AsyncStream & Actors

This project demonstrates a **producer–consumer pattern** implemented using **Swift Structured Concurrency**, specifically:

- `actor`
- `AsyncStream`
- `Task`
- `withTaskGroup`
- `AsyncStream.BufferingPolicy`

The goal is to show how to correctly connect a producer and a consumer **without manual locking, polling, or custom buffers**, while controlling throughput and buffering behavior.

---

## Overview

The system consists of:

- **Producer**
  - Produces integer values at a configurable rate
  - Publishes values via `AsyncStream`
  - Supports configurable buffering policies

- **Consumer**
  - Consumes values from `AsyncStream`
  - Processes values at a configurable rate

Both components are implemented as **actors**, ensuring safe access to internal state.

---

## Architecture
Producer ──yield──▶ AsyncStream ──for await──▶ Consumer

- `AsyncStream` acts as the **queue and synchronization point**
- No shared mutable state between producer and consumer
- Backpressure and buffering behavior are controlled via `AsyncStream.BufferingPolicy`

---

## Key Concepts Used

### Actors
- `Producer` and `Consumer` are `actor`s
- Guarantees data isolation and thread safety

### AsyncStream
- Used as a unidirectional async sequence
- Producer calls `yield`
- Consumer iterates using `for await`

### Buffering Policy

The producer supports configurable buffering behavior:

```swift
.bufferingNewest(bufferSize)
.unbounded
