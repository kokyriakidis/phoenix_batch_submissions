###############################################################################
##                             create input jsons                            ##
###############################################################################

## on personal computer...

# Generate toil json files from csv sample table

cd ~/Downloads/phoenix_batch_submissions/polishing/meryl_hybrid/hprc_int_asm_k31/meryl_hybrid_input_jsons

python3 /Users/kokyriakidis/Downloads/phoenix_batch_submissions/launch_from_table.py \
     --data_table ../HPRC_int_asm_batch2_3_4.samples.csv \
     --field_mapping ../meryl_hybrid_input_mapping.csv \
     --workflow_name meryl_hybrid

## add/commit/push to github (hprc_intermediate_assembly)

###############################################################################
##                             create launch meryl                      ##
###############################################################################

## check that github repo is up to date
git -C /private/groups/migalab/kkyriaki/phoenix_batch_submissions pull

## check that hpp production wdls github repo is up to date
git -C /private/home/kkyriaki/progs/hpp_production_workflows pull

# move to work dir
cd /private/groups/migalab/kkyriaki/hprc_polishing/hprc_int_asm/meryl_hybrid_k31

## get files to run in polishing folder ...
cp -r /private/groups/migalab/kkyriaki/phoenix_batch_submissions/polishing/meryl_hybrid/hprc_int_asm_k31/* ./

mkdir -p meryl_hybrid_submit_logs

## launch first 10

sbatch \
     launch_meryl_hybrid.sh \
     HPRC_int_asm_batch2_3_4.samples.csv
