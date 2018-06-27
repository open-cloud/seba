# NEM Services Charts 

The helm charts contained in this directory correspond to the
individual services that are configured into various SEBA profiles.
These synchronizer containers technically run as part of NEM.

> **Note:** The `seba-service` corresponds to a synchronizer
> that manages subscribers, which is technically modeled as
> yet another service.  The chart still refers to `rcord` but this
> needs to be updated to `seba`.
