###############################################################################
##                             create input jsons                            ##
###############################################################################
## workflow name = pepperMarginDeepVariant

## on personal computer...

# Remove top up data from data table

mkdir -p ~/Downloads/phoenix_batch_submissions/polishing/pepperMarginDeepVariant/pepperMarginDeepVariant_input_jsons
cd ~/Downloads/phoenix_batch_submissions/polishing/pepperMarginDeepVariant/pepperMarginDeepVariant_input_jsons

python3 /Users/kokyriakidis/Downloads/phoenix_batch_submissions/launch_from_table.py \
     --data_table ../pepperMarginDeepVariant.csv \
     --field_mapping ../pepperMarginDeepVariant_input_mapping.csv \
     --workflow_name pepperMarginDeepVariant

## add/commit/push to github (hprc_intermediate_assembly)

###############################################################################
##                             create launch workflow                      ##
###################''############################################################

## on HPC...

## check that github repo is up to date
git -C  /private/groups/migalab/kkyriaki/phoenix_batch_submissions pull

# move to working dir
mkdir -p /private/groups/migalab/kkyriaki/hprc_polishing/y2_alt_polishers/pepperMarginDeepVariant
cd /private/groups/migalab/kkyriaki/hprc_polishing/y2_alt_polishers/pepperMarginDeepVariant

## get files
cp -r /private/groups/migalab/kkyriaki/phoenix_batch_submissions/polishing/pepperMarginDeepVariant/* ./

mkdir -p slurm_logs
export PYTHONPATH="/private/home/juklucas/miniconda3/envs/toil/bin/python"

# submit job
sbatch \
     --job-name=pepperMarginDeepVariant \
     --array=[1]%1 \
     --partition=long \
     --time=48:00:00 \
     --cpus-per-task=32 \
     --exclude=phoenix-[09,10,22,23,24,18] \
     --mem=800gb \
     --mail-type=FAIL,END \
     --mail-user=kkyriaki@ucsc.edu \
     /private/groups/hprc/hprc_intermediate_assembly/hpc/toil_sbatch_single_machine.sh \
     --wdl ~/progs/hpp_production_workflows/QC/wdl/tasks/pepperMarginDeepVariant.wdl \
     --sample_csv pepperMarginDeepVariant.csv \
     --input_json_path '../pepperMarginDeepVariant_input_jsons/${SAMPLE_ID}_pepperMarginDeepVariant.json'
