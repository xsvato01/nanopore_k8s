# GPU-accelerated ONT Nanopore K8S basecalling 
## Run basecalling 

Computations are running from bioit proxy (use ssh to connect). Analysis is then deployed to k8s on kuba cluster.

1. Create folders for results, project and temps;
 add their location to zaloha_nextflow.config
 ```
 k8s {
...
   launchDir = 'PATH_TO_YOUR_LAUNCHDIR'
   projectDir = 'PATH_TO_LOCAL_CODE_FROM_GITHUB_REPO'
   workDir = 'PATH_TO_YOUR_TEMP'
...
}
```
2. Enter flowcell and kit specification along with path for fast5 files (parameter --data '../') 
Run the script as in the example bellow (run.sh)
```
nextflow kuberun xsvato01/nanopore_k8s/main.nf -r main -pod-image 'cerit.io/nextflow/nextflow:22.05.0' -c zaloha_nextflow.config  //
        --flowcell FLO-FLG001 --kit SQK-LSK110 --data '/mnt/shared/MedGen/ONTdata/k8s_testing/20220614_1150_MN16014_ais387_bfa74e7a/fast5_pass'
```
## Using the GPU-accelerated container in other pipelines
To use the preinstalled Guppy-GPU container in eg. Nextflow pipelines, use the container from
```
'registry.gitlab.ics.muni.cz:443/450402/nanopore_k8s:latest'
```
In Nextflow, you can facilitate this container by specifying it in the .config file or the actual script:
```
process XXX {
     accelerator XY
     container 'registry.gitlab.ics.muni.cz:443/450402/nanopore_k8s:latest'

    script:
      """
      guppy_basecaller ....
      """

}

```
where XY denotes the number of GPUs to facilitate (maximum 2); local_nextlow.config is already pre-set to use gpu-accelerated basecalling for any process starting with name GUPPY_*