# Congratulations

You have successfully created and applied AppArmor profiles to enforce security policies on containers in a Kubernetes environment.

## Key Achievements
- Implemented write operation restrictions
- Prevented unauthorized permission changes
- Configured network access controls
- Restricted Linux capabilities

## Troubleshooting Guide

### Common Issues and Solutions

1. **Profile Not Loading**
   - Error: `AppArmor parser error`
   - Solution: Check profile syntax using `apparmor_parser -Q /path/to/profile`
   - Verify profile path and permissions

2. **Permission Denied Errors**
   - Error: `Permission denied` in container logs
   - Solution: Review profile rules for the specific resource
   - Consider using audit mode to identify needed permissions

3. **Network Connectivity Issues**
   - Error: `Network unreachable`
   - Solution: Verify network rules in profile
   - Check if required capabilities are allowed

4. **Capability Restrictions Too Strict**
   - Error: `Operation not permitted`
   - Solution: Review capability restrictions
   - Add specific capabilities as needed

## Additional Resources
- [AppArmor Documentation](https://apparmor.net/documentation/)
- [Kubernetes AppArmor Guide](https://kubernetes.io/docs/tutorials/security/apparmor/)
- [AppArmor Profile Reference](https://gitlab.com/apparmor/apparmor/-/wikis/AppArmor_Core_Policy_Reference)

## Next Steps
- Explore advanced profile configurations
- Implement profile version control
- Set up centralized logging for AppArmor events
