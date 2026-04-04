###############################################################################
##                             create input jsons                            ##
###############################################################################

## on personal computer...

# Generate toil json files from csv sample table

cd /Users/kokyriakidis/Desktop/Paten_lab/phoenix_batch_submissions/polishing/meryl_hybrid/HG005/meryl_hybrid_input_jsons

python3 /Users/kokyriakidis/Downloads/phoenix_batch_submissions/launch_from_table.py \
     --data_table ../HG005.data_table.csv \
     --field_mapping ../meryl_hybrid_input_mapping.csv \
     --workflow_name meryl_hybrid

sed 's|\\u201c|"|g' HG005_hybrid_k21_meryl_hybrid.json | sed 's|\\u201d|"|g' > tmp ; mv tmp HG005_hybrid_k21_meryl_hybrid.json
sed 's|\\u201c|"|g' HG005_hybrid_k31_meryl_hybrid.json | sed 's|\\u201d|"|g' > tmp ; mv tmp HG005_hybrid_k31_meryl_hybrid.json
## add/commit/push to github (hprc_intermediate_assembly)

###############################################################################
##                             create launch meryl                      ##
###############################################################################

## check that github repo is up to date
git -C /private/groups/migalab/kkyriaki/phoenix_batch_submissions pull

## check that hpp production wdls github repo is up to date
git -C /private/home/kkyriaki/progs/hpp_production_workflows pull

# move to work dir
cd /private/groups/migalab/kkyriaki/hprc_polishing/polisher_evaluation/meryl_dbs/HG005_hybrid_dbs

## get files to run in polishing folder ...
cp -r /private/groups/migalab/kkyriaki/phoenix_batch_submissions/polishing/meryl_hybrid/HG005/* ./

mkdir -p meryl_hybrid_submit_logs

## launch 

sbatch \
     launch_meryl_hybrid.sh \
     HG005.data_table.csv
