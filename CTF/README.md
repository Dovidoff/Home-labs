About this CTF
--------------

This Capture The Flag (CTF) challenge was created as a **hands-on learning lab** focusing on practical techniques in **cryptography, steganography, file forensics, and web analysis**.The goal of the CTF is not speed, but **understanding** each step is designed to teach a specific concept commonly used in cybersecurity and digital forensics.

The challenge follows a **progressive, multi-layered structure**, where each solved task reveals the next clue. No step can be skipped, and no guessing is required if the participant carefully analyzes the provided artifacts.

This CTF was built and tested in a controlled environment and is intended for:

*   Cybersecurity students
    
*   Home lab practice
    
*   CTF beginners and intermediate learners
    
*   Academic demonstrations and submissions
    

Design Philosophy
-----------------

The CTF is intentionally designed to simulate **real-world investigation workflows** rather than isolated puzzles. Participants are expected to:

*   Inspect files instead of trusting extensions
    
*   Analyze hidden data rather than visible content
    
*   Combine multiple tools and techniques
    
*   Think like a forensic analyst, not just a puzzle solver
    

Each part increases slightly in complexity and introduces new concepts while reinforcing previous ones.

Challenge Structure
-------------------

### Part 1 – Web & Image Analysis

Focuses on **investigation and observation**.

Participants must:

*   Repair a corrupted PNG file using hex analysis
    
*   Extract a QR code to access a hidden web-based CTF page
    
*   Inspect HTML and client-side files for hidden clues
    
*   Analyze an image using LSB steganography
    
*   Decrypt a Caesar-encrypted message using Python
    

This part teaches:

*   File signatures (magic bytes)
    
*   Web inspection techniques
    
*   Basic steganography
    
*   Classical cryptography
    

### Part 2 – Hashing & Symmetric Encryption

Focuses on **verification and logical decryption**.

Participants must:

*   Verify integrity using MD5 hashing
    
*   Identify and decrypt XOR-encrypted data using a discovered password
    
*   Understand how weak encryption behaves in practice
    

This part teaches:

*   Hash verification
    
*   XOR encryption weaknesses
    
*   Password reuse risks
    

### Part 3 – Audio Steganography & Archive Cracking

Focuses on **advanced analysis and tool usage**.

Participants must:

*   Analyze an audio file using a spectrogram to extract hidden data
    
*   Use the extracted information to crack a protected archive
    
*   Decrypt the final payload using Python-based cryptography
    

This part teaches:

*   Audio steganography
    
*   Password-protected archives
    
*   Practical Python cryptography usage
    

Tools & Techniques Used
-----------------------

Throughout the CTF, participants may use tools such as:

*   Hex editors
    
*   Web browser developer tools
    
*   Steganography analysis tools
    
*   Hash generators
    
*   Python scripts for decryption
    
*   Audio analysis software (spectrograms)
    

All tools used are either open-source or freely available.

Learning Outcomes
-----------------

After completing this CTF, participants should have a better understanding of:

*   How data can be hidden in files
    
*   Why file integrity and validation matter
    
*   How simple cryptographic methods work (and fail)
    
*   How multiple small clues combine into a full investigation
    
*   How real-world CTFs and forensic challenges are structured
    

Disclaimer
----------

This CTF is created **for educational purposes only**.All files, passwords, and challenges are intentionally constructed for learning and do not represent real-world vulnerabilities.# Capture The Flag – Crypto & Steganography Lab

This repository contains a three-part Capture The Flag (CTF) challenge
focused on cryptography, steganography, hashing, and file analysis.

The CTF is designed as a learning lab and academic submission.

## Notes:
The instructions file is in swedish and the english version comming soon. 

## How to start
The challenge begins with a corrupted image file:

![fixme](https://github.com/user-attachments/assets/5f3beea7-3551-4157-97d8-c4ec312e178f)


