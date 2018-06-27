# NEM Profile Charts 

The helm charts contained in this directory correspond to different 
profiles (configurations) of SEBA. We anticipate three, but only the first 
is supported today:

* `seba-bng-agg`: SEBA with BNG implemented in the aggregate switches (supported). 
* `seba-bng-olt`: SEBA with BNG implemented in the OLT devices (future). 
* `seba-no-bng`: SEBA with no BNG, that is, assumed external (future). 

These profiles result in a set of synchronizer containers that technically run as 
part of NEM. 

