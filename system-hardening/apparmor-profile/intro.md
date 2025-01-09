# Introduction

In this scenario, you will learn how to use custom AppArmor profiles to enforce strict security policies on containers. The scenario has two objectives:

1. Deny all write operations within a container.
2. Prevent the container from executing `chmod` or `chown` commands to change file permissions or ownership.
3. Restrict network access to specific protocols (IPv4/IPv6).
4. Restrict Linux capabilities to limit privileged operations.

By the end of this exercise, you will understand how to create and apply AppArmor profiles that can restrict specific behaviors in containers, enhancing your cluster's security posture.
