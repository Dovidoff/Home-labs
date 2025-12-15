# Network
```mermaid
graph TD
    I[Internet]
    R[Router]
    S[Switch]
    H[Server]
    P[Pi-hole]
    W[Wi-Fi]
    
    I --> R
    R --> S
    R --> W
    S --> H
    H --> P
    
    W -.-> P
    H -.-> P
    P -.-> I
```
