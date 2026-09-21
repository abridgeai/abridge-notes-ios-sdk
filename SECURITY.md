# Security Policy

This repository distributes a compiled binary of the Abridge Ambient Notes SDK
for iOS. The source lives in a private Abridge repository, so reports here are
triaged against source you cannot see; the more concrete the report, the faster
we can confirm it.

## Supported Versions

There are no long-term support branches. Supported means the most recent
release tag, plus any earlier tag an integration partner is currently pinned
to — consumers pin an exact version, so the newest tag is often not the one
running in the field, and we would rather hear about the one that is.

| Version | Supported |
| ------- | --------- |
| Most recent release tag | Yes |
| An earlier tag a partner is pinned to | Yes |
| Any other earlier tag | No |

If you are pinned to an older tag, upgrading first is still worth it — the
issue may already be fixed.

## Reporting a Vulnerability

**Please do not report security vulnerabilities through public GitHub issues,
pull requests, discussions, or any other public forum.** Public disclosure
before a fix is available puts the broader community at risk.

### Preferred Method: GitHub Private Vulnerability Reporting

The preferred way to report a vulnerability is using the **Report a
vulnerability** button on the [Security tab](../../security/advisories/new) of
this repository. This opens a private, encrypted channel directly with the
maintainers and allows us to collaborate on a fix before any public disclosure.

If you are unfamiliar with the process, GitHub's documentation walks through
each step:
[Privately reporting a security vulnerability](https://docs.github.com/en/code-security/security-advisories/guidance-on-reporting-and-writing-information-about-vulnerabilities/privately-reporting-a-security-vulnerability)

## What to Include in Your Report

To help us triage and respond as quickly as possible, please include as much of
the following as you can:

- A description of the vulnerability and its potential impact
- The affected release tag(s), and the `AbridgeClient.version` you observed
- Step-by-step instructions to reproduce the issue
- Proof-of-concept code or a working exploit, if available
- Any relevant logs, screenshots, or supporting material, **with patient data
  removed** — see below
- Your assessment of severity (Critical / High / Medium / Low)

The more detail you provide, the faster we can validate and address the issue.

### Do not send us patient data

This SDK records and uploads clinical encounter audio. If reproducing an issue
produced real audio, transcripts, notes or identifiers, **do not attach them**.
Describe what you saw and we will reproduce it against our own test tenant. If
you believe you have encountered another party's data, say so in the report
immediately and stop reproducing.

## Credit and Acknowledgment

We believe in recognizing the researchers who help keep this project secure.
Unless you request otherwise, we will credit you by name (or handle) in the
published security advisory. If you prefer to remain anonymous, please let us
know in your report.

## Bug Bounty

**This project does not currently operate a bug bounty program and does not
offer monetary rewards for vulnerability reports.** We are grateful for the
time and effort security researchers invest in responsibly disclosing issues,
and we acknowledge contributions publicly as described above.

We are not ruling out a bug bounty program in the future. If that changes, this
document will be updated accordingly.

## Scope and Out-of-Scope Issues

### In Scope

- Vulnerabilities in the released `AbridgeNotes.xcframework` at a supported tag
- Authentication or authorization flaws, including anything that lets one
  tenant reach another tenant's data
- Sensitive data exposure, including clinical audio, transcripts or notes
  reachable by a party that should not have them
- Weaknesses in how the SDK stores, encrypts or transmits encounter data
- Privilege escalation

### Out of Scope

The following are generally not considered in-scope security vulnerabilities
for this project:

- Vulnerabilities in third-party components redistributed inside the framework
  (see NOTICE) — please report these to the upstream maintainer as well, though
  we do want to know if a shipped version is affected
- Issues only reproducible with a non-supported tag
- Issues flagged solely by automated security scanners without a clear proof of
  exploitability — please validate findings before reporting
- Findings that amount to recovering the SDK's own structure — symbol names,
  type names or API shape from the shipped binary and its debug symbols. The
  debug symbols are published deliberately so integrators can symbolicate
  crashes, and they name our types by design. Absolute build paths are *not*
  in that category: if you find one, we want to know.
- Social engineering or phishing attacks against maintainers or users
- Denial-of-service attacks requiring sustained access or resources beyond what
  a legitimate user would have

If you are unsure whether an issue is in scope, please report it privately and
we will let you know.

## Security Update Notifications

Security advisories are published under the
[Security tab](../../security/advisories) of this repository. To receive
notifications, watch this repository and select **Security alerts** from the
notification options.
