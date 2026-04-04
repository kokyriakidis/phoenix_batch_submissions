###############################################################################
##                             create input jsons                            ##
###############################################################################
## workflow name = merfin

## on personal computer...

# Remove top up data from data table

mkdir -p ~/Downloads/phoenix_batch_submissions/workflows/merfin/merfin_input_jsons
cd ~/Downloads/phoenix_batch_submissions/workflows/merfin/merfin_input_jsons

python3 /Users/kokyriakidis/Downloads/phoenix_batch_submissions/launch_from_table.py \
     --data_table ../merfin.csv \
     --field_mapping ../merfin_input_mapping.csv \
     --workflow_name merfin

## add/commit/push to github (hprc_intermediate_assembly)

###############################################################################
##                             create launch workflow                      ##
###############################################################################

## on HPC...

## check that github repo is up to date
git -C  /private/groups/migalab/kkyriaki/phoenix_batch_submissions pull

# move to working dir
mkdir -p /private/groups/migalab/kkyriaki/phoenix_batch_executions/workflows/merfin
cd /private/groups/migalab/kkyriaki/phoenix_batch_executions/workflows/merfin

## get files
cp -r /private/groups/migalab/kkyriaki/phoenix_batch_submissions/workflows/merfin/* ./

mkdir -p slurm_logs
export PYTHONPATH="/private/home/juklucas/miniconda3/envs/toil/bin/python"

# submit job
sbatch \
     --job-name=merfin \
     --array=[2]%1 \
     --partition=high_priority \
     --time=12:00:00 \
     --cpus-per-task=32 \
     --exclude=phoenix-[09,10,22,23,24,18] \
     --mem=400gb \
     --mail-type=FAIL,END \
     --mail-user=kkyriaki@ucsc.edu \
     /private/groups/hprc/hprc_intermediate_assembly/hpc/toil_sbatch_single_machine.sh \
     --wdl ~/progs/hpp_production_workflows/QC/wdl/tasks/merfin.wdl \
     --sample_csv merfin.csv \
     --input_json_path '../merfin_input_jsons/${SAMPLE_ID}_merfin.json'
